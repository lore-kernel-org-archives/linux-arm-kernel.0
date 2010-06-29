From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 29 Jun 2010 09:41:36 +0300
Subject: [PATCH] mxc_nand: fix PM
In-Reply-To: <4C15D542.2060102@eukrea.com>
References: <1274942000-3580-2-git-send-email-eric@eukrea.com>
	<1274982919-13251-1-git-send-email-eric@eukrea.com>
	<4C15D542.2060102@eukrea.com>
Message-ID: <1277793696.1041.967.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-06-14 at 09:07 +0200, Eric B?nard wrote:
> Hi Sascha,
> 
> Le 27/05/2010 19:55, Eric B?nard a ?crit :
> > * when resuming, we get the following log :
> > nand_resume called for a chip which is not in suspended state
> > * this happens because mtd->suspend and mtd->resume are already
> > called from the mtd layer, thus they were called a second time
> > in mxc_nand so mtd complains when trying to resume for the
> > second time
> > * the fix is to remove these call and thus remove the supend and
> > resume functions of mxc_nand
> >
> any news concerning this patch ?
> 

Pushed to l2-mtd-2.6.git / dunno

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
