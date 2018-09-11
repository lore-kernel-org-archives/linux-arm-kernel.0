From: leo.yan@linaro.org (leo.yan at linaro.org)
Date: Tue, 11 Sep 2018 15:58:35 +0800
Subject: [PATCH 2/2] coresight: tmc: Fix writing barrier packets for ring
 buffer
In-Reply-To: <CANLsYkxACMEfzLJ7MfWiwA8+GnsQBz885T8GT+ujOtCsAT0=bg@mail.gmail.com>
References: <1536134144-2764-1-git-send-email-leo.yan@linaro.org>
 <1536134144-2764-2-git-send-email-leo.yan@linaro.org>
 <CANLsYkxACMEfzLJ7MfWiwA8+GnsQBz885T8GT+ujOtCsAT0=bg@mail.gmail.com>
Message-ID: <20180911075835.GB6110@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Mon, Sep 10, 2018 at 01:42:31PM -0600, Mathieu Poirier wrote:

[...]

> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > index e310613..9c599c9 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > @@ -387,7 +387,7 @@ static void tmc_update_etf_buffer(struct coresight_device *csdev,
> >         const u32 *barrier;
> >         u32 *buf_ptr;
> >         u64 read_ptr, write_ptr;
> > -       u32 status, to_read;
> > +       u32 status, to_read, barrier_sz = 0;
> 
> This doesn't apply on my next branch.  Please rebase and send both
> patches again.

Done.  Rebased these two patches against to CoreSight next branch [1];
please review the patch series v2 which has been sent out.

[...]

Thanks,
Leo Yan

[1] https://git.linaro.org/kernel/coresight.git/log/?h=next
