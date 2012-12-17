From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 16 Dec 2012 23:11:45 -0800
Subject: [PATCH] input:stmpe-ts: Add support to report BTN_TOUCH event
In-Reply-To: <20121213091004.GF27617@gmail.com>
References: <7c50ed5f531db8ab992ebeaf1a48853a6274faf2.1355376050.git.vipulkumar.samar@st.com>
 <20121213091004.GF27617@gmail.com>
Message-ID: <20121217071144.GA10898@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 09:10:04AM +0000, Lee Jones wrote:
> On Thu, 13 Dec 2012, Vipul Kumar Samar wrote:
> 
> > stmpe touchscreen supports BTN_TOUCH event but doesn't report it. Add
> > BTN_TOUCH reporting capability to the stmpe touchscreen driver.
> > 
> > Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> > ---
> >  drivers/input/touchscreen/stmpe-ts.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
> > index 076442a..c3399a1 100644
> > --- a/drivers/input/touchscreen/stmpe-ts.c
> > +++ b/drivers/input/touchscreen/stmpe-ts.c
> > @@ -121,6 +121,7 @@ static void stmpe_work(struct work_struct *work)
> >  	__stmpe_reset_fifo(ts->stmpe);
> >  
> >  	input_report_abs(ts->idev, ABS_PRESSURE, 0);
> > +	input_report_key(ts->idev, BTN_TOUCH, 0);
> >  	input_sync(ts->idev);
> >  }
> >  
> > @@ -154,6 +155,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
> >  	input_report_abs(ts->idev, ABS_X, x);
> >  	input_report_abs(ts->idev, ABS_Y, y);
> >  	input_report_abs(ts->idev, ABS_PRESSURE, z);
> > +	input_report_key(ts->idev, BTN_TOUCH, 1);
> >  	input_sync(ts->idev);
> >  
> >         /* flush the FIFO after we have read out our values. */
> > -- 
> > 1.7.2.2
> 
> So long as it's tested/working, the code looks fine so:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

Applied, thank you.

-- 
Dmitry
