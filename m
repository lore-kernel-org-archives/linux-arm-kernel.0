From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 7 Mar 2013 08:37:17 +0100
Subject: [PATCH 01/16] ARM: b.L: secondary kernel entry code
In-Reply-To: <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130307073717.GA28982@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1579,6 +1579,12 @@ config HAVE_ARM_TWD
>  	help
>  	  This options enables support for the ARM timer and watchdog unit
>  
> +config BIG_LITTLE
> +	bool "big.LITTLE support (Experimental)"
> +	depends on CPU_V7 && SMP && EXPERIMENTAL
> +	help
> +	  This option enables support for the big.LITTLE architecture.
> +

Perhaps few lines of what big.LITTLE is would be nice here?

It is that "few high-performance cores + few low-power cores" on chip, right?

BTW... is it possible/good idea to run all the cores at the same time for 
max performance? From descriptions I understood that is not normally done
and I'd like to understand why....

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
