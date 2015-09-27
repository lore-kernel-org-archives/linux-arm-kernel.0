From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Sep 2015 18:53:03 +0200
Subject: [linux-sunxi] [PATCH] i2c: mv64xxx: The n clockdiv factor is 0
 based on sunxi SoCs
In-Reply-To: <560813CF.4000807@schinagl.nl>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
 <560813CF.4000807@schinagl.nl>
Message-ID: <20150927165303.GI31209@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2015 at 06:05:35PM +0200, Olliver Schinagl wrote:
> Hey Hans,
> 
> On 27-09-15 16:57, Hans de Goede wrote:
> >According to the datasheets to n factor for dividing the tclk is
> >2 to the power n on Allwinner SoCs, not 2 to the power n + 1 as it is
> >on other mv64xxx implementations.
> Ah!

Just to be sure, i checked Kirkwood, Armada XP and Armada 370
datasheets. They all say n+1.

> >+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-i2c") ||
> >+	    of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))

Rather than have to extend this list every so often, how about adding
a helper of_device_is_compatible_vendor(), so you can just have:

> >+	if (of_device_is_compatible_vendor(np, "allwinner")

  Andrew
