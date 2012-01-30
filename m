From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Jan 2012 08:33:39 +0100
Subject: [PATCH 1/4] input: mc13783_ts: rename to mc13xxx_ts
In-Reply-To: <CAOMZO5C4CfUXWZqSn+0g_gi6wEmv7L+mKhfggcV8evdUJEtVhg@mail.gmail.com>
References: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
 <1327877464-23526-2-git-send-email-marc@cpdesign.com.au>
 <CAOMZO5C4CfUXWZqSn+0g_gi6wEmv7L+mKhfggcV8evdUJEtVhg@mail.gmail.com>
Message-ID: <20120130073339.GI6305@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jan 30, 2012 at 12:52:59AM -0200, Fabio Estevam wrote:
> On Sun, Jan 29, 2012 at 8:51 PM, Marc Reilly <marc@cpdesign.com.au> wrote:
> > Start moving this driver towards support for both mc13892 and mc13783.
> >
> > This patch simply renames mc13783 specific identifiers to the generic
> > mc13xxx. A platform_device_id table is also added so that the driver
> > is still created correctly for the mc13783 only.
> >
> > Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> > ---
> > ?drivers/input/touchscreen/Kconfig ? ? ?| ? ?8 +-
> > ?drivers/input/touchscreen/Makefile ? ? | ? ?2 +-
> > ?drivers/input/touchscreen/mc13783_ts.c | ?259 -------------------------------
> > ?drivers/input/touchscreen/mc13xxx_ts.c | ?267 ++++++++++++++++++++++++++++++++
> > ?4 files changed, 272 insertions(+), 264 deletions(-)
> > ?delete mode 100644 drivers/input/touchscreen/mc13783_ts.c
> > ?create mode 100644 drivers/input/touchscreen/mc13xxx_ts.c
> 
> For the rename, it is better to do:
> git mv  drivers/input/touchscreen/mc13783_ts.c
> drivers/input/touchscreen/mc13xxx_ts.c
> 
> git commit -a
> 
> and then git format -M -1 , as it will detect the rename.
git format-patch -M will detect the rename independently of how the
commit was created. Using git mv doesn't result in adding any special
metadata to the commit, it's just mv $old $new; git rm $old; git add
$new.

But +1 on using -M (or not renaming the driver).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
