From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 1 Oct 2015 21:45:49 +0800
Subject: [PATCH v4 3/5] ARM: mediatek: add smp bringup code
In-Reply-To: <20150926093835.GA20255@n2100.arm.linux.org.uk>
References: <1443109140-5406-1-git-send-email-yingjoe.chen@mediatek.com>
 <1443109140-5406-4-git-send-email-yingjoe.chen@mediatek.com>
 <20150926093835.GA20255@n2100.arm.linux.org.uk>
Message-ID: <1443707149.22188.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-09-26 at 10:38 +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 24, 2015 at 11:38:58PM +0800, Yingjoe Chen wrote:
> > +struct mtk_smp_boot_info {
> > +	unsigned long smp_base;
> ...
> > +static const struct mtk_smp_boot_info mtk_mt8135_tz_boot = {
> > +	0x80002000, 0x3fc,
> ...
> > +static const struct mtk_smp_boot_info mtk_mt6589_boot = {
> > +	0x10002000, 0x34,
> ...
> > +	if (trustzone) {
> > +		/* smp_base(trustzone-bootinfo) is reserved by device tree */
> > +		mtk_smp_base = phys_to_virt(mtk_smp_info->smp_base);
> 
> I can't say whether this is correct or not, as we've got rid of most of
> the information that would allow me to make that decision.
> 
> The address passed to phys_to_virt() _must_ be one which is mapped by
> the kernel as lowmem.  I've no idea if the above would fall into that
> category though.
> 

Currently only mt8127/mt8135 trustzone firmware use this reserve
location. The reserved memory is before kernel code, so it will
definitely in lowmem.

Joe.C
