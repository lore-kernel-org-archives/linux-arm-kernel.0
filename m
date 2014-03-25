From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 25 Mar 2014 11:35:26 +0100
Subject: [RESEND: RFC PATCH 3/3] pcie: keystone: add pcie driver based on
 designware core driver
In-Reply-To: <235376049.yyfljDtinu@wuerfel>
References: <1395707726-20437-1-git-send-email-m-karicheri2@ti.com>
 <1395707726-20437-4-git-send-email-m-karicheri2@ti.com>
 <235376049.yyfljDtinu@wuerfel>
Message-ID: <20140325103525.GA14789@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 08:44:36AM +0100, Arnd Bergmann wrote:
> On Monday 24 March 2014 20:35:26 Murali Karicheri wrote:
[...]
> > +/* Keystone PCIe driver does not allow module unload */
> > +static int __init ks_pcie_init(void)
> > +{
> > +	return platform_driver_probe(&ks_pcie_driver, ks_pcie_probe);
> > +}
> > +subsys_initcall(ks_pcie_init);
> 
> Why subsys_initcall?
> 
> We should probably try to fix unloading soon.

I did some work on this a few months ago but never got around to
cleaning up the patches. Let me see if I can resurrect that work.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140325/d2b2f628/attachment.sig>
