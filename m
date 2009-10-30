From: sbranden@broadcom.com (Scott Branden)
Date: Fri, 30 Oct 2009 09:13:21 -0700
Subject: Where do we place common Kconfig options between a "few"
	machine types?
In-Reply-To: <20091030103104.GA32622@n2100.arm.linux.org.uk>
Message-ID: <9383297B60843144AC17878B479520F110AF05A8C3@SJEXCHCCR01.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell (or others),

We have a few Kconfig options that are shared between different machines.  Where do we place these Kconfig options?

It seems like others have placed these options in the arch/arm/Kconfig and then added depends on for their particular machine architectures.  This seems quite messy to me as the Kconfigs only apply to a few machines.

Does something like this make sense: place machine specific Kconfig settings in mach-bcmring, mach-bcm1234, mach-bcm5678 and then place the common settings in another Kconfig file in a "mach-bcmcommon" directory.  

mach-bcmring/Kconfig
mach-bcm1234/Kconfig
mach-bcm5678/Kconfig
mach-bcmcommon/Kconfig

The problem is mach-bcmcommon is not a machine type but just a place to keep these common settings out of the main arch/arm/Kconfig file.  Perhaps it needs a different name?

I don't know what the best solution is right now.  Should these "common" Kconfig settings go in arch/arm/Kconfig, arch/arm/mach-bcmcommon/Kconfig, or some other location?

Regards,
 Scott
