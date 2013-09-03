From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 3 Sep 2013 13:21:36 +0200
Subject: [PATCHv7 1/2] ARM: sunxi: Initial support for Allwinner's
 Security ID fuses
In-Reply-To: <1378204408-1415-2-git-send-email-oliver+list@schinagl.nl>
References: <1378204408-1415-1-git-send-email-oliver+list@schinagl.nl>
 <1378204408-1415-2-git-send-email-oliver+list@schinagl.nl>
Message-ID: <20130903112136.GC2630@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 12:33:27PM +0200, oliver+list at schinagl.nl wrote:
> From: Oliver Schinagl <oliver@schinagl.nl>
> 
> Allwinner has electric fuses (efuse) on their line of chips. This driver
> reads those fuses, seeds the kernel entropy and exports them as a sysfs
> node.
> 
> These fuses are most likely to be programmed at the factory, encoding
> things like Chip ID, some sort of serial number, etc. and appear to be
> reasonably unique.
> While in theory, these should be writeable by the user, it will probably
> be inconvenient to do so. Allwinner recommends that a certain input pin,
> labeled 'efuse_vddq', be connected to GND. To write these fuses however,
> a 2.5 V programming voltage needs to be applied to this pin.
> 
> Even so, they can still be used to generate a board-unique mac from,
> board unique RSA key and seed the kernel RNG.
> 
> On sun7i additional storage is available, this is initially used for an
> UEFI BOOT key, Secure JTAG key, HDMI-HDCP key and vendor specific keys.
> 
> Currently supported are the following known chips:
> Allwinner sun4i (A10)
> Allwinner sun5i (A10s, A13)
> Allwinner sun7i (A20)
> 
> Signed-off-by: Oliver Schinagl <oliver@schinagl.nl>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130903/5b9f368b/attachment.sig>
