From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Feb 2016 22:45:34 +0100
Subject: [PATCH] [media] zl10353: use div_u64 instead of do_div
In-Reply-To: <alpine.LFD.2.20.1602121634040.13632@knanqh.ubzr>
References: <1455287246-3540549-1-git-send-email-arnd@arndb.de>
 <6737272.LXr2g355Yt@wuerfel>
 <alpine.LFD.2.20.1602121634040.13632@knanqh.ubzr>
Message-ID: <5158925.0PEQLt1vYj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 February 2016 16:38:53 Nicolas Pitre wrote:
> On Fri, 12 Feb 2016, Arnd Bergmann wrote:
> 
> > On Friday 12 February 2016 13:21:33 Nicolas Pitre wrote:
> > > This is all related to the gcc bug for which I produced a test case 
> > > here:
> > > 
> > > http://article.gmane.org/gmane.linux.kernel.cross-arch/29801
> > > 
> > > Do you know if this is fixed in recent gcc?
> > 
> > I have a fairly recent gcc, but I also never got around to submit
> > it properly.
> > 
> > However, I did stumble over an older patch I did now, which I could
> > not remember what it was good for. It does fix the problem, and
> > it seems to be a better solution.
> 
> WTF?

Even better, it also fixes this one:

drivers/mtd/chips/cfi_cmdset_0020.c: In function 'cfi_staa_write_buffers':
drivers/mtd/chips/cfi_cmdset_0020.c:651:1: error: the frame size of 1064 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

I have not even looked what that is, I only saw show up the other day.

	Arnd
