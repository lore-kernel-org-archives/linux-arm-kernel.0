From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Sep 2014 16:26:44 +0100
Subject: [RFC PATCH for Juno 2/2] tty: SBSA compatible UART
In-Reply-To: <1409583961-7466-3-git-send-email-hanjun.guo@linaro.org>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <1409583961-7466-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140901152644.GC29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 11:06:01PM +0800, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> This is a subset of pl011 UART which does not supprt DMA or baud rate
> changing.
> 
> It is specified in the Server Base System Architecture document from
> ARM.

Is there any reason not to consider submitting this as a TTY driver now
- are there known problems other than the issues with ACPI in general
(I've not reviewed the code at all)?  The ACPI binding in this case
seems particularly safe since it's a purposely basic and unconfigurable
IP.

I guess we may want to consider handoff to the full pl011 driver at some
point but there's a bunch of stuff with clocks to worry about before
then.

> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> ---

Missing signoff here.

> +config SBSAUART_TTY
> +	tristate "SBSA UART TTY Driver"
> +	help
> +	  Console and system TTY driver for the SBSA UART which is defined
> +	  in the Server Base System Architecure document for ARM64 servers.
> +

depends on ARM || ARM64 || COMPILE_TEST?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/be87e3d9/attachment.sig>
