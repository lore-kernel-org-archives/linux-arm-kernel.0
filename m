From: mporter@linaro.org (Matt Porter)
Date: Tue, 11 Mar 2014 11:47:50 -0400
Subject: [PATCH v2 3/5] regulator: add bcm590xx regulator driver
In-Reply-To: <20140219045232.GD2669@sirena.org.uk>
References: <1392765432-9111-1-git-send-email-mporter@linaro.org>
 <1392765432-9111-4-git-send-email-mporter@linaro.org>
 <20140219045232.GD2669@sirena.org.uk>
Message-ID: <20140311154750.GI25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 01:52:32PM +0900, Mark Brown wrote:
> On Tue, Feb 18, 2014 at 06:17:10PM -0500, Matt Porter wrote:
> 
> > +static struct of_device_id bcm590xx_of_match[] = {
> > +	{ .compatible = "brcm,bcm59056-regs", },
> > +	{ }
> > +};
> 
> This looks pretty much OK however I am in general suspicious of MFDs
> that have subdevices like this in the DT - it doesn't seem like this is
> a reusable device which can appear anywhere else so you're pretty much
> just representing the way that Linux splits things up here rather than a
> reusable IP that can reasonably have a separate binding.
> 
> If you had a binding which did something like enumerate the individual
> IP blocks as individual devices that'd be more interesting, I could see
> for example that a different PMIC might have a different set of register
> compatible regulator IPs laid out.  It looks like that might be doable,
> but it's in no way essential.

Ok I dropped this for v3 in favor of using mfd_add_device() and having
the regulator driver reference the of_node from the parent device.

-Matt


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/da50f352/attachment.sig>
