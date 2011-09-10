From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 10 Sep 2011 12:54:55 +0800
Subject: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
In-Reply-To: <CAMQu2gwJQi55sY7aUnfcY-r8VGBPzWY2NnYUjJ-SEGiNC3Ty1Q@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
	<20110909080416.GF31581@S2100-06.ap.freescale.net>
	<4E69C9CF.6090709@ti.com>
	<20110909141321.GC32138@S2100-06.ap.freescale.net>
	<CAMQu2gxeDzFGyhsXK-wDkyiJRoD6_GN58m=3_=NC8yKa_ThJnQ@mail.gmail.com>
	<20110909152729.GG32138@S2100-06.ap.freescale.net>
	<4E6A4605.3050305@ti.com>
	<20110909233448.GH32138@S2100-06.ap.freescale.net>
	<CAMQu2gwJQi55sY7aUnfcY-r8VGBPzWY2NnYUjJ-SEGiNC3Ty1Q@mail.gmail.com>
Message-ID: <20110910045454.GA32640@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 10, 2011 at 09:08:16AM +0530, Shilimkar, Santosh wrote:
> IOn Sat, Sep 10, 2011 at 5:04 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
[...]
> > Also, IMO, lable "l2x_clean_inv" should be put after the "bne do_WFI".
> > Otherwise, my original statement (it seems l2x_clean_inv will be
> > called for case "2") stands correct :)
> >
> It's just a label. All L2 related code and checks for the valid state is
> kept under that by purpose.
> 
So for some case, you enter l2x_clean_inv but do not actually clean
and invalidate L2.  I do not see this label being used anywhere, so
you may want to remove it to save the confusion to stupid people like
me.  Just my opinion.

-- 
Regards,
Shawn
