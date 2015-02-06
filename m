From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Feb 2015 11:54:18 +0000
Subject: Recommendations for a new MFD device driver?
In-Reply-To: <20150206101006.GK12209@pengutronix.de>
References: <20150206101006.GK12209@pengutronix.de>
Message-ID: <20150206115418.GV21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 11:10:06AM +0100, Sascha Hauer wrote:

> 1) Put it into the RTC device driver.
> 2) Put it into the .resource field of struct mfd_cell
> 3) Put it into the device tree using standard reg, interrupt properties and
>    a) Let the RTC driver interpret these
>    b) Let the MFD driver create resources in the .resource field of struct
>       mfd_cell
>    c) Let the MFD core create the resources

> I have a tendency to 3, but I'm afraid that the resource informations
> are duplicated too much in the device tree source files, because every
> user would have to carry a full description of the mfd device. Maybe
> that duplication could be reduced with some CPP magic, I don't know.

> Maybe this is a solved problem and I'm just not picking a good example
> from drivers/mfd.

The wm831x drivers take option 2 but are pre-DT, it still seems the most
sensible thing to me though - no need for the user to have to repeat
this information in every DT and easy to add new stuff if we need it.
You could use a .dtsi like we use for SoCs to reduce the duplication
required if you do decide to put things in the DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150206/52ba2f6a/attachment.sig>
