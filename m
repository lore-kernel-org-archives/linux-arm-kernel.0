From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 18 Mar 2013 14:38:12 +0400
Subject: [PATCH 3/6] usb: ehci: mv_ehci: remove unused clock
In-Reply-To: <1363593333-6077-4-git-send-email-chao.xie@marvell.com>
References: <1363593333-6077-1-git-send-email-chao.xie@marvell.com>
 <1363593333-6077-4-git-send-email-chao.xie@marvell.com>
Message-ID: <5146EE94.9000400@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-03-2013 11:55, Chao Xie wrote:

> The origianl understanding of clock is wrong. The EHCI controller
> only have one clock input.
> Passing clock name by pdata is wrong. The clock is defined by device
> iteself.

> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
>   drivers/usb/host/ehci-mv.c |   35 ++++++++++-------------------------
>   1 files changed, 10 insertions(+), 25 deletions(-)

> diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
> index 3065809..c390827 100644
> --- a/drivers/usb/host/ehci-mv.c
> +++ b/drivers/usb/host/ehci-mv.c
[...]
> @@ -172,16 +162,11 @@ static int mv_ehci_probe(struct platform_device *pdev)
[...]
> +	ehci_mv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(ehci_mv->clk)) {
> +		dev_err(&pdev->dev, "error get clock\n");

    s/get/getting/

WBR, Sergei
