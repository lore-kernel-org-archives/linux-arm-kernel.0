From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 28 May 2017 21:17:09 +0200
Subject: PROBLEM: ARM Cache policy on single armv7 processor lead to low
 DRAM performance
In-Reply-To: <CAOEkoLwq1fdVuhkm_Z4Lf1BL0XxLyumSxLF7gDPyK_NkzUdVgQ@mail.gmail.com>
References: <CAOEkoLwq1fdVuhkm_Z4Lf1BL0XxLyumSxLF7gDPyK_NkzUdVgQ@mail.gmail.com>
Message-ID: <20170528191709.GC20159@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> We met some DDR performance issue caused by armv7 cache policy, hope
> you can help.
> On a single armv7(Cortex-A7) processor system, the arm linux kernel,
> without CONFIG_SMP, the cache policy is set to write-back no-allocate,
> which lead to very low DRAM speed,
> around 7MB/s for write, 28MB/s for read.
> If enable CONFIG_SMP and CONFIG_SMP_ON_UP, then the cache policy is
> changed to write-back read-write-allocate, and the DRAM speed is
> improved a lot, around 120MB/s for write, 160MB/s for read.

Just out of curiosity, is not that still 10x lower than expected? What kind of
system is that?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
