From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Feb 2014 12:51:13 +0000
Subject: [PATCH 07/17] spi: pl022: Don't ignore power domain and amba bus
 at system suspend
In-Reply-To: <CAPDyKFqNdw-6R12cUOre8UOTOnB-PpxHD5rPAMCwuS3i--Sesg@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-8-git-send-email-ulf.hansson@linaro.org>
 <20140204191609.GU22609@sirena.org.uk>
 <CAPDyKFqNdw-6R12cUOre8UOTOnB-PpxHD5rPAMCwuS3i--Sesg@mail.gmail.com>
Message-ID: <20140210125113.GZ1757@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 01:33:50PM +0100, Ulf Hansson wrote:
> On 4 February 2014 20:16, Mark Brown <broonie@kernel.org> wrote:

> > This seems like a fairly hideous thing to be having to open code in an
> > individual driver, it all looks generic and like something that most if

...

> > Putting it in a helper would at least mean that it's easier for the
> > mechanics to be transferred to the core proper later on.

> I agree, a helper function would be nice. I have earlier sent a patch
> to the PM core, that is similar to the code above, though it was
> rejected in it's current form. Let me follow up on this again.

> At this point, would a way forward be to still go ahead with this
> patch and then convert to, when/if, the helper function from the PM
> core becomes available?

It's definitely *a* way forward, but I'm not convinced it's a good way
forward.  Since it's something that I'd expect us to be doing in all
drivers we'd want to replicate it all over the place which is obviously
not good, or conversely if there are issues that prevented the code
being added to the PM core then presumably we're just adding problematic
code to the driver (you've not mentioned what the problems were with
doing this in the PM core).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/caed4c27/attachment.sig>
