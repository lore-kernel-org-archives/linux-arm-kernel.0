From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 Jun 2014 14:09:00 +0200
Subject: [PATCH v3 2/4] pinctrl: Add NVIDIA Tegra XUSB pad controller
 support
In-Reply-To: <53A02479.8080405@nvidia.com>
References: <1402930623-28886-1-git-send-email-thierry.reding@gmail.com>
 <1402930623-28886-2-git-send-email-thierry.reding@gmail.com>
 <53A02479.8080405@nvidia.com>
Message-ID: <20140617120859.GC18816@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 02:20:25PM +0300, Mikko Perttunen wrote:
> This v3 breaks SATA; see below
> 
> On 16/06/14 17:57, Thierry Reding wrote:
> ...
> >+                       regval = padctl_readl(padctl, lane->offset);
> >+
> >+                       if (!value)
> >+                               regval &= ~lane->iddq;
> >+                       else
> >+                               regval |= lane->iddq;
> >+
> >+                       padctl_writel(padctl, regval, lane->offset);
> ...
> 
> The bits at at lane->iddq are actually IDDQ_DISABLE bits, so this is the
> wrong way around: having iddq = <0> in device tree leads to the device
> turning off. So either the DT property should be renamed or the branches of
> the if here should be switched around.

Indeed, s/!value/value/ in the above fixes this. I've sent a v4 with
that fix and changes to address Stephen's comments regarding the
#address-cells and #size-cells properties.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/cdeff08e/attachment.sig>
