From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Sep 2015 20:35:19 +0100
Subject: [PATCH v4 04/22] of: add function to allow probing a device from
 a OF node
In-Reply-To: <CAAObsKBihtEeNN_NyTmB+U9NAJV6UmJ5LJrqBbO7h9KZPPh8LQ@mail.gmail.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-5-git-send-email-tomeu.vizoso@collabora.com>
 <20150911120824.GP12027@sirena.org.uk>
 <CAAObsKBihtEeNN_NyTmB+U9NAJV6UmJ5LJrqBbO7h9KZPPh8LQ@mail.gmail.com>
Message-ID: <20150916193519.GO12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 10:17:43AM +0200, Tomeu Vizoso wrote:

> AFAICS, this is a must currently for correct operation in simple-bus
> and simple-mfd situations, because probing order is currently very
> unpredictable and it's totally possible for the probing of a child to
> start before the probing of its parent has finished (if async probing
> is enabled or if a module is loaded that registers a child's driver at
> the wrong time).

Hrm.  That's worrying for devices that rely on peering into their parent
device for things...

> I would prefer if the core would take care of making sure that parents
> are always probed before their children, but the unconditional locking
> of the parent device stands in the way.

In the MFD case this is another reason for not putting the device
structure into the DT - if it isn't then the ordering is controlled by
the device being instantiated.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150916/a10b176a/attachment.sig>
