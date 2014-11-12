From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Wed, 12 Nov 2014 19:03:32 +0100
Subject: [PATCH RESEND] Documentation: devicetree: Fix Xilinx VDMA
 specification
In-Reply-To: <6067bede14b9421fa87db96bdc66dc66@BN1AFFO11FD040.protection.gbl>
References: <1415800277-6817-1-git-send-email-afaerber@suse.de>
 <6067bede14b9421fa87db96bdc66dc66@BN1AFFO11FD040.protection.gbl>
Message-ID: <5463A0F4.6060300@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 12.11.2014 um 16:57 schrieb S?ren Brinkmann:
> On Wed, 2014-11-12 at 02:51PM +0100, Andreas F?rber wrote:
>> The specification requires xlnx,data-width, but example and driver use
>> xlnx,datawidth. Change the specification to match the implementation.
> 
> Isn't this the wrong way around? The bindings are considered API, so
> shouldn't the driver be fixed to match the spec?

In theory, patch review should've never let the two differ... ;)

It's not my driver, so I fixed the perceived inconsistency the least
invasive way; Michal and Srikanth seemed to concur at the time.

https://patchwork.kernel.org/patch/4620261/

> Are there already dts files out there using either of these options?

In upstream, no. microblaze and virtex440 use a
xlnx,include-datawidth-matching-0 property as precedence for the
spelling, whereas there is an fsl,data-width and an unused msix-data-width.

Downstream, yes: Beyond my own patch derived from the Parallella tree,
there's some in the ADI tree. None in the Xilinx tree on quick check.

I haven't encountered any using the documented xlnx,data-width - but
this patch was authored pre 3.17, haven't ran a full Web search again.

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/d7c7c1f9/attachment.sig>
