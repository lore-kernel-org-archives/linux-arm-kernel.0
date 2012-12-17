From: stigge@antcom.de (Roland Stigge)
Date: Mon, 17 Dec 2012 19:02:45 +0100
Subject: [PATCH RESEND 0/6 v10] gpio: Add block GPIO
In-Reply-To: <50CF584E.1040601@grandegger.com>
References: <1355495185-24220-1-git-send-email-stigge@antcom.de>
 <50CB68AB.5070806@grandegger.com> <50CBBB25.20002@antcom.de>
 <50CF03FB.2030100@grandegger.com> <50CF0744.7040404@grandegger.com>
 <50CF1EF1.2070601@antcom.de> <50CF237E.5020409@antcom.de>
 <50CF4838.9000401@grandegger.com> <50CF5327.6070205@antcom.de>
 <50CF584E.1040601@grandegger.com>
Message-ID: <50CF5E45.5030104@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 06:37 PM, Wolfgang Grandegger wrote:
> 	/* Do synchronous data output with a single write access */
> 	__raw_writel(~mask, pio + PIO_OWDR);
> 	__raw_writel(mask, pio + PIO_OWER);
> 	__raw_writel(val, pio + PIO_ODSR);
> 
> For caching we would need a storage. Not sure if it's worth compared to
> a context switch into the kernel.

Block GPIO is not only for you in userspace. ;-) You can also implement
efficient n-bit bus I/O in kernel drivers, n-bit-banging. :-) So not
always context switches involved.

Roland
