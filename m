From: Thomas.Betker@rohde-schwarz.com (Thomas.Betker at rohde-schwarz.com)
Date: Mon, 27 Jun 2016 13:13:36 +0200
Subject: ARM: i.MX6: KSZ9031 fixup questions
In-Reply-To: <20160627082230.GZ20657@pengutronix.de>
References: <OFA5811F46.A3BB50D2-ONC1257FDC.0028F664-C1257FDC.002BD17F@rohde-schwarz.com>
 <20160627082230.GZ20657@pengutronix.de>
Message-ID: <OFBA61C281.5801A177-ONC1257FDF.0032C3FD-C1257FDF.003DABA5@rohde-schwarz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha:

> I wouldn't rely very much in the settings done in ksz9031rn_phy_fixup(),
> probably I was happy that time that the settings worked. Note that the
> micrel phys now take various *-skew-ps properties which should be used
> now.

Okay, thanks for the clarification. And yes, I know that the Micrel PHY 
driver supports *-skew-ps DT properties for KSZ9031 since 3.16 (KSZ9021 
since 3.12). Are you going to remove ksz9021rn_phy_fixup() and 
ksz9031rn_phy_fixup(), and update the device trees of all the i.MX6Q 
boards?

Anyway, ksz9031rn_phy_fixup() is still in 4.6, and I think it makes sense 
to put in some reasonable values, even more so before they are converted 
to DT properties (I have no idea how many boards are affected). Or what is 
your take on this?

Best regards,
Thomas
