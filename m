From: w@1wt.eu (Willy Tarreau)
Date: Wed, 8 May 2013 00:12:37 +0200
Subject: MVNETA irq with backport-3.8
In-Reply-To: <51897810.8020002@free-electrons.com>
References: <51890C29.8000504@itooo.com> <20130507181823.23342ffb@skate>
 <51892E87.5020903@itooo.com> <518971D4.5000603@free-electrons.com>
 <20130507214256.GC5414@1wt.eu> <51897810.8020002@free-electrons.com>
Message-ID: <20130507221237.GD5414@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gr?gory,

On Tue, May 07, 2013 at 11:54:24PM +0200, Gregory CLEMENT wrote:
> Thanks for your help but I finally found the guilty commit, it was
> "66d0539 net: mvneta: convert to percpu interrupt".

Cool! Indeed I remember about this one that you proposed to me to
fix a regression I was experiencing on my mirabox after I picked
this one :

   f492fcf arm: mvebu: Add support for local interrupt

> This commit was never submitted because finally I realized that it was
> broken in SMP.

Yes I remember you explained me this.

> Finally it was the commit "arm: mvebu: Use local
> interrupt only for the timer 0" which was the correct solution.

Perfect.

(...)
> So Greg, the solution is just to revert the commit 66d0539. I am going
> to update the backport-3.8 branch in a couple of minutes.

Maybe it could be useful to think about backport-3.9 soon ? :-)

Best regards,
Willy
