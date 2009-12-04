From: hs@denx.de (Heiko Schocher)
Date: Fri, 04 Dec 2009 20:35:15 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091204191349.GG20386@n2100.arm.linux.org.uk>
References: <4B18F141.7070101@denx.de>
	<20091204131307.GE15887@n2100.arm.linux.org.uk>
	<4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>
	<4B1931B3.90301@denx.de>
	<20091204163850.GC20386@n2100.arm.linux.org.uk>
	<4B194C8B.7070505@denx.de>
	<20091204191349.GG20386@n2100.arm.linux.org.uk>
Message-ID: <4B196473.2040407@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell King,

Russell King - ARM Linux wrote:
> Well, the kernel messages of relevance from the dump are:
> 
> shmtest2:351: c7220140 c72179c0 0 41170000 64a1
> shmtest2:351: vma c7217968 addr 40961000 pte 064a13cf
> shmtest2:351: modified 064a13c7
> shmtest2:351: aliases 1
> shmtest2:351: vma c72179c0 addr 41170000 pte 064a13cf
> shmtest2:351: modified 064a13c7
> shmtest2:352: c7220140 c7217548 0 4197f000 64a1
> shmtest2:352: vma c7217968 addr 40961000 pte 064a13c7
> shmtest2:352: vma c72179c0 addr 41170000 pte 064a13c7
> shmtest2:352: aliases 2
> shmtest2:352: vma c7217548 addr 4197f000 pte 064a13cf
> shmtest2:352: modified 064a13c7
> shmtest2:354: c7220140 c7217650 0 4218e000 64a1
> shmtest2:354: vma c7217968 addr 40961000 pte 064a13c7
> shmtest2:354: vma c72179c0 addr 41170000 pte 064a13c7
> shmtest2:354: vma c7217548 addr 4197f000 pte 064a13c7
> shmtest2:354: aliases 3
> shmtest2:354: vma c7217650 addr 4218e000 pte 064a13cf
> shmtest2:354: modified 064a13c7
> 
> which shows that the PTEs are having their 'cacheable' bit correctly
> cleared, thus making changes to the page in RAM immediately visible to
> the user program.

Ok, sounds good :-)

> Could it be that the CPU you're using doesn't support the C=0 B=1
> PTE encoding properly, and still caches data in such a region?

Hmm.. I try to find this out, thanks!

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
