From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Apr 2014 17:25:34 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408145344.GB11052@1wt.eu>
References: <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
 <20140407174106.GD9952@obsidianresearch.com>
 <CAAfodu0kbTspq2QQf0dh3U7LB-q+ECaX9FJ35fCc25UmgPJZSg@mail.gmail.com>
 <20140407204817.GB20736@obsidianresearch.com>
 <alpine.DEB.2.10.1404072239050.32332@vroombuntu>
 <20140408064003.GU29787@1wt.eu>
 <CAFJTrDu82avr6mSaz1PNzOJ0tnQiH5aiq6URiXZAbJ=4W+2EJg@mail.gmail.com>
 <CAFJTrDtiRctixnbBEbHMsnxsPy7ew9-7SoD5cyUA6DWPU9p6Fw@mail.gmail.com>
 <20140408123632.GG8767@1wt.eu> <20140408164317.0e9b9092@skate>
 <20140408145344.GB11052@1wt.eu>
Message-ID: <20140408172534.3900f005@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Willy Tarreau,

On Tue, 8 Apr 2014 16:53:44 +0200, Willy Tarreau wrote:

> > Am I correct, or are other patches needed, or are remaining problems
> > not solved by these two fixes?
> 
> There's still the older issue I got with trying to load a 2-port based
> igb card on the xp-gp, the code says that hwirq 0xffffffe4 is invalid
> and cannot be enabled and after that it panics. I recall having debugged
> this one a few months ago, and finding something like ffffffe4 == -ENOSPC
> which was returned by one of the inner functions. Let's put that aside
> for a moment though, but I would appreciate it if you find the time to
> try your igb NIC on your XPGP in 3.14 to see if you get the same result.

See my second e-mail: this is due to improperly casting a signed value
into a unsigned value.

I currently have the igb NIC in my Armada XP DB, and I've reported a
panic :-)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
