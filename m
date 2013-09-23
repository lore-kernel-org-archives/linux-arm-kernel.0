From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Sep 2013 15:43:49 -0500
Subject: [PATCH 30/41] usb: musb: ux500: Don't supply a con_id when
 requesting the clock
In-Reply-To: <1379506478-16625-31-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
 <1379506478-16625-31-git-send-email-lee.jones@linaro.org>
Message-ID: <20130923204349.GJ309@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Wed, Sep 18, 2013 at 01:14:27PM +0100, Lee Jones wrote:
> If we supply a con_id then the clock framework will search for that name
> in MUSB's Device Tree node for the 'clock-names' property. If it's absent
> the clock request will fail. However, if we don't supply the con_id then
> clk_get() will call into clk_sys() which will use the device name to
> search for the appropriate clock, which is much more natural than forcing
> 'usb'.
> 
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

fine by me :-)

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/96d5d51e/attachment.sig>
