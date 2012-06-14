From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Jun 2012 14:47:14 +0300
Subject: [PATCH 09/17] i2c: omap: ack IRQ in parts
In-Reply-To: <20120614112017.GC31187@n2100.arm.linux.org.uk>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-10-git-send-email-balbi@ti.com>
 <20120614112017.GC31187@n2100.arm.linux.org.uk>
Message-ID: <20120614114712.GR13602@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 12:20:17PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 14, 2012 at 01:20:42PM +0300, Felipe Balbi wrote:
> > According to flow diagrams on OMAP TRMs,
> > we should ACK the IRQ as they happen.
> 
> You don't explain that you're adding a new dev_err() statement into the
> driver for a missing acknowledge.
> 
> What if you're probing for a device - can this cause spam to the kernel
> console?  What if you have protocol mangling enabled with the "ignore
> lack of ack bit set" ?

indeed... maybe dev_vdbg() would fit better, or just don't add anything.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/bc5c15c6/attachment.sig>
