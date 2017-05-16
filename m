From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Tue, 16 May 2017 14:15:08 +0300
Subject: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
In-Reply-To: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <fb9fe0cd-5ca7-74e6-33dc-7638e205b2e3@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  static u32 lpuart32_read(void __iomem *addr)
>  {
> -	return ioread32be(addr);
> +	return lpuart_is_be ? ioread32be(addr) : readl(addr);
>  }
>  
>  static void lpuart32_write(u32 val, void __iomem *addr)
>  {
> -	iowrite32be(val, addr);
> +	if (lpuart_is_be)
> +		iowrite32be(val, addr);
> +	else
> +		writel(val, addr);
>  }

What if this is ever executed on big endian system?
