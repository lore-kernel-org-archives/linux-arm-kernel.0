From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 24 Apr 2017 19:06:29 +0200 (CEST)
Subject: [PATCH 4/5 v3] usb: host: fotg2: add Gemini-specific handling
In-Reply-To: <20170421204058.6206-4-linus.walleij@linaro.org>
References: <20170421204058.6206-1-linus.walleij@linaro.org>
 <20170421204058.6206-4-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1704241853240.15211@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On Fri, 21 Apr 2017, Linus Walleij wrote:

> The Cortina Systems Gemini has bolted on a PHY inside the
> silicon that can be handled by six bits in a MISC register in
> the system controller.
> 
> If we are running on Gemini, look up a syscon regmap through
> a phandle and enable VBUS and optionally the Mini-B connector.
> 
> If the device is flagged as "wakeup-source" using the standard
> DT bindings, we also enable this in the global controller for
> respective port.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/usb/host/Kconfig       |  1 +
>  drivers/usb/host/fotg210-hcd.c | 76 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
> 

please wait for a while, I'm working on some glue code to support both 
host and device mode on FOTG.

Hans Ulli Kroll
