From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Dec 2010 19:30:49 +0000
Subject: ks8695_gettimeoffset
In-Reply-To: <4D0FA9FB.3060309@softplc.com>
References: <4D0FA9FB.3060309@softplc.com>
Message-ID: <20101220193049.GI28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 01:09:47PM -0600, Dick Hollenbeck wrote:
> >From userspace, printing the return values from a rapid looping
> sequence of calls to
> 
>    clock_gettime( CLOCK_MONOTONIC, &now );
> 
> leads me to believe that kernel function ks8695_gettimeoffset() is
> not worth anything.

That'll be because clock_gettime(CLOCK_MONOTONIC) doesn't use the old
gettimeoffset() method to correct the returned time - none of the POSIX
timers use the old gettimeoffset() stuff, only gettimeofday() does.

Platforms really should be using the clocksource/clockevents code
where ever possible, rather than selecting ARCH_USES_GETTIMEOFFSET.

Does someone with a KS8695-based platform want to have a go at
converting it over to clocksource/clockevents?
