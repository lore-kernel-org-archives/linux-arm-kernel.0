From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 17:45:13 +0200
Subject: [PATCH 23/29] ARM: orion5x: use DT to describe NOR on edmini_v2
In-Reply-To: <20140413153150.GD10033@lunn.ch>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-24-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140413153150.GD10033@lunn.ch>
Message-ID: <20140413174513.2e39a55c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sun, 13 Apr 2014 17:31:50 +0200, Andrew Lunn wrote:

> > -/*****************************************************************************
> > - * 512KB NOR Flash on BOOT Device
> > - ****************************************************************************/
> > -
> > -/*
> > - * Currently the MTD code does not recognize the MX29LV400CBCT as a bottom
> > - * -type device. This could cause risks of accidentally erasing critical
> > - * flash sectors. We thus define a single, write-protected partition covering
> > - * the whole flash.
> > - * TODO: once the flash part TOP/BOTTOM detection issue is sorted out in the MTD
> > - * code, break this into at least three partitions: 'u-boot code', 'u-boot
> > - * environment' and 'whatever is left'.
> > - */
> 
> Hi Thomas
> 
> Did you check if this is still true? If it is fixed, maybe now would
> be a good time to swap to three partitions?

I don't know, and since the NOR contains the bootloader, and I'm not
sure those Orion devices support UART booting, I clearly don't want to
play too much with NOR writing, as I don't want to brick the only two
Orion platforms that I have. So I'd prefer to leave the functionality
as it was, and leave it to other more adventurous and interested people
the work on improving this.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
