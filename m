From: david.wu@rock-chips.com (David.Wu)
Date: Thu, 10 Aug 2017 18:57:40 +0800
Subject: [PATCH v4 05/12] Documentation: net: phy: Add phy-is-internal
 binding
In-Reply-To: <20170810002041.GA10776@lunn.ch>
References: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
 <1502280630-2254-1-git-send-email-david.wu@rock-chips.com>
 <778B0470-8ABD-46AD-A63D-F0CF4911C800@gmail.com>
 <20170810002041.GA10776@lunn.ch>
Message-ID: <1bff1793-fe46-f263-fbf5-ef65ffbc5dc9@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew, Florian

? 2017/8/10 8:20, Andrew Lunn ??:
> Hi Florian, David.
> 
> I'm happy with the property name. But i think the text needs more
> description. We deal with Ethernet switches with integrated PHYs. Yet
> for us, this property is unneeded.
> 
> Seeing this property means some bit of software needs to ensure the
> internal PHY should be used, when given the choice between an internal
> and external PHY. So i would say something like:
> 
>      If set, indicates that the PHY is integrated into the same
>      physical package as the Ethernet MAC. If needed, muxers should be
>      configured to ensure the (internal) PHY is used. The absence of this
>      property indicates the muxers should be configured so that the
>      external PHY is used.

Are we supposed to replace the words "internal" with "integrated" here?
So we have three kinds of PHY, they are intenal, external and integrated 
PHYs.

> 
> This last part is important. If the bootloader has set the internal
> PHY to be used, you need to reset it. Otherwise we are going to get
> into a mess sometime later and need to add a phy-is-external property.
