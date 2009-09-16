From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 16 Sep 2009 14:30:01 +0200
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <1253089566.3273.152.camel@linux-1lbu> (Steve Chen's message of
	"Wed, 16 Sep 2009 03:26:06 -0500")
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<20090915103739.GA19519@elf.ucw.cz>
	<1253017761.3273.117.camel@linux-1lbu>
	<200909151541.08852.marek.vasut@gmail.com>
	<1253032210.3273.128.camel@linux-1lbu>
	<94a0d4530909151158y489a96e3x63ff932c713822b0@mail.gmail.com>
	<1253043875.3273.131.camel@linux-1lbu>
	<m3k4zzdimy.fsf@intrepid.localdomain>
	<1253053609.3273.139.camel@linux-1lbu>
	<m33a6nddvd.fsf@intrepid.localdomain>
	<1253089566.3273.152.camel@linux-1lbu>
Message-ID: <m3ljkfoywm.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Steve Chen <schen@mvista.com> writes:

> +config OLD_CPU_DELAY
> +	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
> +	bool "Accurate delays for some older CPUs"
> +	def_bool n
> +	help
> +	  Try enable this if observing longer than expected delays and need
> +	  more accuracy.  May cause instability in some CPUs.
> +

There is still this uncertain "accurate" in the text. Why don't just

+	bool "Different delay() code for some older CPUs"
-- 
Krzysztof Halasa
