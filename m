From: olof@lixom.net (Olof Johansson)
Date: Sun, 25 Nov 2012 05:56:58 -0800
Subject: OMAP build now completely broken in latest arm-soc
In-Reply-To: <20121125093704.GV3332@n2100.arm.linux.org.uk>
References: <20121125093704.GV3332@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMgvGxfghFbyki7aXE8dVbAA7QQP6nwBKhzHftngGRi0Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 25, 2012 at 1:37 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Not much more to say...
>
> arch/arm/plat-omap/i2c.c:35:1: error: expected identifier or '(' before '<<' token

Hmm. In for-next, line 35 is a blank line.

Could this be because of a merge conflict in your local version? This
is one of the files that has conflicts with mainline right now; I'll
look to see if we can resolve those in our tree later today.


> But also, the:
>
> arch/arm/mach-omap2/timer.c:163:28: warning: 'omap_counter_match' defined but not used
>
> warning is still there.

There's a fix for this in Tony's tree, but he hasn't sent up the pull
request for it yet.


-Olof
