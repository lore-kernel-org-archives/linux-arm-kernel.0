From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Tue, 8 May 2012 20:38:35 +0000
Subject: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E9B6681@DBDE01.ent.ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
 <20120426191159.GA9415@sirena.org.uk>
 <CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
 <20120427175657.GP18260@opensource.wolfsonmicro.com>	<87397o3n4y.fsf@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9B1A67@DBDE01.ent.ti.com>
 <87mx5jy2li.fsf@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9B6681@DBDE01.ent.ti.com>
Message-ID: <EF62F09C0797D947AD4180A1043C0DF73C40BCE1@DLEE10.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > >> The only thing the higher-level layers might potentially need to do
> > >> is to enable/disable AVS around transitions (e.g. when changing OPP, > > >> AVS is disabled before changing OPP and only re-enabled when the new > >> >> nominal voltage has been acheived.)

Getting clean baseline in place is huge step but actual production interfaces will need to comprehend some OPP to AVS dependencies beyond on/off.

AVS as used in many OMAP designs (mostly > OMAP4430) do have some per OPP dependent details:

- Multiple PMICs are in use. In some current designs the AVS step size is different per voltage range. At OPP change time you have to reconfigure several AVS parameters before enable.

- ABB-ldo sequencing and parameters in tightly coupled with OPP and AVS enables.

- Good power savings can be had in future 1.5/3.5 by adjusting nominal to calibrated-plus-margin voltage.

Regards,
Richard W.
