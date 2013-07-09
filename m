From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 9 Jul 2013 16:01:32 +0200
Subject: [PATCHv4 05/11] of: pci: add registry of MSI chips
In-Reply-To: <CAL_Jsq+h=y5SNo4qO5-5u_w8rW++9MKDZK8rASNjhtVcjh-iyQ@mail.gmail.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAL_Jsq+h=y5SNo4qO5-5u_w8rW++9MKDZK8rASNjhtVcjh-iyQ@mail.gmail.com>
Message-ID: <20130709160132.7f5e7a8e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Tue, 9 Jul 2013 08:43:36 -0500, Rob Herring wrote:

> > +int of_msi_chip_add(struct msi_chip *chip)
> 
> Perhaps of_pci_msi_chip_add instead.

Sure, makes sense.

> > +{
> > +       struct msi_chip *c;
> > +       list_for_each_entry(c, &msi_chip_list, list) {
> 
> Need the safe variant here?

As suggested by Bjorn, I've changed this function to grab the
msi_chip_mutex while traversing the list.

Does your e-mail implies that the general approach seems ok? If so,
I'll resend an updated v5 version taking into account the comments
that I have received on this v4.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
