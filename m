From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Sep 2009 12:09:37 +0100
Subject: [PATCH 08/10] S3C64XX I2S: Return correct codec clock
In-Reply-To: <1b68c6790909152216od3f372ftc2fa3db488e6996@mail.gmail.com>
References: <1253008960-10666-1-git-send-email-jassi.brar@samsung.com>
	<20090915110635.GI22878@rakim.wolfsonmicro.main>
	<1b68c6790909150421y7c78ad8dt2703bd039fcd39b@mail.gmail.com>
	<20090915115618.GN22878@rakim.wolfsonmicro.main>
	<1b68c6790909152216od3f372ftc2fa3db488e6996@mail.gmail.com>
Message-ID: <20090916110937.GE3589@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 02:16:54PM +0900, jassi brar wrote:

> Wait, there is no option for selecting I2SCLK in the manual. That is
> behind the MUX along with Mpll/Epll Out etc.
> In the driver we actually have all the correct options : PCLK or
> CLKAUDIO(which is the output of the MUX).

> The IMS bit can select only either PCLK or CLKAUDIO.So, i guess

The datasheet I have says an IMS setting of 11 selects I2SCLK and an IMS
setting of 01 selects CLKAUDIOx.  This seems odd to say the least but is
consistent with the move to a 2 bit register field for IMS rather than
adding a second register field for selection of master mode clock.
Could just be poor documentation, but it could be a restriction on the
clock that can be used in slave mode or an error in the diagram.

>  the patch is fine as it is.

It at least needs checkpatch issues fixing.
