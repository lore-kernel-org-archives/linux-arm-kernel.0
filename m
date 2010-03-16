From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Mar 2010 10:05:06 +0000
Subject: [PATCH, RESEND] imx: make IMX_IO_ADDRESS assembly compatible
In-Reply-To: <84a2844cbb84d061f848657c1d2cafca86a22de5.1268728618.git.baruch@tkos.co.il>
References: <f5e757c320c6ba285c43f296013c2937ad8aa460.1268721011.git.baruch@tkos.co.il>
	<84a2844cbb84d061f848657c1d2cafca86a22de5.1268728618.git.baruch@tkos.co.il>
Message-ID: <20100316100506.GA1823@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 16, 2010 at 10:41:45AM +0200, Baruch Siach wrote:
> +#ifdef __ASSEMBLER__
> +#define IOMEM(addr,base,size,virt)	((addr) - (base) + (virt))
> +#else
> +#define IOMEM(addr,base,size,virt)			\
> +	((void __force __iomem *)			\
> +	(((unsigned long) ((addr) - (base)) < size) ?	\
> +	(addr) - (base) + (virt) : 0))
> +#endif

If you look at:

http://lists.arm.linux.org.uk/lurker/message/20100311.105637.21ac15c1.en.html

you'll see this definition is incompatible with my stated aim for this
macro.
