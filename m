From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 21 Apr 2012 16:09:03 +0200
Subject: [PATCH] arm: at91: fix build-error for board-dt
In-Reply-To: <20120421114001.GC9142@game.jcrosoft.org>
References: <1335004105-3162-1-git-send-email-w.sang@pengutronix.de>
 <20120421114001.GC9142@game.jcrosoft.org>
Message-ID: <20120421140903.GA6926@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2012 at 01:40:01PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 12:28 Sat 21 Apr     , Wolfram Sang wrote:
> > From: Wolfram Sang <wolfram@the-dreams.de>
> > 
> > When build-testing i2c-patches, I encountered:
> > 
> > arch/arm/mach-at91/built-in.o:(.arch.info.init+0x34): undefined reference to `at91sam926x_timer'
> > 
> > (using allnoconfig and roughly only MACH_AT91SAM_DT enabled)
> > 
> > Since this boardfile doesn't belong to a specific architecture, directly
> > add the only supported timer to compilation.
> > 
> > Signed-off-by: Wolfram Sang <wolfram@the-dreams.de>
> no this is selected by the soc
> 
> I do not want the timer be compiled un condtionally

Ok, we can discard this patch and see it as a bug report.
Since you know best what you'd like, would you send a patch?

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120421/6f706c9f/attachment.sig>
