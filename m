From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 Feb 2013 13:03:55 +0200
Subject: [PATCH 3/5] ARM: OMAP2: MUSB: Specify omap4 has mailbox
In-Reply-To: <20130206105713.GF17852@n2100.arm.linux.org.uk>
References: <1360130294-5976-1-git-send-email-kishon@ti.com>
 <1360130294-5976-4-git-send-email-kishon@ti.com>
 <20130206105713.GF17852@n2100.arm.linux.org.uk>
Message-ID: <20130206110355.GH22064@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 06, 2013 at 10:57:13AM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 06, 2013 at 11:28:11AM +0530, Kishon Vijay Abraham I wrote:
> > Added has_mailbox to the musb platform data to specify that omap uses
> > an external mailbox (in control module) to communicate with the musb
> > core during device connect and disconnect.
> 
> So, I've been through your five patches looking for any other users of
> "has_mailbox" and I can find none.  You introduce this in this patch,
> and you set it.  But I don't see anything that uses it.
> 
> Write only variables are not useful.

looking back at what I sent Greg this was probably my fault. When taking
Kishon's patches (in particular $SUBJECT) I removed some of arch/arm/
code and ended up forgetting to add the include file which introduces
has_mailbox.

This means that my lack of attention has introduced a compile break on
Greg's tree. Oh well, s**t happens. In any case, the user is already in
Greg's tree and there's no way Greg will rebase his tree to amend
$SUBJECT there, so it will have to go separately.

I didn't even notice this before because I had the diff in my tree, just
forgot to git add and/or git reset. Too late now

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130206/d47e6068/attachment.sig>
