From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Nov 2014 13:50:49 -0600
Subject: [RESEND PATCH] usb: gadget: at91_udc: move prepare clk into
 process context
In-Reply-To: <1416411447-31112-1-git-send-email-nicolas.ferre@atmel.com>
References: <1416411447-31112-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20141120195049.GF23217@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 04:37:27PM +0100, Nicolas Ferre wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> Commit 7628083227b6bc4a7e33d7c381d7a4e558424b6b (usb: gadget: at91_udc:
> prepare clk before calling enable) added clock preparation in interrupt
> context. This is not allowed as it might sleep. Also setting the clock
> rate is unsafe to call from there for the same reason. Move clock
> preparation and setting clock rate into process context (at91udc_probe).
> 
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: <stable@vger.kernel.org> # v3.17+
> ---
> Hi Felipe,
> 
> I forgot to answer you on this patch. So I resend it now with the proper
> "stable" tag. You can also queue it during this -rc phase if you feel it is
> still possible.

I think it's late for v3.18, so it'll go on v3.19 and get backported to
3.17 and 3.18. Sorry :-s

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141120/4cbb24bd/attachment.sig>
