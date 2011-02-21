From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 21 Feb 2011 20:37:18 +0100 (CET)
Subject: [PATCH 1/2] PRUSS UIO driver support
In-Reply-To: <20110221193316.GC2773@local>
References: <1298041530-26855-1-git-send-email-pratheesh@ti.com>
	<201102181644.17634.arnd@arndb.de>
	<alpine.LFD.2.00.1102181713480.2701@localhost6.localdomain6>
	<201102181731.05644.arnd@arndb.de>
	<alpine.LFD.2.00.1102181802580.2701@localhost6.localdomain6>
	<B85A65D85D7EB246BE421B3FB0FBB593024B83C108@dbde02.ent.ti.com>
	<20110219183427.GG4684@local>
	<B85A65D85D7EB246BE421B3FB0FBB593024B83C20F@dbde02.ent.ti.com>
	<20110221193316.GC2773@local>
Message-ID: <alpine.LFD.2.00.1102212035280.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Feb 2011, Hans J. Koch wrote:
> On Mon, Feb 21, 2011 at 09:27:47AM +0530, TK, Pratheesh Gangadhar wrote:
> > and all interrupts except IRQ_TINT1_TINT34 is set to edge trigger mode (line 160).
> 
> Is that really needed? Level triggered interrupts should certainly be
> preferred if possible.

Nonsense. If you have a sane interrupt controller which latches the
edge transitions even when masked, edge type interrupts are perfectly
fine.

Thanks,

	tglx
