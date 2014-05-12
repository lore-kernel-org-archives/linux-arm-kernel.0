From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 May 2014 19:36:17 +0200
Subject: [PATCHv5 08/20] usb: host: xhci-plat: add support for the
 Armada 375/38x XHCI controllers
In-Reply-To: <537103DD.5030906@linux.intel.com>
References: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399832288-19899-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <537103DD.5030906@linux.intel.com>
Message-ID: <20140512193617.011aa958@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mathias Nyman,

On Mon, 12 May 2014 20:24:45 +0300, Mathias Nyman wrote:

> > +int xhci_mvebu_mbus_init_quirk(struct platform_device *pdev)
> > +{
> > +	struct resource	*res;
> > +	void __iomem *base;
> > +	const struct mbus_dram_target_info *dram;
> 
> Hi
> 
> Sparse warns about this:
> 
> drivers/usb/host/xhci-mvebu.c:42:5: warning: symbol 'xhci_mvebu_mbus_init_quirk' 
> was not declared. Should it be static?

Not, it should not: it gets called from xhci-plat.c. However,
xhci-mvebu.c should include its header xhci-mvebu.h so that sparse
realize that the function is voluntarily exported, and that therefore
not having the static qualifier is expected.

Should we resend a v6 with just this change?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
