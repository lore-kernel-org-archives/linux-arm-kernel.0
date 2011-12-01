From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 1 Dec 2011 09:58:20 +0800
Subject: [RFC V1 1/8] clk: support static parent
In-Reply-To: <CAPtuhTg4a5gK96xd_jrFfYqqcdCLEFfT18_zTnufoSa4DCN2Ww@mail.gmail.com>
References: <1322046755-13511-1-git-send-email-richard.zhao@linaro.org>
 <1322046755-13511-2-git-send-email-richard.zhao@linaro.org>
 <CAPtuhThVr8si2wRpx0i32=PQCC=4h1GZr6HkRsCLHbfXBef4XA@mail.gmail.com>
 <20111124003044.GA15876@b20223-02.ap.freescale.net>
 <CAPtuhTg4a5gK96xd_jrFfYqqcdCLEFfT18_zTnufoSa4DCN2Ww@mail.gmail.com>
Message-ID: <20111201015819.GC8684@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 12:41:05PM -0800, Mike Turquette wrote:
> On Wed, Nov 23, 2011 at 4:30 PM, Richard Zhao <richard.zhao@linaro.org> wrote:
> > On Wed, Nov 23, 2011 at 02:11:40PM -0800, Mike Turquette wrote:
> >> On Wed, Nov 23, 2011 at 3:12 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> > This patch didn't remove .get_parent call. We trust .get_parent most.
> > If .get_parent must not be NULL, clocks without mux have to duplicate
> > the redundant get_parent function.
> 
> I've taken this in for V4 to accommodate DT clk binding support.  I've
> put a comment in clk_init concerning use of .get_parent versus
> statically initializing .parent.
Thanks.
I also did some basic work for imx5 clk dts. I wrote a small tool to convert
my patch to dts. I'll continue to do it once your send out v4 patch.

Richard
> 
> Thanks,
> Mike
> 
> >
> > Thanks
> > Richard
> >>
> >> Check out the way that the simple fixed-rate clk and simple gateable
> >> clk does this in drivers/clk/clk-basic.c
> >>
> >> Regards,
> >> Mike
> >>
> >> >
> >> > ? ? ? ?if (clk->ops->recalc_rate)
> >> > ? ? ? ? ? ? ? ?clk->rate = clk->ops->recalc_rate(clk);
