From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Jan 2015 16:19:01 +0100
Subject: [linux-sunxi] Re: [PATCH v2 01/11] clk: sunxi: Add mod0 and mmc
 module clock support for A80
In-Reply-To: <CAGb2v65xRf9PeAe2L-F-c9gJ9TQZEeh8jA4ehu7=ZuR8Z8A4FA@mail.gmail.com>
References: <1418886058-8145-1-git-send-email-wens@csie.org>
 <1418886058-8145-2-git-send-email-wens@csie.org>
 <20141219180235.GO4820@lukather>
 <CAGb2v66iEhdCxuLPRPLxJENUtB04GtbHDHu+7tuBHFqNL2foeA@mail.gmail.com>
 <20150108093825.GP7853@lukather>
 <CAGb2v65xRf9PeAe2L-F-c9gJ9TQZEeh8jA4ehu7=ZuR8Z8A4FA@mail.gmail.com>
Message-ID: <20150112151901.GM4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 10:39:38AM +0800, Chen-Yu Tsai wrote:
> On Thu, Jan 8, 2015 at 5:38 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Sat, Dec 20, 2014 at 08:43:27PM +0800, Chen-Yu Tsai wrote:
> >> > That looks a lot like the A10 MMC clock. What's changing? only the
> >> > data to feed to the factors setup code?
> >>
> >> That's correct. Only the mux width in the data fed to the setup code
> >> and the lock differ.
> >>
> >> The hardware can work with the a10 mod0 code, but it won't recover from
> >> cases where someone writes to the upper bits of the mux, since it doesn't
> >> know about them.
> >
> > I'd very much prefer if we could factorise that code then.
> 
> I was hoping to not have to extend sunxi-factors-clk any more. But yes,
> I can add mux_width and mux_table fields to factors_data.

I didn't really thought of putting it into sunxi-factors, just have a
common probe for the two, with for example the code checking which
compatible is used, and put one value or another.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/66668de5/attachment.sig>
