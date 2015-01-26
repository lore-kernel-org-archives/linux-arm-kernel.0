From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 26 Jan 2015 21:44:09 +0100
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <20150126203751.GK26493@n2100.arm.linux.org.uk>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201501262016.52079@pali> <20150126203751.GK26493@n2100.arm.linux.org.uk>
Message-ID: <201501262144.09223@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 January 2015 21:37:51 Russell King - ARM Linux 
wrote:
> On Mon, Jan 26, 2015 at 08:16:52PM +0100, Pali Roh?r wrote:
> > This patch will cause that decompressor store full ATAG
> > structure into
> 
> > DT tree ("/atags"):
> How about something a little more radical.
> 
> Rather than trying to squeeze various ATAGs into DT, why don't
> we add a standard ATAG to contain the DT and pass that
> through into the kernel. This is IMHO how we _should_ have
> done the ATAG compatibility from the start.
> 
> That means we could get rid of most of the libfdt in the
> decompressor, and instead resolve the differences in the
> kernel.

This sounds good. Now when I patched decompressor myself with 
Revision property support, I wanted to ask same question: Why to 
convert some part from ATAGs to DT instead to pass both ATAGs and 
DT to kernel?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150126/76bf758b/attachment.sig>
