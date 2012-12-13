From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 13 Dec 2012 12:04:38 +0530
Subject: [PATCH] input:stmpe-ts: Add support to report BTN_TOUCH event
In-Reply-To: <7c50ed5f531db8ab992ebeaf1a48853a6274faf2.1355376050.git.vipulkumar.samar@st.com>
References: <7c50ed5f531db8ab992ebeaf1a48853a6274faf2.1355376050.git.vipulkumar.samar@st.com>
Message-ID: <CAKohpomh_1L+TiOz5U9iRFpB-37M=NoPcidrR_VOp8ZJO83MjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2012 10:57, Vipul Kumar Samar <vipulkumar.samar@st.com> wrote:
> stmpe touchscreen supports BTN_TOUCH event but doesn't report it. Add
> BTN_TOUCH reporting capability to the stmpe touchscreen driver.
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> ---
>  drivers/input/touchscreen/stmpe-ts.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
> index 076442a..c3399a1 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -121,6 +121,7 @@ static void stmpe_work(struct work_struct *work)
>         __stmpe_reset_fifo(ts->stmpe);
>
>         input_report_abs(ts->idev, ABS_PRESSURE, 0);
> +       input_report_key(ts->idev, BTN_TOUCH, 0);
>         input_sync(ts->idev);
>  }
>
> @@ -154,6 +155,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
>         input_report_abs(ts->idev, ABS_X, x);
>         input_report_abs(ts->idev, ABS_Y, y);
>         input_report_abs(ts->idev, ABS_PRESSURE, z);
> +       input_report_key(ts->idev, BTN_TOUCH, 1);
>         input_sync(ts->idev);
>
>         /* flush the FIFO after we have read out our values. */

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
