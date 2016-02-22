From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 21 Feb 2016 19:45:17 -0800
Subject: [PATCH v2 0/3] clk: sunxi: error checking on clock setup
In-Reply-To: <1455619568-1906-1-git-send-email-andre.przywara@arm.com>
References: <1455619568-1906-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20160222034517.GH19169@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 16, 2016 at 10:46:05AM +0000, Andre Przywara wrote:
> Setting up the clocks properly is quite critical to the system's
> operation, but currently our error handling is not very verbose.
> This series adds error handling and reporting to the sunxi clocks,
> so that any errors are correctly detected and reported. Also previous
> actions are rolled back in case something went wrong.
> This proves to be helpful in debugging clock tree issues,
> especially when adding support for new SoCs.
> I tested this on a BananaPi by deliberately misspelling
> "clock-output-names". The resulting kernel crash in
> sun4i_timer_interrupt is totally misleading, but now there is a line
> in the dmesg before saying:
> =======
> sunxi_divider_clk_setup: could not read clock-output-names for "apb0"
> =======
> 
> This applies on top of Maxime's sunxi/for-next branch.

Applied all three, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160221/2d339957/attachment.sig>
