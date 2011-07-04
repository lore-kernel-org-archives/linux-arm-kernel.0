From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Jul 2011 16:25:25 +0200
Subject: [PATCH for 3.0] AT91: Change nand buswidth logic to match
	hardware default configuration
In-Reply-To: <4E1189BD.509@atmel.com>
References: <1309515924-22531-1-git-send-email-nicolas.ferre@atmel.com>
	<4E1189BD.509@atmel.com>
Message-ID: <201107041625.25972.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 July 2011, Nicolas Ferre wrote:
> Le 01/07/2011 12:25, Nicolas Ferre :
> > The recently modified nand buswitth configuration is not aligned with
> > board reality: the double footprint on boards is always populated with 8bits
> > buswidth nand flashes.
> > So we have to consider that without particular configuration the 8bits
> > buswidth is selected by default.
> > Moreover, the previous logic was always using !board_have_nand_8bit(), we
> > change it to a simpler: board_have_nand_16bit().
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Arnd,
> 
> Can you please handle this parch for 3.0-final as a bug fix through the
> arm-soc.git tree?
> 
> You can queue it in addition of the pull request sent by
> Jean-Christophe: "AT91: Fix pull requset".

Ok, I've integrated it in the branch and will send the pull request.

My preference would be to see fixes this late in the cycle more
minmal. This patch does two things: 1. change the polarity of the
system_rev bit as a bug fix and 2. change the polarity of the
function reading it as a cleanup. Both changes look absolutely
ok, but it's better to do the cleanup for the next kernel.

In this case, studying the patch more closely shows that it's
very harmless, but I'd rather not have to look that closely.

Am I correct that the bug is a regression against 2.6.39?

	Arnd
