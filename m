From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 1 Mar 2012 19:12:40 +0200
Subject: [PATCH] ARM: OMAP: make iommu subsys_initcall to fix builtin
 omap3isp
In-Reply-To: <6354375.6C9sXAHKbF@avalon>
References: <1330251254-14693-1-git-send-email-ohad@wizery.com>
 <35010303.ArkW8BdIu6@avalon>
 <CAK=WgbZRjGEyx0mKmgoWYiOnuvUAka0kTzpLAYbra94Mfpp6qg@mail.gmail.com>
 <6354375.6C9sXAHKbF@avalon>
Message-ID: <CAK=WgbariR4w_w3tzZtWdoMfxtzvNEJpcdh2VMFUWDUnfCqirA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Thu, Mar 1, 2012 at 6:37 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> I'll try that then. How expensive is the iommu_attach_device() (and detach)
> operation in terms of CPU time ?

omap_iommu_attach() basically enables the iommu clock and configures
that IP block.

I suspect it's negligible but I didn't really measure it...

Thanks,
Ohad.
