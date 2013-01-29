From: balbi@ti.com (Felipe Balbi)
Date: Tue, 29 Jan 2013 11:57:58 +0200
Subject: [PATCH v3 10/30] USB: ehci-omap: Use PHY APIs to get the PHY
 device and put it out of suspend
In-Reply-To: <1359453032-20604-1-git-send-email-rogerq@ti.com>
References: <1359372631-8180-11-git-send-email-rogerq@ti.com>
 <1359453032-20604-1-git-send-email-rogerq@ti.com>
Message-ID: <20130129095758.GM8708@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 29, 2013 at 11:50:32AM +0200, Roger Quadros wrote:
> For each port that is in PHY mode we obtain a PHY device using the USB PHY
> library and put it out of suspend.
> 
> It is up to platform code to associate the PHY to the controller's
> port and it is upto the PHY driver to manage the PHY's resources.
> 
> Also remove wired spacing around declarations we come across.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

ideally, this would be done generically by ehci-hcd.ko itself. Alan,
would you have objections provided it doesn't break anyone else ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/44445308/attachment.sig>
