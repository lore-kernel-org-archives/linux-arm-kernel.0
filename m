From: cl@linux.com (Christoph Lameter)
Date: Thu, 20 Mar 2014 09:06:34 -0500 (CDT)
Subject: [linux-next][regression] [PATCH] percpu: add preemption checks
 to __this_cpu ops
In-Reply-To: <20140318143759.04a892434d84a9fd3aa94262@linux-foundation.org>
References: <53285FE7.5010203@ti.com>
 <alpine.DEB.2.10.1403180922050.17965@nuc> <53286ABF.3040408@ti.com>
 <alpine.DEB.2.10.1403181053110.23935@nuc>
 <20140318143759.04a892434d84a9fd3aa94262@linux-foundation.org>
Message-ID: <alpine.DEB.2.10.1403200905070.4107@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Mar 2014, Andrew Morton wrote:

> > snprintf can cause hangs.
>
> This is weird.  How the heck can snprintf() fail if called too early?
> All it does is shuffle chars around in memory.  The only external
> dependency I'm seeing is a WARN_ON() which presumably didn't trigger
> anyway.
>
> I'm suspecting a misdiagnosis here.  Otherwise, we seriously need to
> fix snprintf(), not work around it!
>
> Also, what does "before checking error conditions" refer to?  Does this
> mean you know why snprintf() failed??

No I dont. I only know that this fixes Grygorii's issues. There could be
numerous arch specific per cpu setup issues going on that may impact on
snprintf.

If I move it behind the checks then I can avoid using snprintf.
