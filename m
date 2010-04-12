From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 19:31:48 +0100
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <s5hbpdwe9pf.wl%tiwai@suse.de>
References: <1269611685.807.55.camel@e102109-lin.cambridge.arm.com>
	<20100326140833.GK27692@sirena.org.uk>
	<1269612734.807.73.camel@e102109-lin.cambridge.arm.com>
	<1269619671.30296.1.camel@localhost.localdomain>
	<s5heij66b5o.wl%tiwai@suse.de> <4BB05A92.7010607@mvista.com>
	<s5h4ojz4l16.wl%tiwai@suse.de> <s5hfx39dmp2.wl%tiwai@suse.de>
	<20100406174157.GB12831@n2100.arm.linux.org.uk>
	<s5hbpdwe9pf.wl%tiwai@suse.de>
Message-ID: <20100412183148.GB3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 06, 2010 at 08:07:24PM +0200, Takashi Iwai wrote:
>  	writel(0x1fff, aaci->base + AACI_INTCLR);
>  	writel(aaci->maincr, aaci->base + AACI_MAINCR);
> -
> +	/*
> +	 * Fix: ac97 read back fail errors by reading
> +	 * from any arbitrary aaci register.
> +	 */
> +	readl(aaci->base + AACI_CSCH1);

This seems to be acceptable.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
