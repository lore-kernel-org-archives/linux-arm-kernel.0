From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 5 Sep 2013 19:03:41 +0200
Subject: [PATCH] ASoC: kirkwood: change the compatible string of the
 kirkwood-i2s driver
In-Reply-To: <20130905185456.175f556b@armhf>
References: <1378385791-29551-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130905185456.175f556b@armhf>
Message-ID: <20130905190341.4a4a7820@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jean-Francois Moine,

On Thu, 5 Sep 2013 18:54:56 +0200, Jean-Francois Moine wrote:

> The name of the kirwood audio driver has been changed from
> "kirkwood-i2s" to "mvebu-audio" by Russell King
> (http://www.spinics.net/lists/arm-kernel/msg264185.html).
> I have just used this name in the DT.

I don't care about the driver name: it can be changed whenever you want.

On the opposite, the DT compatible string becomes part of the kernel
ABI, and therefore cannot be changed once it has been defined. This is
why I worry about this one.

And the compatible string doesn't necessarily need to match the driver
name.

> Then, the second interrupt in Dove is not used in the driver. If it
> should, it would be present in the DTs of the dove boards only, so,
> actually, there is not need to have different compatibles.

Indeed the second interrupt is not used in the driver, but the binding
still specifies that two interrupts have to be mentioned, which is
incorrect for Kirkwood. The fact that on Kirkwood there is one
interrupt, while Dove has two, is an indication that the IP block is
not exactly the same. Should this error interrupt become useful in the
driver, it should be done only for Dove, so it makes sense to have two
different compatible strings.

> Eventually, you are talking about some other mvebu SoCs. Before adding
> any new compatible, it would be nice to know if, for example, some
> changes are needed in the kirkwood/dove audio driver for the Armada 370...

So far, it looks like no changes should be needed. I'm sure this will
bring you to the conclusion that 'mvebu-audio' is a good compatible
string: it is not because while we know what Armada 370 looks today, we
have absolutely no idea what the next Armada <something> will look
like. Maybe it will use the same audio IP block, with just a few little
variations.

Again, please read the mails from Rob Herring and Arnd Bergmann. It has
been said numerous times that using the name of the oldest SoC that has
the compatible IP block was the right choice for the compatible string.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
