From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Tue, 16 May 2017 14:08:12 +0300
Subject: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
In-Reply-To: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <b4a2ed13-c71f-c973-3b09-b632e083a88b@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -2000,6 +2007,7 @@ static int lpuart_probe(struct platform_device *pdev)
>  	}
>  	sport->port.line = ret;
>  	sport->lpuart32 = sdata->is_32;
> +	lpuart_is_be = sdata->is_be;

Setting a global variable in per-device routine is quite bad design.
