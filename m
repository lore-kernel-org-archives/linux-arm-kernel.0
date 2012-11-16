From: balbi@ti.com (Felipe Balbi)
Date: Fri, 16 Nov 2012 09:52:58 +0200
Subject: [PATCH] ARM: OMAP2+: Fix compiler warning for 32k timer
In-Reply-To: <50A56033.6080908@ti.com>
References: <1353008644-24745-1-git-send-email-jon-hunter@ti.com>
 <20121115204526.GC12466@arwen.pp.htv.fi> <50A56033.6080908@ti.com>
Message-ID: <20121116075258.GC15669@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 15, 2012 at 03:35:47PM -0600, Jon Hunter wrote:
> 
> On 11/15/2012 02:45 PM, Felipe Balbi wrote:
> > Hi,
> > 
> > On Thu, Nov 15, 2012 at 01:44:04PM -0600, Jon Hunter wrote:
> >> +static struct of_device_id omap_counter_match[] __initdata = {
> > 
> > not directly related to $SUBJECT, but shouldn't this be static const
> > __initconst ?
> 
> Yes you are right. Looks like there are several other of_device_id
> structs in arch/arm/mach-omap2 that could be updated to const too.

here's a quick sed substitution for you:

$ sed -i 's/static \(struct of_device_id\)\s\(\w\+\[\]\)\s\(__initdata\|\)/static const \1 \2 __initconst/' arch/arm/*omap*/*.c

It worked fine here.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/76d5735a/attachment.sig>
