From: govindraj.ti@gmail.com (Govindraj)
Date: Fri, 20 Jan 2012 14:21:15 +0530
Subject: [PATCH 5/5] OMAP : serial : Check for error in
 get_context_loss_count
In-Reply-To: <1326709360-26020-6-git-send-email-shubhrajyoti@ti.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
 <1326709360-26020-6-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAAL8m4yqPSGVx19Nfgw6BSTQ1ZoZaS7s=29yDfLLqmkXyjW6bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 3:52 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> In serial_omap_runtime_resume in case of errors returned by
> get_context_loss_count print a warning and do a restore.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> ?drivers/tty/serial/omap-serial.c | ? 10 ++++++++--
> ?1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 8c6f137..e1c1a0f 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1602,10 +1602,16 @@ static int serial_omap_runtime_resume(struct device *dev)
>
> ? ? ? ?if (up) {
> ? ? ? ? ? ? ? ?if (pdata->get_context_loss_count) {
> - ? ? ? ? ? ? ? ? ? ? ? u32 loss_cnt = pdata->get_context_loss_count(dev);
> + ? ? ? ? ? ? ? ? ? ? ? int loss_cnt = pdata->get_context_loss_count(dev);


Looks ok to me,
Can you ensure off mode is tested with this patch.

--
Thanks,
Govindraj.R
