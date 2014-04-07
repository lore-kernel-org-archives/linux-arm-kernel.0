From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 7 Apr 2014 23:43:36 +0200
Subject: [PATCH 1/4] ata: ahci_mvebu: new driver for Marvell Armada 380
 AHCI interfaces
In-Reply-To: <2819007.7Vym3v6BRo@amdc1032>
References: <1396882664-19297-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1396882664-19297-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <2819007.7Vym3v6BRo@amdc1032>
Message-ID: <20140407234336.6305681b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bartlomiej Zolnierkiewicz,

On Mon, 07 Apr 2014 19:50:06 +0200, Bartlomiej Zolnierkiewicz wrote:

> > +static struct platform_driver ahci_mvebu_driver = {
> > +	.probe = ahci_mvebu_probe,
> > +	.remove = ata_platform_remove_one,
> > +	.driver = {
> > +		.name = "ahci-mvebu",
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = ahci_mvebu_of_match,
> 
> Why is the Power Management support missing from this driver?

Because as of today, the only platform that can use this driver is the
Armada 38x, and we don't yet have suspend/resume support for this
platform: we haven't written yet the suspend to RAM code for it. And I
wanted to avoid adding suspend/resume code that I'm not able to test.

So my plan is to get back to PM support once we have working suspend to
RAM support on Armada 38x.

> > +MODULE_DESCRIPTION("Marvell EBU AHCI SATA driver");
> > +MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:ahci_mv");
> 
> platform:ahci_mvebu ?

Indeed, thanks for spotting.

> Otherwise it looks good.

Thanks for the review!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
