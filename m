From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 21 Nov 2016 17:47:33 +0100
Subject: [RFC PATCH net v2 2/3] dt: bindings: add ethernet phy
 eee-disable-advert option documentation
In-Reply-To: <1479744993.17538.85.camel@baylibre.com>
References: <1479742524-30222-1-git-send-email-jbrunet@baylibre.com>
 <1479742524-30222-3-git-send-email-jbrunet@baylibre.com>
 <20161121160149.GF1922@lunn.ch>
 <1479744993.17538.85.camel@baylibre.com>
Message-ID: <20161121164733.GG1922@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What I did not realize when doing this patch for the realtek driver is
> that there is already 6 valid modes defined in the kernel
> 
> #define MDIO_EEE_100TX		MDIO_AN_EEE_ADV_100TX	/*
> 100TX EEE cap */
> #define MDIO_EEE_1000T		MDIO_AN_EEE_ADV_1000T	/*
> 1000T EEE cap */
> #define MDIO_EEE_10GT		0x0008	/* 10GT EEE cap */
> #define MDIO_EEE_1000KX		0x0010	/* 1000KX EEE cap
> */
> #define MDIO_EEE_10GKX4		0x0020	/* 10G KX4 EEE cap
> */
> #define MDIO_EEE_10GKR		0x0040	/* 10G KR EEE cap
> */
> 
> I took care of only 2 in the case of realtek.c since it only support
> MDIO_EEE_100TX and MDIO_EEE_1000T.
> 
> Defining a property for each is certainly doable but it does not look
> very nice either. If it extends in the future, it will get even more
> messier, especially if you want to disable everything.

Yes, agreed.
 
> What do you think about keeping a single mask value but use the define
> above in the DT ? It would be more readable than hex and easy to
> extend, don't you think ?
> 
> These defines are already part of the uapi so I guess we can use those
> in the DT bindings ?

I don't think they are accessible from the dtc include path. You will
need to make a copy, in include/dt-bindings/net/phy.h

But yes, using these defines is a good idea.

     Andrew
