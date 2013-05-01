From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Wed, 01 May 2013 06:55:54 -0700
Subject: [PATCH 10/21] [SCSI] nsp32: use mdelay instead of large udelay
 constants
In-Reply-To: <201304291521.14195.arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-11-git-send-email-arnd@arndb.de>
 <CALZLnaFeLcaGM7_McTZ=pKBRnpXk0AvqOTF=1YCqJv-53yk4XQ@mail.gmail.com>
 <201304291521.14195.arnd@arndb.de>
Message-ID: <1367416554.4791.8.camel@dabdike.int.hansenpartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 2013-04-29 at 15:21 +0200, Arnd Bergmann wrote:
> On Friday 26 April 2013, Masanori Goto wrote:
> > 2013/4/25 Arnd Bergmann <arnd@arndb.de>
> > >
> > > ARM cannot handle udelay for more than 2 miliseconds, so we
> > > should use mdelay instead for those.
> > >
> > 
> > Singed-off-by: GOTO Masanori <gotom@debian.or.jp>
> 
> Thanks. I assume you mean "Acked-by", not "Singed-off" as in "burnt"
> or "Signed-off" as a notification that you have applied it to your
> own git tree.
> 
> I'll keep the patch with an your "Acked-by" line in my tree unless
> James wants to apply to the scsi tree.

I can, certainly.  I'll be sending the first scsi set today, but I'll be
doing another one for just before the close of the merge window.

Goto-san, while I have your attention, is the nsp_cs driver orphaned? I
know it's not your driver, but you did once work with its author (YOKOTA
Hiroshi <yokota@netlab.is.tsukuba.ac.jp>) and I'm trying to get some
cleanup on the static functions in the header files.

Thanks,

James
