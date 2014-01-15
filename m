From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 15 Jan 2014 08:46:53 +0100
Subject: [PATCH 1/1] mmc: sdhci: fix lockdep error on tunning routine
In-Reply-To: <CAA+hA=Sb+Ve2xyto9v6YirqcXnePK2aHzJgjGZOhEQJK5Z0jqQ@mail.gmail.com>
References: <1387797184-18958-1-git-send-email-b29396@freescale.com>
 <CAA+hA=TRQP7hS3+iXyHg3FuNQKA=chJi7Ne47Ew_4RJcQ6yong@mail.gmail.com>
 <20140113120435.GQ31570@twins.programming.kicks-ass.net>
 <CAA+hA=Sb+Ve2xyto9v6YirqcXnePK2aHzJgjGZOhEQJK5Z0jqQ@mail.gmail.com>
Message-ID: <20140115084653.4f6aece8@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dong Aisheng wrote:
> On Mon, Jan 13, 2014 at 8:04 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Dec 26, 2013 at 03:58:20PM +0800, Dong Aisheng wrote:
> >> > It's strange that this issue did not happen on kernel 3.10.17 with the same
> >> > code. And looking at the code, before call spin_lock we already disable the mmc
> >> > controller irq, per on my understanding, the deadlock given by lockdep may not
> >> > be able to happen(pls fix me if wrong).
> >> > May the lockdep not track the specific irq disable?
> >> > Copy lockdep guy to comment.
> >
> > No, lockdep also doesn't know only that one line can take this lock.
> > Lockdep only knows a lock is taken from IRQ context, and disabling one
> > line still allows IRQs to happen and therefore it yells.
> 
> Okay, thanks for the information.
> If that, kernel 3.10.17 has the same code, do you know why it does not trigger
> such lockdep error?
> 
compiled with CONFIG_LOCKDEP disabled?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
