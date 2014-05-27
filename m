From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 May 2014 10:32:01 +0200
Subject: [PATCH 03/22] clk: sunxi: add "pll6" to sun6i protected clock list
In-Reply-To: <CAGb2v643UmK6GfuDVfywVUeo_g7FpdZC_7SgeY-UMZ_k_-2N9Q@mail.gmail.com>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-4-git-send-email-wens@csie.org>
 <20140525184808.GP10768@lukather>
 <CAGb2v643UmK6GfuDVfywVUeo_g7FpdZC_7SgeY-UMZ_k_-2N9Q@mail.gmail.com>
Message-ID: <20140527083201.GF4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 12:47:30PM +0800, Chen-Yu Tsai wrote:
> On Mon, May 26, 2014 at 2:48 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Fri, May 23, 2014 at 03:51:06PM +0800, Chen-Yu Tsai wrote:
> >> PLL6 is used by some important but undocumented module, most likely
> >> memory related, such as mbus or the actual memory controller. As we
> >> do not have a driver for that, add pll6 to the list of protected
> >> clocks, so that it won't be disabled and leave us with a non-responsive
> >> system.
> >
> > What issue have you seen?
> 
> Completely unresponsive after PLL6 is gated (on the A23).
> 
> > The system actually works pretty great on the A31.
> 
> Does it work when there aren't any other PLL6 consumers?

Yes.

> Maybe the boot0 on A31 and A23 setup some DRAM-related modules differently.
> 
> If the A31 works without protecting PLL6, I'll add a separate list
> for the A23.

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/daf1db4d/attachment.sig>
