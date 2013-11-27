From: pratyush.anand@st.com (Pratyush Anand)
Date: Wed, 27 Nov 2013 09:20:56 +0530
Subject: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
In-Reply-To: <201311262146.09780.marex@denx.de>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
 <20131023064051.GA7646@pratyush-vbox>
 <201311262146.09780.marex@denx.de>
Message-ID: <20131127035056.GA12773@pratyush-vbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 04:46:09AM +0800, Marek Vasut wrote:
> Dear Pratyush Anand,
> 
> > Hi,
> > 
> > On Wed, Oct 23, 2013 at 12:55:43PM +0800, Tim Harvey wrote:
> > > The IMX6 iATU is used for address translation between the AXI bus
> > > address space and PCI address space.  This is used for type0 and type1
> > > config cycles but is not necessary for outbound io/mem regions.
> > > 
> > > This patch removes the calls that inappropriately re-configures the ATU
> > > viewport for outbound memory and IO after config cycles and removes them
> > > altogether as they are not necessary.
> > > 
> > > This resolves issues with PCI devices behind switches and has been tested
> > > with a Gige device behind a PLX PEX860x switch.  More testing is needed
> > > for other configurations.
> > 
> > It seems to me that in your controller you have only one view port.
> > Also mem_base and mem_bus_addr is same. Thats why it works in your
> > case.
> 
> MX6 has 4 In/4 Out viewports AFAICT.

Then if I do not miss anything, MX6 should work even without this patch.

Regards
Pratyush
> 
> Best regards,
> Marek Vasut
