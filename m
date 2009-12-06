From: rshitrit@marvell.com (Ronen Shitrit)
Date: Sun, 6 Dec 2009 15:53:48 +0200
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <4B196473.2040407@denx.de>
References: <4B18F141.7070101@denx.de>
	<20091204131307.GE15887@n2100.arm.linux.org.uk>	<4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>	<4B1931B3.90301@denx.de>
	<20091204163850.GC20386@n2100.arm.linux.org.uk>	<4B194C8B.7070505@denx.de>
	<20091204191349.GG20386@n2100.arm.linux.org.uk>
	<4B196473.2040407@denx.de>
Message-ID: <309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

There isn't any known issues related to working with C=0 B=1 on Kirkwood.
Can you pls run this test on some other ARMv5 platform and approve it is working.

Thanks

-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Heiko Schocher
Sent: Friday, December 04, 2009 9:35 PM
To: Russell King - ARM Linux
Cc: linux-arm-kernel at lists.infradead.org
Subject: Re: shared memory problem on ARM v5TE using threads

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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
