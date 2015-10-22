From: mturquette@baylibre.com (Michael Turquette)
Date: Thu, 22 Oct 2015 05:10:00 -0700
Subject: [PATCH v4 5/8] clk: rockchip: Allow the RK3288 SPDIF clocks to
 change their parent
In-Reply-To: <1745884.LUbKvMh2Tj@diego>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <11755202.f1LLWMlYi0@phil> <1444390555.9895.271.camel@collabora.co.uk>
 <1745884.LUbKvMh2Tj@diego>
Message-ID: <20151022121000.20687.48364@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2015-10-11 03:43:27)
> Hi Sjoerd,
> 
> Am Freitag, 9. Oktober 2015, 13:35:55 schrieb Sjoerd Simons:
> > On Thu, 2015-10-08 at 17:10 +0200, Heiko Stuebner wrote:
> > > Am Donnerstag, 8. Oktober 2015, 15:31:16 schrieb Sjoerd Simons:
> > > > The clock branches leading to sclk_spdif and sclk_spdif_8ch on
> > > > RK3288
> > > > SoCs only feed those clocks, allow those clocks to change their
> > > > parents
> > > > all the way up the hierarchy.
> > > > 
> > > > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > > 
> > > Just as comment, if I'm seeing that right, this patch needs "clk:
> > > rockchip:
> > > handle mux dependency of fractional dividers" and friends [0] to
> > > apply and
> > > also actually handle the fractional dividers correctly.
> > > 
> > > For the clock change itself:
> > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > 
> > Oh sorry yes, i completely forgot to at that as note on this patch
> > (series). These are on top of your series as those are required to make
> > things actually work as expected.
> > 
> > Which reminds me, i was wondering how to best move that forward. Could
> > you pick this one up to include it in the next round of your series?
> > (Otherwise i'm happy to rebase it once you do a v2)
> 
> I guess that will depend on how the core series gets handled. Aka if there 
> needs to be a v2 (depending on the clock maintainers) I can pick that up as 
> part of it. Otherwise we'll just need to ping the clock-maintainers separately 
> on this patch if necessary.

I've spoken with Heiko on irc about v2 about using the coordinated clock
rates patches for handling the mux/fractional dividers thing. I'd prefer
to use the ccr approach, which puts a delay on that series.

Is there anything wrong with merging this patch #5/8 as-is? Will the
struct clk_core.rate accounting not match the hardware if we set
CLK_SET_PARENT_RATE on these clocks?

Regards,
Mike

> 
> 
> Heiko
> 
