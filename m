From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Jul 2014 10:48:41 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <16507628.c6raaN50oI@wuerfel> <20140714183624.GV6800@sirena.org.uk>
 <4657735.1VKsbQGuH6@wuerfel>
 <CAAVeFu+Z2xzUy6pGWu3H4MXdkBq39-USHbwNU9ih6AvvxPyu5A@mail.gmail.com>
 <53C4DF0D.8010208@metafoo.de>
 <CAAVeFuJRCwSwcEOng2M6s+mWhJT8sUtsh7YGE-hBTGUFWAhtrQ@mail.gmail.com>
 <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
 <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
Message-ID: <20140716094841.GK17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 04:28:33PM +0900, Alexandre Courbot wrote:
> On Wed, Jul 16, 2014 at 4:12 PM, Thierry Reding

> > Then again, maybe rather than add a new set of functions we should bite
> > the bullet and change gpiod_get() (and variants) to take an additional
> > flags parameter. There aren't all that many users yet (I count 26
> > outside of drivers/gpio), so maybe now would still be a good time to do
> > that.

> That sounds reasonable indeed. And preferable to getting an aneurysm
> after trying to spell devm_gpiod_get_index_optional_with_flags().

> This also makes the most sense since most GPIO users will want to set
> a direction and value right after obtaining one. So if there is no
> objection I will probably start refactoring gpiod_get() this week.

Yes, please!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/9ef242e2/attachment-0001.sig>
