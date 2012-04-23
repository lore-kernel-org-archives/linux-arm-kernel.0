From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Apr 2012 15:06:46 +0300
Subject: [PATCH 1/3] ARM: tegra: Add AHB driver
In-Reply-To: <1335181043-15348-1-git-send-email-hdoyu@nvidia.com>
References: <1335181043-15348-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <20120423120645.GY26302@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 23, 2012 at 02:37:21PM +0300, Hiroshi DOYU wrote:
> +static inline unsigned long gizmo_readl(unsigned long offset)
> +{
> +	return readl(IO_TO_VIRT(TEGRA_AHB_GIZMO_BASE + offset));
> +}
> +
> +static inline void gizmo_writel(unsigned long value, unsigned long offset)
> +{
> +	writel(value, IO_TO_VIRT(TEGRA_AHB_GIZMO_BASE + offset));
> +}

why don't you ioremap() your address and use it as a void __iomem * ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120423/2c627380/attachment.sig>
