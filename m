From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Jul 2014 12:05:40 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <20140717104121.GF17877@ulmo>
References: <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
 <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
 <20140716075107.GG7978@ulmo> <53C63CBA.20809@codethink.co.uk>
 <CAAVeFuK55XzwaU+eOWhfUxJ7wEwGqxRCPDZKf+gVeMgeV8ys6g@mail.gmail.com>
 <20140717074444.GB18640@ulmo>
 <CAAVeFuJQUA+92jGpgDkyQ+=Qu+okBHzS5aFi7gmdwh+qcFp3fg@mail.gmail.com>
 <20140717101723.GR17528@sirena.org.uk>
 <20140717104121.GF17877@ulmo>
Message-ID: <20140717110540.GS17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 12:41:23PM +0200, Thierry Reding wrote:
> On Thu, Jul 17, 2014 at 11:17:23AM +0100, Mark Brown wrote:

> > Not so sure about that - what about requesting GPIOs for a bidirectional
> > bus?  Thinking about SPI bitbanging here.

> Wouldn't you want to use a different means that the gpiod_array_*() API
> to handle those cases? gpiod_array_*() is probably most useful to handle
> bulk operations on a set of GPIOs that do essentially the same thing. If
> you get and then need to index into that array to handle them all
> differently then you don't gain very much.

For set and get, sure - but it's still useful to be able to do bulk
requests for GPIOs especially since that's the only bit of the interface
that requires error handling.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/c32114b8/attachment.sig>
