From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 6 Jul 2013 00:06:55 +0200
Subject: [PATCHv4 05/11] of: pci: add registry of MSI chips
In-Reply-To: <CAErSpo5LqKbG=_Uw9eEfR-J0mD2Wg8oi_DdjEfPqgB_VxjouMg@mail.gmail.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo5LqKbG=_Uw9eEfR-J0mD2Wg8oi_DdjEfPqgB_VxjouMg@mail.gmail.com>
Message-ID: <20130706000655.00ae3659@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

On Fri, 5 Jul 2013 15:56:55 -0600, Bjorn Helgaas wrote:

> > +int of_msi_chip_add(struct msi_chip *chip)
> > +{
> > +       if (! of_property_read_bool(chip->of_node, "msi-controller"))
> 
> The space between "! of_property..." is atypical.

Indeed.


> > +struct msi_chip *of_find_msi_chip_by_node(struct device_node *of_node)
> > +{
> > +       struct msi_chip *c;
> 
> Normally there's a blank line here.
> 
> The list traversal below isn't safe, is it?  A simultaneous remove,
> e.g., of an MSI chip unrelated to the one we're looking up, might
> change the list while we're traversing it.

True, will fix!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
