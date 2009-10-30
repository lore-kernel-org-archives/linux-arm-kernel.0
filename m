From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Oct 2009 16:23:12 +0000
Subject: Where do we place common Kconfig options between a "few"
	machine types?
In-Reply-To: <9383297B60843144AC17878B479520F110AF05A8C3@SJEXCHCCR01.corp.ad.broadcom.com>
References: <20091030103104.GA32622@n2100.arm.linux.org.uk>
	<9383297B60843144AC17878B479520F110AF05A8C3@SJEXCHCCR01.corp.ad.broadcom.com>
Message-ID: <20091030162312.GA5592@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2009 at 09:13:21AM -0700, Scott Branden wrote:
> Russell (or others),

As a general point, many people use email clients which don't like
long lines; please manually wrap at around column 72.  Thanks.

> We have a few Kconfig options that are shared between different machines.
> Where do we place these Kconfig options?
> 
> It seems like others have placed these options in the arch/arm/Kconfig
> and then added depends on for their particular machine architectures.
> This seems quite messy to me as the Kconfigs only apply to a few machines.
> 
> Does something like this make sense: place machine specific Kconfig
> settings in mach-bcmring, mach-bcm1234, mach-bcm5678 and then place
> the common settings in another Kconfig file in a "mach-bcmcommon"
> directory.

Erm, if you're creating one mach- directory per "machine", and the machines
are all fairly similar, then you're not doing things quite right.  There
really isn't a very good name for these directories, so please don't read
too much into the prefix.

Most mach-* directories are used to hold all machines for a particular
group of SoCs.  So, for instance, you'll find all the Atmel SoC support
code in mach-at91, all the PXA SoC support in mach-pxa, etc.

Getting that right should help solve your problem.
