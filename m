From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 09:53:20 +0200
Subject: [PATCHv2 3/7] i2c: omap: remove the dtrev
In-Reply-To: <1352025873-27492-4-git-send-email-shubhrajyoti@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-4-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121105075320.GD32468@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 04, 2012 at 04:14:29PM +0530, Shubhrajyoti D wrote:
> The dtrev is used only for the comments. Remove the same and use
> the scheme instead to know if it is version2.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

I would drop dtrev completely and not use scheme to "emulate" it. dtrev
is wrong and unnecessary; it was only created due to the wrong
assumption that HW revision register was wrong. Looks like that
assumption was made based on the driver which is clearly wrong wrt
revision detection.

Also, when dropping dtrev, also drop it from platform_data and
omap_hwmod database (could be done on a separate patch).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/8dc799ee/attachment.sig>
