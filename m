From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 Oct 2013 09:39:54 +0200
Subject: [PATCH] unset twsi option3 for gconfig as well
In-Reply-To: <20131014190247.GN5402@titan.lakedaemon.net>
References: <1381706847-32762-1-git-send-email-roel.kluin@gmail.com>
 <CACRpkdb8ibOm61D_iGkOkbas1475n4k5jptnRH7VFk=9+pipHQ@mail.gmail.com>
 <20131014091230.65047d00@skate> <525C3B65.30501@gmail.com>
 <20131014190247.GN5402@titan.lakedaemon.net>
Message-ID: <20131015093954.143ef68a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Mon, 14 Oct 2013 15:02:47 -0400, Jason Cooper wrote:
> On Mon, Oct 14, 2013 at 08:43:49PM +0200, Sebastian Hesselbarth wrote:
> ...
> > You know a good way to determine how far it should go back to -stable?
> 
> $ git blame -L 338,338 drivers/pinctrl/mvebu/pinctrl-dove.c
> c9f95ced drivers/pinctrl/pinctrl-dove.c (Sebastian Hesselbarth
> 2012-09-13 17:41:44 +0200 338)   gcfg2 &= ~(DOVE_TWSI_ENABLE_OPTION2 |
> DOVE_TWSI_ENABLE_OPTION2);
> 
> $ git tag --contains c9f95ced | grep '^v[23]\.[0-9][0-9]*' | sed -r -e
> 's/^(v[23]\.[0-9][0-9]*).*$/\1.x/' | sort -uV
> v3.7.x
> v3.8.x
> v3.9.x
> v3.10.x
> v3.11.x
> v3.12.x
> 
> so it should get flagged for v3.7 and newer.
> 
> Watch out for really old stuff, the regex above doesn't properly handle
> v2.6.XX.x...

The pinctrl driver for mvebu platforms was added in 3.7, if I remember
correctly.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
