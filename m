From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Jan 2015 10:21:14 +0100
Subject: [PATCH RFC V3 2/3] mxs: add driver for ocotp in i.MX23 and i.MX28
In-Reply-To: <54AE8D45.7050805@imgtec.com>
References: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
 <2223659.OW08fe0cS1@wuerfel>
 <1003885907.22061.1415301932743.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <6087001.lBonPVHV5K@wuerfel> <54AE8D45.7050805@imgtec.com>
Message-ID: <20150112092114.GG4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 10:59:33AM -0300, Ezequiel Garcia wrote:
> Hi Stefan, Arnd,
> 
> (I'm trimming the Cc list and adding Thierry and Maxime to the loop):
> 
> On 11/06/2014 04:47 PM, Arnd Bergmann wrote:
> [..]
> >>
> >> i don't have a answer to this question, but how about changing fsl_ocotp driver
> >> to driver/soc/mxs/fuse with a similiar binary interface like the tegra ones.
> >>
> >> Does it make sense to you?
> > 
> > I haven't looked at the drivers, so I don't know if the tegra interface
> > is any better or worse than the others. Changing everyone to have the same
> > interface is definitely a good idea, but of course only if the unified
> > interface is a good one ;-)
> > 
> 
> I'm in the process of finding a suitable upstream path for a new eFuse driver
> for fuses used on Imagination Technologies SoCs.
> 
> This was our last proposal, which follows Tegra's work:
> 
> http://www.spinics.net/lists/devicetree/msg59246.html
> 
> However, Arnd was reluctant to take yet another efuse driver under
> drivers/soc and proposed instead to try to find a unified API. We've
> had numerous fuse drivers (tegra, sunxi, imx and img) appearing, so
> his concern certainly makes sense.
> 
> I've talked to Arnd on IRC and we agreed to create a new directory
> drivers/efuse. As a first step we would just move the tegra driver,
> and add the new drivers (img on my side, and possibly mxs on
> Stefan's).  Perhaps we would also pull the sunxi_sid driver as well.
> 
> Having the drivers together would allow us to come up with a unified API
> as follow up work.
> 
> How does this sound? If you have no objections to this, I can go
> ahead and try to prepare some RFCs.

It sounds great :)

Could you put me in Cc whenever you send some patches?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/d70391be/attachment.sig>
