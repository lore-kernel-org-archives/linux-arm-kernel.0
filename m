From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 12 Dec 2017 09:35:21 +0100
Subject: [PATCH 4/4] [DO NOT MERGE] ARM: dts: sun8i: a83t: bpi-m3: Enable
 PCM5122 codec with I2S1
In-Reply-To: <20171212081148.9194-5-wens@csie.org>
References: <20171212081148.9194-1-wens@csie.org>
 <20171212081148.9194-5-wens@csie.org>
Message-ID: <20171212083521.cpvbirnimaip7kjf@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 12, 2017 at 04:11:48PM +0800, Chen-Yu Tsai wrote:
> This patch enables a PiFi DAC+ V2.0, which is a PCM5122-based audio
> output DAC add-on board for the Raspberry Pi B+ and later, connected
> to the GPIO header of the Bananapi M3 via jumper cables. The power,
> ground, and I2C pins are in the same position, but the I2S ones are
> not.
> 
> The I2C controller used is I2C2, while the I2S controller is I2S1.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> I'm sure I've asked this before, and IIRC the answer was yes: The I2C
> controllers available on the GPIO header all have proper, always-on,
> external pull-ups. Does that mean we can enable them by default, seeing
> as they are likely intended to be used this way (as I2C pins)?
> 
> I think we have a few boards where either I2C or UARTs on the GPIO
> header are enabled by default.

The consensus we reached that we would fill the nodes, but leave them
disabled.

In this particular case, I guess it would help for the i2c controller,
but not for the i2s one.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171212/02cf0807/attachment.sig>
