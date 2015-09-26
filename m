From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Sep 2015 10:38:35 +0100
Subject: [PATCH v4 3/5] ARM: mediatek: add smp bringup code
In-Reply-To: <1443109140-5406-4-git-send-email-yingjoe.chen@mediatek.com>
References: <1443109140-5406-1-git-send-email-yingjoe.chen@mediatek.com>
 <1443109140-5406-4-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <20150926093835.GA20255@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 11:38:58PM +0800, Yingjoe Chen wrote:
> +struct mtk_smp_boot_info {
> +	unsigned long smp_base;
...
> +static const struct mtk_smp_boot_info mtk_mt8135_tz_boot = {
> +	0x80002000, 0x3fc,
...
> +static const struct mtk_smp_boot_info mtk_mt6589_boot = {
> +	0x10002000, 0x34,
...
> +	if (trustzone) {
> +		/* smp_base(trustzone-bootinfo) is reserved by device tree */
> +		mtk_smp_base = phys_to_virt(mtk_smp_info->smp_base);

I can't say whether this is correct or not, as we've got rid of most of
the information that would allow me to make that decision.

The address passed to phys_to_virt() _must_ be one which is mapped by
the kernel as lowmem.  I've no idea if the above would fall into that
category though.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
