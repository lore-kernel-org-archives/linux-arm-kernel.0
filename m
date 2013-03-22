From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 22 Mar 2013 12:28:59 +0100
Subject: [alsa-devel] [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
In-Reply-To: <20130322111704.GZ4977@n2100.arm.linux.org.uk>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net>
 <514B21F3.90803@metafoo.de>
 <20130321152206.GA14768@opensource.wolfsonmicro.com>
 <20130322111704.GZ4977@n2100.arm.linux.org.uk>
Message-ID: <20130322112859.GL22890@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 11:17:04AM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 21, 2013 at 04:22:06PM +0100, Mark Brown wrote:

> > FWIW it might be worth looking at the one rmk wrote but has never wanted
> > to submit for whatever reason.

> Err no, stop twisting the facts.  I know nothing is ever your fault.  You
> rejected it because it was providing support for non-cyclic supporting
> DMA engine drivers.

That might well have been one of the reasons now you mention it, I was
just remembering that the code has never been posted to the list, I've
only ever viewed it in your git trees.  IIRC it was only mentioned on
the list after the currently merged library was posted and you weren't
keen on submitting at that point due as you weren't happy with the
platform code using due to that code having to jump through hoops to
support some unusual hardware design decisions.

> I've since added support to it for cyclic DMA engines, but I've retained
> the non-cyclic support in it because I don't see why I should remove it
> when it works for me, especially given the difficulties with getting

We need support for both cyclic and non-cyclic devices, one doesn't
preclude the other and both kinds of hardware exist.  Cyclic is much
more common and generally more desirable but that doesn't mean that
hardware designers always provide it.

> anything in sound/soc changed once its been merged.

I'm sorry, what difficulties are those?

> Plus, as I've already said to you, I no longer develop and test it because
> the platform I was using is now doing service as my firewall, and you'll
> forgive me for not wanting to take the whole of *.arm.linux.org.uk
> offline to mess around with ASoC stuff.  But that's not to say I don't
> care about the issue.

Indeed, I understand why you've stopped now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130322/9919c1d8/attachment.sig>
