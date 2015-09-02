From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 2 Sep 2015 09:52:35 +0800
Subject: [PATCH v3 4/5] clk: Hi6220: add stub clock driver
In-Reply-To: <CAMAWPa8dNOipiFFv96J5XvP1Qs7ysHBD6_-RpMGqCEdPAKxHAA@mail.gmail.com>
References: <1438564418-15948-1-git-send-email-leo.yan@linaro.org>
 <1438564418-15948-5-git-send-email-leo.yan@linaro.org>
 <CAMAWPa8dNOipiFFv96J5XvP1Qs7ysHBD6_-RpMGqCEdPAKxHAA@mail.gmail.com>
Message-ID: <20150902015235.GA7763@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, Sep 01, 2015 at 05:28:03PM -0700, Kevin Hilman wrote:
> On Sun, Aug 2, 2015 at 6:13 PM, Leo Yan <leo.yan@linaro.org> wrote:
> > On Hi6220, there have some clocks which can use mailbox channel to send
> > messages to power controller to change frequency; this includes CPU, GPU
> > and DDR clocks.
> >
> > For dynamic frequency scaling, firstly need write the frequency value to
> > SRAM region, and then send message to mailbox to trigger power controller
> > to handle this requirement. This driver will use syscon APIs to pass SRAM
> > memory region and use common mailbox APIs for channels accessing.
> >
> > This init driver will support cpu frequency change firstly.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> The kernelci.org build/boot bot detected boot failures in
> linux-next[1], and the failure was bisected down to this patch (landed
> in linux-next as commit c1628a2c416da947f5afac615d53189250fa49cb.
> 
> I verifed that reverting this commit on top of next-20150901 gets the
> hikey booting again.

Thanks for reporting. This issue has been confirmed at my side, it's
caused by the patch have added dependency with MAILBOX, will fix this
issue and send patch.

Thanks,
Leo Yan
