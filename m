From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 11:05:11 +0100
Subject: [PATCH] arm64: dts: allwinner: a64: bananapi-m64: Add LED device
 node
In-Reply-To: <20171201162733.23156-1-wens@csie.org>
References: <20171201162733.23156-1-wens@csie.org>
Message-ID: <20171205100511.ohxcqlrozxfgq6id@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 02, 2017 at 12:27:33AM +0800, Chen-Yu Tsai wrote:
> The Bananapi-M64 has 3 LEDS in red, green, and blue. These are toggled
> via GPIO lines, which drive transistors that control current across the
> LEDS. The red LED is by default on, via an additional pull-up on the
> control line. We consider this means that it is a power indicator.
> So we set the "default-on" property for it.
> 
> The pingroups the GPIO lines belong to require external regulators be
> enabled to be able to drive the GPIO high. These regulators also have
> other purposes. However the pin controller does not have bindings for
> regulators. Here we just set them to always-on.

I guess we should take the opportunity to do just that.

We have been deferring this for quite some time now, this is a perfect
occasion to do it once and for all :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/67860803/attachment.sig>
