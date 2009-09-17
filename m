From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 17 Sep 2009 22:37:23 +0100
Subject: [PATCH v2] arm: remove unused code in delay.S
In-Reply-To: <1253222978.3273.236.camel@linux-1lbu>
References: <1253017761.3273.117.camel@linux-1lbu>
	<200909151541.08852.marek.vasut@gmail.com>
	<1253032210.3273.128.camel@linux-1lbu>
	<94a0d4530909151158y489a96e3x63ff932c713822b0@mail.gmail.com>
	<1253043875.3273.131.camel@linux-1lbu>
	<m3k4zzdimy.fsf@intrepid.localdomain>
	<20090916134721.GA11218@n2100.arm.linux.org.uk>
	<20090917193257.GA10599@shareable.org>
	<20090917194119.GA12510@n2100.arm.linux.org.uk>
	<1253222978.3273.236.camel@linux-1lbu>
Message-ID: <20090917213723.GC10599@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Steve Chen wrote:
> +	help
> +	  Enable this if observing longer than expected delays.  This code
> +	  improves delay accuracy for some CPUs.  However, it can also cause
> +	  delay duration to be too short for others which leads to stability
> +	  issues.
> +
> +	  In other words, do not enable unless you can guarantee that the
> +	  processor (or ALL of the processors if building a generic kernel)
> +	  delays for at least the time requested after enabling.
> +
>  endmenu

It would be very helpful to mention which CPUs are affected.
Ok, we don't know exactly...

But Russell has stated that ARM610 and ARM710 benefit from enabling
the code, and that it specifically must not be enabled for StrongARM.

Here's an additional paragraph to add on the end:

	ARM610 and ARM710 are known to benefit from enabling this option.
	It should not be enabled for StrongARMs, because it is known
	to produce too short delays on those.

Maybe you can adjust the config selectors and default to match?

-- Jamie
