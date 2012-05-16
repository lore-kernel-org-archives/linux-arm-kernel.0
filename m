From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 May 2012 14:58:56 +0300
Subject: [PATCH v1 4/7] usb: chipidea: add imx driver binding
In-Reply-To: <878vgscq4b.fsf@ashishki-desk.ger.corp.intel.com>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
 <1337090303-16046-5-git-send-email-richard.zhao@freescale.com>
 <878vgscq4b.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20120516115854.GQ17359@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 16, 2012 at 02:38:44PM +0300, Alexander Shishkin wrote:
> > +	plat_ci = platform_device_alloc("ci_hdrc", (int)res->start);
> 
> Regarding the instance id here: you probably want to use something more
> meaningful than the starting address. I was thinking about stealing id
> allocator from Felipe's dwc3 (dwc3_get_device_id()), but decided to
> first deal with more important things.
> 
> I was considering using idr for this, but it kind of feels like an
> overkill for this purpose. So I'm wondering if it makes sense to
> generalize dwc3_get_device_id() so that other drivers can make use of
> it?

Yeah, I once considered a situation were the platform_bus implementation
would handle that for us. never got to implement it though.

I would be cool to see though. Not sure how Greg would feel about it.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120516/227f265c/attachment.sig>
