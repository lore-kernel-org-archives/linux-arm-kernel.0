From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 Jan 2015 16:20:26 +0100
Subject: [PATCH v3 05/13] ARM: dts: sun9i: Add clock-indices property for
 bus gate clocks
In-Reply-To: <CAGb2v64brc_2c5Jz2=BzfCpwiwBQgGf=SLD2ib+taOYUgicekA@mail.gmail.com>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
 <1421113055-17867-6-git-send-email-wens@csie.org>
 <20150114163351.GY4891@lukather>
 <CAGb2v64brc_2c5Jz2=BzfCpwiwBQgGf=SLD2ib+taOYUgicekA@mail.gmail.com>
Message-ID: <20150115152026.GA1135@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 10:24:04AM +0800, Chen-Yu Tsai wrote:
> On Thu, Jan 15, 2015 at 12:33 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Tue, Jan 13, 2015 at 09:37:27AM +0800, Chen-Yu Tsai wrote:
> >> of_clk_get_parent_name() uses the clock-indices property to resolve
> >> clock phandle arguments in case that the argument index does not
> >> match the clock-output-names sequence.
> >>
> >> This is the case on sunxi, where we use the actual bit index as the
> >> argument to the phandle. Add the clock-indices property so that
> >> of_clk_get_parent_name() resolves the names correctly.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Applied. Are the mask in the clock driver still of any use now? I
> > don't think they are, and if we're going that way, I'd rather have
> > them removed from the driver.
> 
> Yes they are still passed through factors_data, for mux_clk_ops to
> know about the width of the mux, which is 3 bits on older SoCs vs
> 4 bits on sun9i.

Erm.... These are gates. They are not muxable and are not handled
through clk-factors, so I'm not sure how it is relevant :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/7fef886b/attachment.sig>
