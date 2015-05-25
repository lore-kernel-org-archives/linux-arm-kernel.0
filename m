From: pavel@denx.de (Pavel Machek)
Date: Mon, 25 May 2015 14:41:33 +0200
Subject: [PATCH v4 1/2] ARM: socfpga: support suspend to ram
In-Reply-To: <1432317735-29413-2-git-send-email-atull@opensource.altera.com>
References: <1432317735-29413-1-git-send-email-atull@opensource.altera.com>
 <1432317735-29413-2-git-send-email-atull@opensource.altera.com>
Message-ID: <20150525124133.GF9943@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Suspend-to-RAM and EDAC support are mutually exclusive on SOCFPGA
> platforms.  CONFIG_SOCFPGA_SUSPEND enables suspend-to-RAM and
> prevents selecting CONFIG_EDAC_ALTERA_MC.

Do we went to have the dependency at the .config time? We would like
to do generic kernels booting on many machines, this kind of breaks
that...

> +	/*
> +	 * This code assumes that the bootloader has already
> +	 * properly configured the sdram controller:

Which bootloaders can do that? 

> +	 * sdr.ctrlcfg.lowpwreq.selfrfshmask = 3
> +	 * sdr.ctrlcfg.lowpwrtiming.clkdisablecycles = 8
> +	 * sdr.ctrlcfg.dramtiming4.selfrfshexit = 512

Would it make sense to configure it in Linux?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
