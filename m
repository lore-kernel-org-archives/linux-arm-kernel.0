From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Aug 2014 16:47:11 +0100
Subject: [Regression] FEC: Panic on suspend in 3.16
In-Reply-To: <53E24A99.2020604@denx.de>
References: <53E24147.4050304@parkeon.com> <53E24525.2020809@mentor.com>
 <53E24A99.2020604@denx.de>
Message-ID: <20140806154711.GQ30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 06, 2014 at 05:32:41PM +0200, Stefano Babic wrote:
> Hi Nathan, Martin,
> 
> On 06/08/2014 17:09, Nathan Lynch wrote:
> > On 08/06/2014 09:52 AM, Martin Fuzzey wrote:
> >> Hi all,
> >>
> >> I am using the fec ethernet driver on a i.MX53 SoC.
> >>
> >> All was working fine on 3.13 but, after upgrading to 3.16 I now get a
> >> panic on suspend:
> > 
> > Same issue reported here:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277728.html
> > 
> > a71e3c37960c (net: phy: Set the driver when registering an MDIO bus
> > device) has been implicated; try reverting that.
> > 
> 
> I confirm this issue (on a i.MX35). The ndev pointer is NULL in the
> suspend function. I added the check for the pointer:

As Nathan says, the problem is caused by a71e3c37960c and the fix which
will soon be merged into mainline and stable trees will be a revert of
that commit.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
