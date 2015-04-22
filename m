From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 22 Apr 2015 07:50:21 -0600
Subject: [PATCH 01/13 v2] coresight: etm: print what version of ETM/PTM is
 detected
In-Reply-To: <1429534746-3068-1-git-send-email-linus.walleij@linaro.org>
References: <1429534746-3068-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CANLsYkx3w=9Atoz0APpom8Nx4gc=L1U2zn+cU7P57tcR5jPDGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 April 2015 at 06:58, Linus Walleij <linus.walleij@linaro.org> wrote:
> Helpfully report a bit more about the hardware found in the
> silicon when matching the AMBA device IDs by using the associated
> .data pointer in the AMBA match.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rebased on the coresight git tree.
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index c965f5724abd..66e210d5fddd 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -1859,7 +1859,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>                 goto err_arch_supported;
>         }
>
> -       dev_info(dev, "ETM initialized\n");
> +       dev_info(dev, "%s initialized\n", (char *)id->data);
>
>         if (boot_enable) {
>                 coresight_enable(drvdata->csdev);
> @@ -1890,18 +1890,22 @@ static struct amba_id etm_ids[] = {
>         {       /* ETM 3.3 */
>                 .id     = 0x0003b921,
>                 .mask   = 0x0003ffff,
> +               .data   = "ETM 3.3",
>         },
>         {       /* ETM 3.5 */
>                 .id     = 0x0003b956,
>                 .mask   = 0x0003ffff,
> +               .data   = "ETM 3.5",
>         },
>         {       /* PTM 1.0 */
>                 .id     = 0x0003b950,
>                 .mask   = 0x0003ffff,
> +               .data   = "PTM 1.0",
>         },
>         {       /* PTM 1.1 */
>                 .id     = 0x0003b95f,
>                 .mask   = 0x0003ffff,
> +               .data   = "PTM 1.1",
>         },
>         { 0, 0},
>  };
> --
> 1.9.3
>

Applied (including the V3 bits).  Thanks for the submission,
Mathieu
