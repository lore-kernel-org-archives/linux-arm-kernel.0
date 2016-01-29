From: broonie@kernel.org (Mark Brown)
Date: Fri, 29 Jan 2016 12:35:18 +0100
Subject: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D63FBF8B@penmbx01>
References: <1453863463-30515-1-git-send-email-wenyou.yang@atmel.com>
 <1453863463-30515-2-git-send-email-wenyou.yang@atmel.com>
 <20160129001603.GM4130@sirena.org.uk>
 <B256D81BAE5131468A838E5D7A243641D63FBF8B@penmbx01>
Message-ID: <20160129113518.GQ4130@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 01:20:08AM +0000, Yang, Wenyou wrote:

> > > +static const struct of_device_id act8945a_pmic_of_match[] = {
> > > +	{ .compatible = "active-semi,act8945a-regulator" },
> > > +	{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, act8945a_pmic_of_match);

> > This seems mostly OK but why do we have a compatible string here - shouldn't
> > the MFD be able to instantiate the regulator function without needing this?

> Because I got feedback from Javier for the act8945a-charger patches of this MFD series,
> He said missing the OF match table will cause the module autoloading broken. 

> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/398113.html

> What do you think about it?

If then device is not being loaded from the DT (and it shouldn't be, the
device looks like it should be instantiated directly by the MFD as it
can't exist separately to that MFD) an OF table will do nothing.  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/04fd078b/attachment.sig>
