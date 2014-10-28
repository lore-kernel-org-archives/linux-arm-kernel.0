From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Oct 2014 23:07:40 +0000
Subject: [PATCH 3/6] ASoC: kirkwood: get rid of armada-370-db driver
In-Reply-To: <20141028235456.7d68d53e@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141028223521.GL18557@sirena.org.uk>
 <20141028235456.7d68d53e@free-electrons.com>
Message-ID: <20141028230740.GQ18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 11:54:56PM +0100, Thomas Petazzoni wrote:
> On Tue, 28 Oct 2014 22:35:21 +0000, Mark Brown wrote:

> > This is just removing support for the old binding which is
> > incompatible...

> Hum, I'm not sure to follow you here. In a subsequent patch, I change
> the Armada 370 DB audio complex DT description to use the
> simple-audio-card DT binding, which makes the Armada 370 DB audio
> machine driver irrelevant.

> Of course, this means that if someone uses an old Armada 370 DB Device
> Tree with a new kernel, it will no longer. But I believe this is kind

Yes, this is the entire point of device tree as an ABI.  We also need to
care about out of tree users.

> of expected for this specific case: when we originally introduced the
> Armada 370 DB audio support, we knew a proper DT binding to describe
> sound complex was arriving, and therefore the Armada 370 DB audio
> machine driver was only a temporary solution until the pure DT solution
> was available.

No, that's not the case - these drivers predate DT IIRC and while it's
good to avoid adding new drivers there's nothing inherently bad about
having a machine driver or adaption layer into simple card (you could do
this just as platform data for simple card for many devices).

In this particular case I'm especially worried since we've got the whole
thing with not having a good story for supporting simulataneous use of
the S/PDIF and I2S links worked out yet on the controller side and on
the simple-card side it's pretty much just the most basic CPUs that are
supported.

> Therefore, with the agreement of the mvebu maintainers, I'd like to be
> allowed to break the DT backward compatibility here, and get rid of
> this audio machine driver which would otherwise have no users left.

...in mainline.  Doesn't this hardware tend to have lots of small
variants on the design floating around?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/e8b39ce7/attachment.sig>
