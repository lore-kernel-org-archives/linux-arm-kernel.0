From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Aug 2014 13:10:01 -0500
Subject: [PATCH v4] usb: gadget: at91_udc: move prepare clk into process
 context
In-Reply-To: <1407490962-16702-1-git-send-email-ronald.wahl@raritan.com>
References: <1407490962-16702-1-git-send-email-ronald.wahl@raritan.com>
Message-ID: <20140820181000.GW24500@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 08, 2014 at 11:42:42AM +0200, Ronald Wahl wrote:
> Commit 7628083227b6bc4a7e33d7c381d7a4e558424b6b (usb: gadget: at91_udc:
> prepare clk before calling enable) added clock preparation in interrupt
> context. This is not allowed as it might sleep. Also setting the clock
> rate is unsafe to call from there for the same reason. Move clock
> preparation and setting clock rate into process context (at91udc_probe).
> 
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>

do we need this for the -rc cycle ? Does it need to be backported to
stable releases ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/ae515790/attachment.sig>
