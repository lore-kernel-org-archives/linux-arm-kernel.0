From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 15 Sep 2009 23:04:37 +0200
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <1253043875.3273.131.camel@linux-1lbu> (Steve Chen's message of
	"Tue, 15 Sep 2009 14:44:35 -0500")
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<20090915103739.GA19519@elf.ucw.cz>
	<1253017761.3273.117.camel@linux-1lbu>
	<200909151541.08852.marek.vasut@gmail.com>
	<1253032210.3273.128.camel@linux-1lbu>
	<94a0d4530909151158y489a96e3x63ff932c713822b0@mail.gmail.com>
	<1253043875.3273.131.camel@linux-1lbu>
Message-ID: <m3k4zzdimy.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Steve Chen <schen@mvista.com> writes:

> +config OLD_CPU_DELAY
> +	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
> +	bool "Accurate delays"
> +	def_bool n
> +	help
> +	  Enable if observing longer than expected delays and need more
> +	  accuracy.  This only applies to older CPUs.
> +

If it's that simple then why not enable the extra delay code
unconditionally when compiling for those CPUs?

We don't need "do something better" options.
-- 
Krzysztof Halasa
