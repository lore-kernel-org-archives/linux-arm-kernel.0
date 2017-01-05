From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jan 2017 18:47:25 +0100
Subject: [PATCH 1/5] drivers: mmc: sunxi: fix A64 calibration routine
In-Reply-To: <1483398226-29321-2-git-send-email-andre.przywara@arm.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-2-git-send-email-andre.przywara@arm.com>
Message-ID: <20170105174725.kmr25iodjnjozqjm@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 02, 2017 at 11:03:42PM +0000, Andre Przywara wrote:
> The calibration facility in the A64 MMC block seems to have been
> misunderstood: the result value is not the value to program into the
> delay bits, but is the number of delay cells that result in a full clock
> cycle delay. So this value has to be scaled by the desired phase, which
> we still have to know and program.
> Change the calibration routine to take a phase parameter and scale the
> calibration value accordingly.
> Also introduce sun50i-a64 delay parameters to store the required phase.
> Looking at the BSP kernel the sample delay for anything below HS200 is
> 0, so we go with that value.
> Once the driver supports HS200 and faster modes, we can enter confirmed
> working values in there.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Exactly how that works hasn't been confirmed, and the only thing that
this patch actually do is... nothing, since the delay is always 0. If
and when we get HS400 to work and we know for a fact how the
calibration works, then we'll be able to use it. Until then, we can
just clear those bits.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/6994a6ab/attachment.sig>
