From: marex@denx.de (Marek Vasut)
Date: Fri, 29 Nov 2013 03:21:22 +0100
Subject: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
In-Reply-To: <006401ceebfe$47ab6b00$d7024100$%han@samsung.com>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
 <20131127083637.GD12773@pratyush-vbox>
 <006401ceebfe$47ab6b00$d7024100$%han@samsung.com>
Message-ID: <201311290321.22415.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jingoo Han,

> On Wednesday, November 27, 2013 5:37 PM, Pratyush Anand wrote:
> > On Wed, Nov 27, 2013 at 04:24:47PM +0800, Marek Vasut wrote:
> > > > On Wed, Nov 27, 2013 at 04:46:09AM +0800, Marek Vasut wrote:
> > > > > Dear Pratyush Anand,
> > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > On Wed, Oct 23, 2013 at 12:55:43PM +0800, Tim Harvey wrote:
> > > > > > > The IMX6 iATU is used for address translation between the AXI
> > > > > > > bus address space and PCI address space.  This is used for
> > > > > > > type0 and type1 config cycles but is not necessary for
> > > > > > > outbound io/mem regions.
> > > > > > > 
> > > > > > > This patch removes the calls that inappropriately re-configures
> > > > > > > the ATU viewport for outbound memory and IO after config
> > > > > > > cycles and removes them altogether as they are not necessary.
> > > > > > > 
> > > > > > > This resolves issues with PCI devices behind switches and has
> > > > > > > been tested with a Gige device behind a PLX PEX860x switch. 
> > > > > > > More testing is needed for other configurations.
> > > > > > 
> > > > > > It seems to me that in your controller you have only one view
> > > > > > port. Also mem_base and mem_bus_addr is same. Thats why it works
> > > > > > in your case.
> > > > > 
> > > > > MX6 has 4 In/4 Out viewports AFAICT.
> > > > 
> > > > Then if I do not miss anything, MX6 should work even without this
> > > > patch.
> > > 
> > > Yes, yet, it does not. On the other hand, this defect is only
> > > problematic if you use the devices behind a switch. Do you use a PCIe
> > > switch on your platform please?
> > 
> > I had tested with device under bridge.
> > Mohit is in process of validating SPEAr patches with latest kernel.
> > Mohit, see if we can arrange a switch and test, once SPEAr platform is
> > ready with latest kernel.
> 
> I agree with Pratyush Anand's opinion.
> One of our engineers had tested PCI cards under switch.
> As far as I know, there was no issue about this.
> However, currently, I don't have any switches. So, I
> Cannot test this on Exynos platform.

OK, I will wait for Richard to come up with confirmation if possible. Looks like 
he's out of the office, so it might take a bit.

> Mohit,
> If you test a switch on SPEAr platform, it will be
> very helpful. Thank you.
> 
> Best regards,
> Jingoo Han

Best regards,
Marek Vasut
