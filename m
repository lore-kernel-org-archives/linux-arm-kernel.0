From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 14 Oct 2014 06:31:05 -0400
Subject: [PATCHv4] serial: of-serial: fix up PM ops on no_console_suspend
 and port type
In-Reply-To: <1413276146-20388-1-git-send-email-jingchang.lu@freescale.com>
References: <1413276146-20388-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <543CFB69.50300@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2014 04:42 AM, Jingchang Lu wrote:
> This patch fixes commit 2dea53bf57783f243c892e99c10c6921e956aa7e,
> "serial: of-serial: add PM suspend/resume support", which disables
> the uart clock on suspend, but also causes a hardware hang on register
> access if no_console_suspend command line option is used.
> 
> Also, not every of_serial device is an 8250 port, so the serial8250
> suspend/resume functions should only be applied to a real 8250 port.

Thanks.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
