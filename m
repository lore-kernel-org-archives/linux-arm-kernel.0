From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Jan 2010 10:25:36 +0000
Subject: [PATCH 2/3] ASoC: AC97: S3C: Add controller driver
In-Reply-To: <1b68c6791001261845y7635b92dm2fd4c7ad240d40c7@mail.gmail.com>
References: <1264485101-13782-1-git-send-email-jassisinghbrar@gmail.com>
	<1264485101-13782-2-git-send-email-jassisinghbrar@gmail.com>
	<20100126102343.GA24843@trinity.fluff.org>
	<1b68c6791001260303m38e6e689p2ee8c2c4c6ac2af3@mail.gmail.com>
	<1b68c6791001261845y7635b92dm2fd4c7ad240d40c7@mail.gmail.com>
Message-ID: <20100127102536.GA22551@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 11:45:24AM +0900, jassi brar wrote:
> On Tue, Jan 26, 2010 at 8:03 PM, jassi brar <jassisinghbrar@gmail.com> wrote:

> >> It would be nice t osee something to convert a 'struct snd_ac97' to a
> >> 'struct s3c_ac97_info' as this is being passed in to most place and
> >> would also help if there is ever >1 block.

> > ok, will find a way to do that.

> after looking, I found there is no convenient way to extract driver private
> data from the snd_ac97 structure. Its possible, but after ugly voodoo
> stuff.  Not to forget that no other ASoC ac97 controller driver does
> it either.
> And since we have just 1 AC97 controller in SoCs till date(no plans of
> adding another anytime soon) I think we can live with it?

I think this is fine.  It's vanishingly unlikely that we'll see CPUs
with multiple AC97 controllers and there are plenty of places in the
core which assume that there will only be a single AC97 bus in the
system.

Please also let me renew my reminder to cut irrelevant text from
replies, it really does help with finding the new text in the mail and
is especially helpful to those of us who read some of our mail on mobile
phones.
