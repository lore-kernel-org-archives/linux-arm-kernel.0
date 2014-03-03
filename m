From: balbi@ti.com (Felipe Balbi)
Date: Mon, 3 Mar 2014 10:33:08 -0600
Subject: [PATCH] usb: gadget: atmel_usba: Fix crashed during stopping
 when DEBUG is enabled
In-Reply-To: <1393598066-4016-1-git-send-email-gregory.clement@free-electrons.com>
References: <1393598066-4016-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140303163308.GA10987@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 03:34:01PM +0100, Gregory CLEMENT wrote:
> The debug trace in the atmel_usba_stop function made the assumption
> that the driver pointer passed in parameter was not NULL. Since the
> commit "usb: gadget: udc-core: fix a regression during gadget driver
> unbinding", it was no more always true. This lead to a kernel crash.
> 
> This commit now use the driver pointer stored in udc which fixes this
> issue.
> 
> Since the commit which have triggered this issue was backported to the
> 3.2 stable branch, then this one should also be backported to the same
> kernel.
> 
> Cc: stable at vger.kernel.org # v3.2+
> Fixes: 511f3c5326ea (usb: gadget: udc-core: fix a regression during gadget driver unbinding)

this line shouldn't be here and you're missing a SoB line, can't take
this patch, sorry.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/43f67785/attachment.sig>
