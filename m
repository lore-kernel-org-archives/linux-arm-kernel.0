From: balbi@ti.com (Felipe Balbi)
Date: Mon, 10 Dec 2012 16:38:06 +0200
Subject: [PATCH v4 23/23] mfd: omap-usb-host: Don't spam console on
 clk_set_parent failure
In-Reply-To: <50C5C80A.3090307@ti.com>
References: <1355134833-5199-1-git-send-email-rogerq@ti.com>
 <1355134833-5199-24-git-send-email-rogerq@ti.com>
 <50C5C666.9050105@ti.com> <50C5C80A.3090307@ti.com>
Message-ID: <20121210143806.GI11038@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 01:31:22PM +0200, Roger Quadros wrote:
> On 12/10/2012 01:24 PM, Rajendra Nayak wrote:
> > On Monday 10 December 2012 03:50 PM, Roger Quadros wrote:
> >> clk_set_parent is expected to fail on OMAP3 platforms. We don't
> >> consider that as fatal so don't spam console.
> > 
> > And what if it fails on a non-OMAP3 platform?
> 
> The driver just prints a debug message and continues to work just as
> before. The USB port will not work for the user in that case. He will
> have to enable DEBUG flag to see the debug message. I see this behaviour
> better than before where all OMAP3 users see the error message for no
> reason.

I agree with Roger here.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121210/79cce1c9/attachment.sig>
