From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 13 Apr 2010 10:25:14 +0200
Subject: [PATCH 1/2 v2] AT91: taskit PortuxG20 and Stamp9G20 board support
In-Reply-To: <1268916069-21639-1-git-send-email-christian.glindkamp@taskit.de>
References: <20100318115333.GD19544@n2100.arm.linux.org.uk>
	<1268916069-21639-1-git-send-email-christian.glindkamp@taskit.de>
Message-ID: <v2qcd73a99e1004130125y5daef203n241dfc130f7dcfb9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Christian,

> Both boards share the same board file, as the PortuxG20 is basically an
> SBC based on the Stamp9G20.

> +config MACH_PORTUXG20
> + ? ? ? bool "taskit PortuxG20"
> + ? ? ? depends on ARCH_AT91SAM9G20
> + ? ? ? help
> + ? ? ? ? Select this if you are using taskit's PortuxG20.
> + ? ? ? ? <http://www.taskit.de/en/>
> +
> +config MACH_STAMP9G20
> + ? ? ? bool "taskit Stamp9G20 CPU module"
> + ? ? ? depends on ARCH_AT91SAM9G20
> + ? ? ? help
> + ? ? ? ? Select this if you are using taskit's Stamp9G20 CPU module on its
> + ? ? ? ? evaluation board.
> + ? ? ? ? <http://www.taskit.de/en/>

Please remove the "depends on ARCH_AT91SAM9G20" lines.
These configuration options are in an "if ARCH_AT91SAM9G20" section,
so the "depends on" are no longer needed.

Otherwise, the patches looks fine.
  Acked-by:  Andrew Victor <linux@maxim.org.za>

Please submit the patches to Russell King's patch-tracking system.
Thanks.


Regards,
 Andrew Victor
