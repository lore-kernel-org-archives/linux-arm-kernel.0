From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 25 Sep 2013 14:49:56 +0200
Subject: [RFC PATCH 09/15] ata: ti_sata: Add Texas Instruments SATA Wrapper
 driver
In-Reply-To: <5608096.0pgFIteLqQ@amdc1032>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-10-git-send-email-rogerq@ti.com>
 <5608096.0pgFIteLqQ@amdc1032>
Message-ID: <3930265.gHe05HETI5@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 25, 2013 02:37:19 PM Bartlomiej Zolnierkiewicz wrote:

[...]

> > +#ifdef CONFIG_PM
> > +
> > +static int ti_sata_resume(struct device *dev)
> > +{
> > +	pm_runtime_disable(dev);
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_enable(dev);
> 
> This doesn't look like a correct ->resume method:
> * it shouldn't touch runtime PM at all
> * for each ->resume method there should be a corresponding ->suspend method
> 
> Moreover this whole wrapper driver seems strange, why not just add a proper
> runtime PM support to ahci_platform driver instead?

Hmm, even this shouldn't be needed as this wrapper driver doesn't have
->runtime_suspend and ->runtime resume methods.

What exactly is the purpose of the existence of this wrapper driver?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
