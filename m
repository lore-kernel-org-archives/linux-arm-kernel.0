From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Mon, 28 Jan 2013 23:16:04 +0100
Subject: [PATCH v2 02/27] of/pci: Add of_pci_get_devfn() function
In-Reply-To: <5106F4EA.20904@wwwdotorg.org>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F4EA.20904@wwwdotorg.org>
Message-ID: <20130128221604.GA24858@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 03:00:10PM -0700, Stephen Warren wrote:
> On 01/28/2013 11:56 AM, Thomas Petazzoni wrote:
> > From: Thierry Reding <thierry.reding@avionic-design.de>
> > 
> > This function can be used to parse the device and function number from a
> > standard 5-cell PCI resource. PCI_SLOT() and PCI_FUNC() can be used on
> > the returned value obtain the device and function numbers respectively.
> 
> > diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> 
> >  static inline int __of_pci_pci_compare(struct device_node *node,
> >  				       unsigned int devfn)
> >  {
> > -	unsigned int size;
> > -	const __be32 *reg = of_get_property(node, "reg", &size);
> > +	int err;
> 
> I think I commented when Thierry posted this, that calling that "err"
> seems a little odd. Thierry replied:
> 
> Maybe renaming the devfn parameter to data and using devfn for the local
> variable would be more obvious.

That's already fixed up in my series. I was going to wait until I was
done with the MSI rework but maybe posting an intermediate version is in
order to share the latest state.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130128/02aacdbf/attachment.sig>
