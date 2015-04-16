From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Apr 2015 15:27:03 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <09A21550-3538-4A8E-AB12-A9A516D3E866@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <20150415100153.GA11626@localhost> <2243754.JW5bGY74bP@wuerfel>
 <20150415153800.GG22741@localhost>
 <C342B5CD-D1E2-4364-B99E-C85470A869BB@theobroma-systems.com>
 <20150415172219.GE26099@e104818-lin.cambridge.arm.com>
 <552EE560.9070205@suse.de>
 <20150416110325.GB819@e104818-lin.cambridge.arm.com>
 <09A21550-3538-4A8E-AB12-A9A516D3E866@theobroma-systems.com>
Message-ID: <20150416142703.GD819@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 01:19:14PM +0200, Dr. Philipp Tomsich wrote:
> Just for the record (and to avoid anyone wasting their time on what?s available
> today): we are migrating this over to option (a) now, even though we would
> prefer to see option (b) implemented.
> 
> If we get a consensus on (b) in the next couple of days, we?ll redo things for
> option (b). If not, we will have an implementation for option (a) available that
> we can hopefully all agree on merging.

When you post, please include the libc-alpha list (I think they are fine
with cross-posting), maybe only for the cover letter as that's where the
useful discussion seems to happen.

It's interesting to re-read some older posts on x32 (it's not just
time_t affected, though probably that the most visible):

https://lwn.net/Articles/457089/
https://sourceware.org/ml/libc-alpha/2012-03/msg00487.html
https://sourceware.org/ml/libc-alpha/2012-03/msg00574.html

Basically for x32 POSIX compliance doesn't seem too critical. IIUC, the
x32 wasn't added to solve a 32-bit compatibility problem but as a
potential optimisation for specific cases.

On ARM OTOH, (one of?) the main goal for AArch64 ILP32 is to offer a
solution for 32-bit code when AArch32 is not present (and potentially
slightly more optimal than AArch32 but not necessarily when compared to
LP64).

-- 
Catalin
