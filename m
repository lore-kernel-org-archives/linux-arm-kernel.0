From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Mar 2014 16:56:44 +0100
Subject: [PATCH 0/5] ARM: sun6i: dt: Add support for GMAC
In-Reply-To: <1394036835-22007-1-git-send-email-wens@csie.org>
References: <1394036835-22007-1-git-send-email-wens@csie.org>
Message-ID: <20140317155644.GM27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 06, 2014 at 12:27:10AM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> This series add support for the GMAC in A31. The GMAC is the same as in
> the A20, except it has an extra reset control. The GMAC clock module is
> mostly the same as in the A20, without the extra dividers, which I left
> out intentionally from the clock driver.
> 
> The register offsets and interrupts were copied from A31 SDK in Rhombus
> Tech's repository. The pin muxes were from the EVB fex file. If you have
> the A31 datasheet, you could double check them.
> 
> This series is based on current sunxi-next ( e8176a3b0 ).
> 
> As I don't have actual A31 hardware, this is only compile tested.
> Please give it a try, and let me know if it works or not.

I finally took some time to give it a try.

It actually doesn't work, but presumably not because of you, but
because the PHY is powered up by the PMIC, which is not supported
yet. This is the same situation on Hans' Melee, so we will only be
ably to test it whenever we have support for the AXP :(

Thanks for your efforts,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/ba9b1fbf/attachment.sig>
