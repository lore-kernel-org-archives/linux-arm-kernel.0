From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 6 Oct 2010 18:04:23 -0700 (PDT)
Subject: [PATCH 1/3] ARM: imx: fix/define clocks and create devices for
	imx dma
In-Reply-To: <1286359219-5869-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <625327.65828.qm@web51005.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

--- On Wed, 10/6/10, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> +#if defined(CONFIG_ARCH_MX35)
> +??? if (cpu_is_mx35())
> +??? ??? ret = imx_add_imx_sdma(&imx35_imx_sdma_data);
> +??? else

Shouldn't you check the MX35 silicon version like you did for MX31?

If not checked this would fail for the old MX35 silicon. I understand that MX31 has mx31_revision() function, but there is no mx35_revision() currently.

Regards,

Fabio Estevam


      
