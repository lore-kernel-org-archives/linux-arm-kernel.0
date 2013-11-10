From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 10 Nov 2013 11:58:35 +0100
Subject: [PATCH v3 0/4] Add support for the Allwinner A31 Reset Controllers
In-Reply-To: <1382707365-4776-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1382707365-4776-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20131110105834.GL26440@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Fri, Oct 25, 2013 at 02:22:41PM +0100, Maxime Ripard wrote:
> Hi everyone,
> 
> This patchset adds support for the reset controllers found in the Allwinner A31
> SoCs. Since these controllers are pretty simple, basically just a few MMIO
> registers, with a single bit controlling the reset state of the other devices
> it asserts in reset, the driver is quite simple as well.
> 
> However, one of the IPs asserted in reset by these controllers are the timers,
> the only thing standing out is that it requires to be registered before the
> timers are initialized.

I'll submit a v3 on this, because of a minor thing in the
compatible-related thing (on sun4i (Allwinner A10) the reset parts are
in the same registers as clock control ones, so we won't be able to
use this driver in that case, which makes the compatible a bit different).

Do you have any comment before I send the new version?

Thanks
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131110/8064eeae/attachment.sig>
