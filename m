From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 19 May 2014 10:31:44 +0300
Subject: [PATCH 2/4] spi: qup: Correct selection of FIFO/Block mode
In-Reply-To: <1400016884-9568-3-git-send-email-agross@codeaurora.org>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
 <1400016884-9568-3-git-send-email-agross@codeaurora.org>
Message-ID: <1400484704.1464.4.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-05-13 at 16:34 -0500, Andy Gross wrote:
> This patch fixes the calculation for determining whether to use FIFO or BLOCK
> mode.

<snip>

> @@ -368,7 +368,7 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
>  	n_words = xfer->len / w_size;
>  	controller->w_size = w_size;
>  
> -	if (n_words <= controller->in_fifo_sz) {
> +	if (n_words <= (controller->in_fifo_sz / sizeof(u32))) {

Wouldn't be better to divide by w_size? Probably will not make
too much difference, but..

>  		mode = QUP_IO_M_MODE_FIFO;

Regards,
Ivan
