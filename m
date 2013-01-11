From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 11 Jan 2013 05:06:55 +0100
Subject: [PATCH 02/14] of/pci: Add of_pci_get_devfn() function
In-Reply-To: <50EF5847.7040507@wwwdotorg.org>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-3-git-send-email-thierry.reding@avionic-design.de>
 <50EF5847.7040507@wwwdotorg.org>
Message-ID: <20130111040655.GD28094@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 05:09:43PM -0700, Stephen Warren wrote:
> On 01/09/2013 01:43 PM, Thierry Reding wrote:
> > This function can be used to parse the device and function number from a
> > standard 5-cell PCI resource. PCI_SLOT() and PCI_FUNC() can be used on
> > the returned value obtain the device and function numbers respectively.
> 
> > diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> 
> >  static inline int __of_pci_pci_compare(struct device_node *node,
> >  				       unsigned int devfn)
> >  {
> > +	int err;
> >  
> > +	err = of_pci_get_devfn(node);
> > +	if (err < 0)
> >  		return 0;
> > +
> > +	return devfn == err;
> 
> I know this is really picky, but calling that "err" when it's hopefully
> not an error but rather a PCI device/function ID seems a little obscure.
> Perhaps node_devfn? I assume that fact that devfn is unsigned and err is
> signed won't be an issue.

Maybe renaming the devfn parameter to data and using devfn for the local
variable would be more obvious.

The signedness shouldn't be problematic. devfn is an 8-bit unsigned
integer and sign mismatch is excluded by the error return already.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/2bdd15f2/attachment.sig>
