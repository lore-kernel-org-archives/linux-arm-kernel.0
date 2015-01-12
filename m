From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Jan 2015 16:42:14 +0100
Subject: Linux 3.19-rc3
In-Reply-To: <20150112142332.GC19807@e104818-lin.cambridge.arm.com>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <23318125.rGnCbWvYBR@wuerfel>
 <20150112142332.GC19807@e104818-lin.cambridge.arm.com>
Message-ID: <3791313.iJ2hL8LhRB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 January 2015 14:23:32 Catalin Marinas wrote:
> 
> So, I guess it's run-time cost of the LRU algorithm, especially under
> memory pressure. Harder to benchmark though (we'll see when we get
> hardware, though probably not very soon).

One thing you could try is to add an access fault handler that gathers
statistics about number of calls (you could trivially get this by
using gcov) and time spent in the handler for a workload that causes
memory pressure.

	Arnd
