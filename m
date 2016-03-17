From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 17 Mar 2016 14:07:39 +0300
Subject: [PATCH v2 10/11] usb: musb: da8xx: Use devm in probe
In-Reply-To: <1458181615-27782-11-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-11-git-send-email-david@lechnology.com>
Message-ID: <56EA8FFB.6060506@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 3/17/2016 5:26 AM, David Lechner wrote:

> Simplify things a bit by using devm functions where possible.
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>
> v2 changes: This is part of a previous patch that was split. No changes from
> previous version.
>
>
>   drivers/usb/musb/da8xx.c | 28 ++++++++--------------------
>   1 file changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index b03d3b8..50f07a5 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
> @@ -489,32 +489,27 @@ static int da8xx_probe(struct platform_device *pdev)
>   	struct platform_device		*musb;
>   	struct da8xx_glue		*glue;
>   	struct platform_device_info	pinfo;
> -	struct clk			*clk;

    I wouldn't remove this variable to minimize the patch.

[...]

MBR, Sergei
