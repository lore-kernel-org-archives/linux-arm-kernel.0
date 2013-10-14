From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 14 Oct 2013 15:15:42 -0400
Subject: [PATCH] unset twsi option3 for gconfig as well
In-Reply-To: <525C415A.2020505@gmail.com>
References: <1381706847-32762-1-git-send-email-roel.kluin@gmail.com>
 <CACRpkdb8ibOm61D_iGkOkbas1475n4k5jptnRH7VFk=9+pipHQ@mail.gmail.com>
 <20131014091230.65047d00@skate> <525C3B65.30501@gmail.com>
 <20131014190247.GN5402@titan.lakedaemon.net>
 <525C415A.2020505@gmail.com>
Message-ID: <20131014191542.GO5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 09:09:14PM +0200, Sebastian Hesselbarth wrote:
> On 10/14/2013 09:02 PM, Jason Cooper wrote:
> >On Mon, Oct 14, 2013 at 08:43:49PM +0200, Sebastian Hesselbarth wrote:
> >...
> >>You know a good way to determine how far it should go back to -stable?
> >
> >$ git blame -L 338,338 drivers/pinctrl/mvebu/pinctrl-dove.c
> >c9f95ced drivers/pinctrl/pinctrl-dove.c (Sebastian Hesselbarth
> >2012-09-13 17:41:44 +0200 338)   gcfg2 &= ~(DOVE_TWSI_ENABLE_OPTION2 |
> >DOVE_TWSI_ENABLE_OPTION2);
> >
> >$ git tag --contains c9f95ced | grep '^v[23]\.[0-9][0-9]*' | sed -r -e
> >'s/^(v[23]\.[0-9][0-9]*).*$/\1.x/' | sort -uV
> >v3.7.x
> >v3.8.x
> >v3.9.x
> >v3.10.x
> >v3.11.x
> >v3.12.x
> >
> >so it should get flagged for v3.7 and newer.
> >
> >Watch out for really old stuff, the regex above doesn't properly handle
> >v2.6.XX.x...
> 
> Ok, it is not in pre-v3.0, so the regex is fine. Thanks for the above -
> and I also see git magic to resolve the rename of pinctrl-dove.c :)

rename occurred in

  06763c7 pinctrl: mvebu: move to its own directory

which was added to v3.8

> If it originates from before the rename, I guess we need two different
> -stable patches, one for pre-rename, one for post-rename?

No, the -stable maintainers handle that.  If the patch is so complicated
that you need separate patches for the different stable trees, that's a
good indicator that it's not stable material. :-P

thx,

Jason.
