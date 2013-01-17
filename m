From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 12:05:10 +0200
Subject: [[PATCH v2]] OMAP: omap4-panda: add WiLink shared transport
 power functions
In-Reply-To: <50F7CA82.4050509@ti.com>
References: <1358372702-13102-1-git-send-email-coelho@ti.com>
 <50F7C4A7.5060202@ti.com> <20130117093417.GH10814@arwen.pp.htv.fi>
 <50F7CA82.4050509@ti.com>
Message-ID: <20130117100510.GI10814@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 17, 2013 at 10:55:14AM +0100, Peter Ujfalusi wrote:
> On 01/17/2013 10:34 AM, Felipe Balbi wrote:
> >> I just wonder how this is going to work with DT... You are not going to have
> >> the ability to use callback in this form.
> >> I think the GPIO handling should be done in the driver itself rather than in
> >> the board file.
> > 
> > that can (should ?) be moved to ti-st eventually. In fact I don't know
> > why it was removed in the first place, we would need Pavan to help us
> > with that query.
> 
> Yes, this is a good question. I don't know what is the spacial thing platforms
> need to do in the callback..
> 
> > Still, for -rc, the minimal patch had to be cooked, right ?
> 
> Sure it need to be fixed. I would try to revert the patch which caused the
> issue (eccf2979 drivers/misc/ti-st: remove gpio handling).
> 
> Should fix the legacy boot, but it is going to be even bigger fun to move to
> DT (and get rid of the callbacks).
> 
> I don't have anything against this patch as such. Just wanted to point out the
> obvious that the comfort of callbacks are not going to be around in some cases.

I guess Luca's choice was to cause the minimum impact to current code,
also reverting original commit isn't free os hassles either.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/ce117e87/attachment.sig>
