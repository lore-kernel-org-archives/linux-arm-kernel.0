From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Jul 2014 12:41:23 +0200
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <20140717101723.GR17528@sirena.org.uk>
References: <CAAVeFuJRCwSwcEOng2M6s+mWhJT8sUtsh7YGE-hBTGUFWAhtrQ@mail.gmail.com>
 <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
 <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
 <20140716075107.GG7978@ulmo> <53C63CBA.20809@codethink.co.uk>
 <CAAVeFuK55XzwaU+eOWhfUxJ7wEwGqxRCPDZKf+gVeMgeV8ys6g@mail.gmail.com>
 <20140717074444.GB18640@ulmo>
 <CAAVeFuJQUA+92jGpgDkyQ+=Qu+okBHzS5aFi7gmdwh+qcFp3fg@mail.gmail.com>
 <20140717101723.GR17528@sirena.org.uk>
Message-ID: <20140717104121.GF17877@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 11:17:23AM +0100, Mark Brown wrote:
> On Thu, Jul 17, 2014 at 05:55:36PM +0900, Alexandre Courbot wrote:
> 
> > Right. It may very well be that a single flag specifier (as opposed to
> > an array) will be enough for this case. If you need to request some
> > GPIOs as input and some other as output then they are clearly
> > different functions and requesting them together would be an abuse of
> > the API.
> 
> Not so sure about that - what about requesting GPIOs for a bidirectional
> bus?  Thinking about SPI bitbanging here.

Wouldn't you want to use a different means that the gpiod_array_*() API
to handle those cases? gpiod_array_*() is probably most useful to handle
bulk operations on a set of GPIOs that do essentially the same thing. If
you get and then need to index into that array to handle them all
differently then you don't gain very much.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/7c167e5d/attachment-0001.sig>
