From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jun 2016 21:23:21 +0200
Subject: [PATCH v3 5/8] rtc: ac100: Add clk output support
In-Reply-To: <CAGb2v67DVBZbRb2PWLP8WurPaNin=2Fa=HMAEK_PdBeqv1x+8Q@mail.gmail.com>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-6-git-send-email-wens@csie.org>
 <20160622100206.GV26668@lukather>
 <CAGb2v67DVBZbRb2PWLP8WurPaNin=2Fa=HMAEK_PdBeqv1x+8Q@mail.gmail.com>
Message-ID: <20160627192321.GX4000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 06:11:55PM +0800, Chen-Yu Tsai wrote:
> On Wed, Jun 22, 2016 at 6:02 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Mon, Jun 20, 2016 at 10:52:15AM +0800, Chen-Yu Tsai wrote:
> >> +     /*
> >> +      * The ADDA 4 MHz clock is from the codec side of the AC100,
> >> +      * which is likely a different power domain. However, boards
> >> +      * always have both sides powered on, so it is impossible to
> >> +      * test this.
> >> +      */
> >
> > If that ADDA clock is exposed by the codec, why are you putting it in
> > the RTC?
> 
> The thing is it's not entirely clear that it's from the codec side.
> I'm just inferring this from the name. (I'll make the comment clearer.)
> The codec parts of the datasheet don't mention this clock at all.
> 
> Allwinner's SDK puts all the clocks under the RTC module. And the
> are always on, so I can't really turn off the codec and see what
> happens. That and I don't have an oscilloscope or logic analyzer.

Why not just create a separate clock driver then?

Thanks,
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160627/b4bf30da/attachment.sig>
