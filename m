From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 3 Nov 2015 08:53:49 -0600
Subject: [PATCH 01/11] tty: amba-pl011: add register accessor functions
In-Reply-To: <E1ZtcvK-0007Bt-91@rmk-PC.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1ZtcvK-0007Bt-91@rmk-PC.arm.linux.org.uk>
Message-ID: <5638CA7D.8000404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> +static unsigned int pl011_read(void __iomem *base, unsigned int reg)
> +{
> +	return readw(base + reg);
> +}
> +
> +static void pl011_write(unsigned int val, void __iomem *base, unsigned int reg)
> +{
> +	writew(val, base + reg);
> +}

This has the same problem as the original, in that it doesn't support 
the SBSA subtype 13.

I'll post my version soon that addresses this.  Maybe you can consider 
it as a replacement for your patch 1/11.


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
