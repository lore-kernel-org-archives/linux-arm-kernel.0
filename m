From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 16 Oct 2014 11:53:23 +0200
Subject: [PATCH RFT 0/8] Marvell PXA168 libphy handling and Berlin Ethernet
In-Reply-To: <1412858346-11334-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1412858346-11334-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20141016095323.GA1061@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Thu, Oct 09, 2014 at 02:38:58PM +0200, Sebastian Hesselbarth wrote:
> This patch series deals with a removing a IP feature that can be found
> on all currently supported Marvell Ethernet IP (pxa168_eth, mv643xx_eth,
> mvneta). The MAC IP allows to automatically perform PHY auto-negotiation
> without software interaction.
> 
> However, this feature (a) fundamentally clashes with the way libphy works
> and (b) is unable to deal with quirky PHYs that require special treatment.
> In this series, pxa168_eth driver is rewritten to completely disable that
> feature and properly deal with libphy provided PHYs. The other two drivers
> are suspect to future patch sets, also removing the code related with it.
> 
> Currently, the patches are based on next-20141009 and will be resent once
> v3.18-rc1 drops. This is a Request-For-Test on both BG2Q and MMP/gplug as

I tested the series on a BG2Q, it worked well.

Antoine

> these are the current users of pxa168_eth. A branch with this patches on
> top of next-20141009 can be found at
> 
> git://git.infradead.org/users/hesselba/linux-berlin.git devel/bg2-bg2cd-eth-v1
> 
> It would be great to get a Tested-byfrom MMP guys on gplug - if they
> have that board somewhere. Also, BG2Q (Antoine) needs a phy-connection-type
> property. My guess is that, if it is using internal PHY, it is "mii", too.

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
