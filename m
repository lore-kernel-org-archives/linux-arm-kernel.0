From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 31 Jan 2011 15:00:12 +0300
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <20110130212856.GA32737@n2100.arm.linux.org.uk>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
Message-ID: <4D46A44C.3030609@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 31-01-2011 0:28, Russell King - ARM Linux wrote:

> Linus,

> Here's another couple of fixes...

> 8<----
> Subject: [PATCH 1/2] ARM: mmci: complete the transaction on error

> When we encounter an error, make sure we complete the transaction
> otherwise we'll leave the request dangling.

> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
[...]

> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index b6fd6dc..175a623 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -319,7 +319,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>   	if (status&  MCI_DATABLOCKEND)
>   		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
>
> -	if (status & MCI_DATAEND) {
> +	if (status & MCI_DATAEND

    Shouldn't 'status & MCI_DATAEND' be enclosed in parens?

> || data->error) {

WBR, Sergei
