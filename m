From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 06 May 2011 18:56:33 +0200
Subject: [PATCH v2 2/3] dmaengine: at_hdmac: implement pause and resume
	in atc_control
In-Reply-To: <be7d19459501aaa604aebe91daa9e9e59bb41c86.1304704588.git.nicolas.ferre@atmel.com>
References: <f4341d4672a23a958398b75cb4305e0e680f2e32.1304532833.git.nicolas.ferre@atmel.com>
	<be7d19459501aaa604aebe91daa9e9e59bb41c86.1304704588.git.nicolas.ferre@atmel.com>
Message-ID: <4DC42841.9040103@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/05/2011 19:56, Nicolas Ferre :
> Pause and resume controls are useful for audio devices. This also returns
> correct status from atc_tx_status() in case chan is paused.
> 
> Idea from dw_dmac patch by Linus Walleij.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---

V2: In case of pause, some peripheral are not draining data out of FIFO
    if they are stopped or not clocked: we need to find a way out with
    a simple timeout.

[..]

Best regards,
-- 
Nicolas Ferre
