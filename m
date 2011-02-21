From: balbi@ti.com (Felipe Balbi)
Date: Mon, 21 Feb 2011 11:20:22 +0200
Subject: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during
	fault handling
In-Reply-To: <AANLkTinTCGhH9HgGEr1ciHL5Vf+gQxecr17O6Z9OTOWv@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<20110221.101856.76372714451194378.Hiroshi.DOYU@nokia.com>
	<20110221082240.GL3094@legolas.emea.dhcp.ti.com>
	<AANLkTinTCGhH9HgGEr1ciHL5Vf+gQxecr17O6Z9OTOWv@mail.gmail.com>
Message-ID: <20110221092022.GA4159@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 21, 2011 at 10:57:45AM +0200, David Cohen wrote:
> >> Ideally I'd like to avoid having "isr_priv" in iommu since it's not
> >> used for iommu but client needs the place to pass its info to its
> >> custom handler. Any better idea?
> >
> > I'm not sure if it makes sense as I don't know the mailbox block, but
> > maybe moving to GENIRQ ? Then IRQ subsystem would take care of the
> > "dev_id"
> 
> Not sure if it fits in this case. It's a different module (IOMMU user)
> which needs to get a callback from IOMMU when a fault happens.
> Is there any GENIRQ usage currently in this scenario?

No, that's not how GENIRQ is supposed to be used. You will need a
function pointer, like you added.

-- 
balbi
