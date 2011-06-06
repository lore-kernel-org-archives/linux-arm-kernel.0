From: hans-christian.egtvedt@atmel.com (Hans-Christian Egtvedt)
Date: Mon, 06 Jun 2011 07:49:31 +0200
Subject: [PATCH] ATMEL, AVR32: inline nand partition table access
In-Reply-To: <BANLkTi=s4kGg5NKrzNs1nu8S00Ue_Zv8vQ@mail.gmail.com>
References: <1306676962-22308-1-git-send-email-dbaryshkov@gmail.com>
	<1306935129.1097.3.camel@hcegtvedt.norway.atmel.com>
	<BANLkTi=s4kGg5NKrzNs1nu8S00Ue_Zv8vQ@mail.gmail.com>
Message-ID: <1307339371.9413.5.camel@hcegtvedt.norway.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-06-01 at 18:54 +0400, Dmitry Eremin-Solenikov wrote:
> On 6/1/11, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com> wrote:
> > On Sun, 2011-05-29 at 17:49 +0400, Dmitry Eremin-Solenikov wrote:
> >> Currently atmel_nand driver used by AT91 and AVR32 calls a special
> >> callback
> >> which return nand partition table and number of partitions. However in all
> >> boards this callback returns just static data. So drop this callback and
> >> make atmel_nand use partition table provided statically via platform_data.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >
> > Thanks for this update, always nice seeing code being optimized. I
> > really can't recall why it was made like this in the first place...
> >
> > For the AVR32 related parts:
> >
> > Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> >
> > <snipp diff>
> >
> > Will this go through the linux-mtd tree (since it spans two archs) or
> > should it go through an arch tree?
> 
> On one hand, I'd prefer for this to go through the linux-mtd, if noone objects,
> as I'd also like to submit several (a pile) patches cleaning up mtd
> partitioning, which would depend on this.

I'm fine by sending the changes for AVR32 through linux-mtd, they are
minor and so far doesn't touch anything else that is changed.

> OTOH, I think there will be a cleanup of AT91 platform, which would bring
> lot's of conflicts with this patch, if it goes through linux-mtd.

AT91 will probably be worse, yes, should be doable by git to solve the
conflicts on its own. I'll leave it to Nicolas to give his verdict.

-- 
Hans-Christian Egtvedt
