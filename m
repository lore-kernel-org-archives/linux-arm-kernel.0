From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 20 Oct 2014 17:10:28 +0200
Subject: [PATCH RFT 0/8] Marvell PXA168 libphy handling and Berlin Ethernet
In-Reply-To: <54451E3F.1030700@gmail.com>
References: <1412858346-11334-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20141016095323.GA1061@kwain> <54451E3F.1030700@gmail.com>
Message-ID: <20141020151028.GA17117@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Mon, Oct 20, 2014 at 04:37:51PM +0200, Sebastian Hesselbarth wrote:
> On 16.10.2014 11:53, Antoine Tenart wrote:
> >On Thu, Oct 09, 2014 at 02:38:58PM +0200, Sebastian Hesselbarth wrote:
> >>This patch series deals with a removing a IP feature that can be found
> >>on all currently supported Marvell Ethernet IP (pxa168_eth, mv643xx_eth,
> >>mvneta). The MAC IP allows to automatically perform PHY auto-negotiation
> >>without software interaction.
> >>
> >>However, this feature (a) fundamentally clashes with the way libphy works
> >>and (b) is unable to deal with quirky PHYs that require special treatment.
> >>In this series, pxa168_eth driver is rewritten to completely disable that
> >>feature and properly deal with libphy provided PHYs. The other two drivers
> >>are suspect to future patch sets, also removing the code related with it.
> >>
> >>Currently, the patches are based on next-20141009 and will be resent once
> >>v3.18-rc1 drops. This is a Request-For-Test on both BG2Q and MMP/gplug as
> >
> >I tested the series on a BG2Q, it worked well.
> 
> Thanks for testing! I assume you have added a phy-connection-type
> property to BG2Q's ethernet node?

Yes, I added the following property to the ethernet-phy node:

	phy-connection-type = "mii";

Feel free to add this to your series, or I can also send a patch.


Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
