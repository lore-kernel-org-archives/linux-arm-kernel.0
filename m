Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF77C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:55:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBD6222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VAf6pLeY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4mkl4eB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBD6222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UzFE9Pm5s6PubAemXOUwBA1HS/JnWeoa1us2A7FCHYk=; b=VAf6pLeYD1y/M9
	Jgfw4BOovS3Av6HjXnl9/I5L4gfb3Hk/dkcKyxIWNiFa9v2dWkJ8HNKSLoXHSLihXStxG1bBINArK
	H3Wkd7ZWwvqNAc6RJsVpO+egnasF5qy3baKAIdckUOsH2QnRtalrLlARJFzSDd3Nd9STWM0LYo8LX
	zEs/CDN18Wg7fG7SbquIuWQk9IU6/ev2ZBtra39Wo87cdtUZreTB8r94uW+gknZmi9D286/Bzj0xF
	P8E3445Hiz0w/vvPKaIqn6MaNIUTXFq0ELgzpohA0WnPhu6Vd2U24sMbkhS+sclKNsA3flaBYWhJa
	eSWTdYGc8qEDb+PUhGhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtt8h-0001D4-Ux; Wed, 13 Feb 2019 11:55:43 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtt8e-0001CX-4D
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:55:41 +0000
Received: by mail-lf1-x142.google.com with SMTP id l10so1535645lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 03:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SACQ5M4HotXM/MYLGDRFVKPHZJfogzeYcVZ+MN/XhU8=;
 b=f4mkl4eBBsyow13NsoWcy6TCJgJY3qmCYJ5OXfuE1gLUpq1a2dUlEBASHKokOdWVKk
 gezG7rROm1xc9bXetKR/SBOCewP4OG2gO8zgmTjvkcXykqIYUW2Xorftbhdz8RL6ombp
 rvy7lP0QVctGb3APbiXrl+LrqL2urnMBnbGEt+/C7BEw5mQ3fCjK59AxeX2316hADnYG
 5jI+wJUTwSeGNU6v9zCpoZTlnm6QGptLldPOdEeK2BXNLhmd9CpxNdRKxXhbAfSb702D
 x4XpUiv5Rgjtl+a8w5+I9Edkm8Xi6mYL95iJkLUKmlL2/2+dv46y1P0VHqgWg8PKJ1Co
 HKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SACQ5M4HotXM/MYLGDRFVKPHZJfogzeYcVZ+MN/XhU8=;
 b=ImsjII58fW0IQ2MiH5Tp5iPmE338Ljd3AtdM90R/3IlyR2UClENpoMFcnXUoLLDia7
 6hpzMukEonLfNaGEJGoCe0ZromVp+tfpEg2lcWWX4sAPsJcLP5WkJ/PNX1GeZxeCj4Zt
 kGEbMTLtdK8hKL6wM0l3E+0hGAmL3C1pDVRXolJmQwRjNN/nChI1vuc7+JQ8lBl6LE3D
 h8eRpaXJ+30KWlDoGSE1J14WRlTxXNW8rdX7LOudL49AVFw7WGK4MBkTtqMnZb8j3s0Q
 PqkX8VeU8/wnaBmeAIB83ZhWAk58mREZAIs3+n4pCeOJquKnGVKluIdtva6XB8DYDr31
 DE+w==
X-Gm-Message-State: AHQUAuYfEZtGQX+GyXsb4qtmL1d+W4t6pvkomYo5a7rUUkDMWWChFBOU
 SoO8Cv9Vnf8Pp6ZWLS5USBc=
X-Google-Smtp-Source: AHgI3IbdNW1WvqVvocr/4aCjt3V04aLfT7CC3QIJ6fObKnzez5pQTJ9ndpoBUkr3Ttl1NLx+85f8GQ==
X-Received: by 2002:a19:f607:: with SMTP id x7mr64132lfe.47.1550058938092;
 Wed, 13 Feb 2019 03:55:38 -0800 (PST)
Received: from localhost (pat-31-128-146-191.pool.powernet.com.ru.
 [31.128.146.191])
 by smtp.gmail.com with ESMTPSA id z85sm3151848lff.80.2019.02.13.03.55.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 03:55:37 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
Date: Wed, 13 Feb 2019 14:55:36 +0300
To: Will Deacon <will.deacon@arm.com>
Subject: Re: 5.0-rc kernel hangs on early boot
Message-ID: <20190213115536.GB8928@yury-thinkpad>
References: <20190213082134.GA21834@yury-thinkpad>
 <20190213111843.GA1912@brain-police>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213111843.GA1912@brain-police>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_035540_165483_6F2BCD7D 
X-CRM114-Status: GOOD (  21.64  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Yury Norov <yury.norov@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>,
 Mel Gorman <mgorman@techsingularity.net>, linux-kernel@vger.kernel.org,
 Zi Yan <zi.yan@cs.rutgers.edu>, David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 11:18:44AM +0000, Will Deacon wrote:
> Hi Yury,
> 
> On Wed, Feb 13, 2019 at 11:25:40AM +0300, Yury Norov wrote:
> > My kernel on qemu/arm64 setup hangs at early boot since v5.0-rc1.
> > Backtrace is not too verbose:
> > (gdb) i threads
> >   Id   Target Id         Frame
> > * 1    Thread 1 (CPU#0 [running]) 0xffff000010a49b74 in __delay (cycles=4096)
> >     at arch/arm64/lib/delay.c:49
> >   2    Thread 2 (CPU#1 [halted ]) 0x0000000000000000 in ?? ()
> >   3    Thread 3 (CPU#2 [halted ]) 0x0000000000000000 in ?? ()
> >   4    Thread 4 (CPU#3 [halted ]) 0x0000000000000000 in ?? ()
> > (gdb) bt
> > #0  0xffff000010a49b74 in __delay (cycles=4096) at arch/arm64/lib/delay.c:49
> > Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> > 
> > Reverting the patch
> > 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> > fragmentation event occurs") together with following patch
> > 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> > helps me to boot normally. 
> > 
> > Some system information is below, and config is attached.
> 
> FWIW, running with your command-line and .config under KVM with earlycon
> leads to an early page allocation failure followed by a NULL dereference
> during boot if only 1G is configured (log below). For the mm folks, it's
> probably worth pointing out that you're using 64k pages.
> 
> Can you confirm that the kernel boots successfully if you pass more memory to
> qemu (e.g. 2gb)?

2G workaround works, I confirm. Also, Mel's fix provided in this thread works
as well.

Thanks,
Yury

> Will
> 
> --->8
> 
> [    0.000000] swapper: page allocation failure: order:0, mode:0x0(), nodemask=(null),cpuset=(null),mems_allowed=0-3
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc64.9.0+ #1
> [    0.000000] Hardware name: linux,dummy-virt (DT)
> [    0.000000] Call trace:
> [    0.000000]  dump_backtrace+0x0/0x178
> [    0.000000]  show_stack+0x24/0x30
> [    0.000000]  dump_stack+0x90/0xb4
> [    0.000000]  warn_alloc+0x100/0x188
> [    0.000000]  __alloc_pages_nodemask+0xd48/0xd88
> [    0.000000]  alloc_pages_current+0x8c/0xf8
> [    0.000000]  allocate_slab+0x370/0x4a8
> [    0.000000]  new_slab+0x98/0xc0
> [    0.000000]  ___slab_alloc+0x27c/0x510
> [    0.000000]  __slab_alloc+0x50/0x68
> [    0.000000]  kmem_cache_alloc+0x1d0/0x1f8
> [    0.000000]  bootstrap+0x34/0x170
> [    0.000000]  kmem_cache_init+0x9c/0x130
> [    0.000000]  start_kernel+0x240/0x464
> [    0.000000] Mem-Info:
> [    0.000000] active_anon:0 inactive_anon:0 isolated_anon:0
> [    0.000000]  active_file:0 inactive_file:0 isolated_file:0
> [    0.000000]  unevictable:0 dirty:0 writeback:0 unstable:0
> [    0.000000]  slab_reclaimable:0 slab_unreclaimable:1
> [    0.000000]  mapped:0 shmem:0 pagetables:0 bounce:0
> [    0.000000]  free:7737 free_pcp:0 free_cma:0
> [    0.000000] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> [    0.000000] Node 0 DMA32 free:495168kB min:524288kB low:524288kB high:524288kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1048576kB managed:495232kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    0.000000] lowmem_reserve[]: 0 0 0
> [    0.000000] Node 0 DMA32: 1*64kB (U) 4*128kB (U) 2*256kB (U) 3*512kB (U) 3*1024kB (U) 1*2048kB (U) 3*4096kB (U) 2*8192kB (U) 2*16384kB (U) 3*32768kB (U) 3*65536kB (U) 1*131072kB (U) 0*262144kB 0*524288kB = 495168kB
> [    0.000000] 0 total pagecache pages
> [    0.000000] 0 pages in swap cache
> [    0.000000] Swap cache stats: add 0, delete 0, find 0/0
> [    0.000000] Free swap  = 0kB
> [    0.000000] Total swap = 0kB
> [    0.000000] 16384 pages RAM
> [    0.000000] 0 pages HighMem/MovableOnly
> [    0.000000] 8646 pages reserved
> [    0.000000] 8192 pages cma reserved
> [    0.000000] SLUB: Unable to allocate memory on node -1, gfp=0x408000(GFP_NOWAIT|__GFP_ZERO)
> [    0.000000]   cache: kmem_cache, object size: 336, buffer size: 384, default order: 0, min order: 0
> [    0.000000]   node 0: slabs: 0, objs: 0, free: 0
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    0.000000] Mem abort info:
> [    0.000000]   ESR = 0x96000045
> [    0.000000]   Exception class = DABT (current EL), IL = 32 bits
> [    0.000000]   SET = 0, FnV = 0
> [    0.000000]   EA = 0, S1PTW = 0
> [    0.000000] Data abort info:
> [    0.000000]   ISV = 0, ISS = 0x00000045
> [    0.000000]   CM = 0, WnR = 1
> [    0.000000] [0000000000000000] user address but active_mm is swapper
> [    0.000000] Internal error: Oops: 96000045 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc64.9.0+ #1
> [    0.000000] Hardware name: linux,dummy-virt (DT)
> [    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
> [    0.000000] pc : __memcpy+0x110/0x180
> [    0.000000] lr : bootstrap+0x48/0x170
> [    0.000000] sp : ffff00001104ff20
> [    0.000000] x29: ffff00001104ff20 x28: 0000000080ea0018 
> [    0.000000] x27: 0000000000000000 x26: 0000000000000000 
> [    0.000000] x25: 0000000000000000 x24: ffff000010f80008 
> [    0.000000] x23: ffff000010f92490 x22: ffff000011070000 
> [    0.000000] x21: ffff000010f92490 x20: ffff000011a1f000 
> [    0.000000] x19: 0000000000000000 x18: 0000000000000010 
> [    0.000000] x17: 0000000000000000 x16: 0000000000000000 
> [    0.000000] x15: ffffffffffffffff x14: 00000000ffffffff 
> [    0.000000] x13: 00000000000000aa x12: 000000aa000000aa 
> [    0.000000] x11: 0000000d00000000 x10: 0000015000000180 
> [    0.000000] x9 : 0000000000000005 x8 : 0000000040002000 
> [    0.000000] x7 : ffff000011030e80 x6 : 0000000000000000 
> [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000 
> [    0.000000] x3 : 0000000000000000 x2 : 00000000000000d0 
> [    0.000000] x1 : ffff000010f924d0 x0 : 0000000000000000 
> [    0.000000] Process swapper (pid: 0, stack limit = 0x(____ptrval____))
> [    0.000000] Call trace:
> [    0.000000]  __memcpy+0x110/0x180
> [    0.000000]  kmem_cache_init+0x9c/0x130
> [    0.000000]  start_kernel+0x240/0x464
> [    0.000000] Code: a8c12027 a8c12829 a8c1302b a8c1382d (a88120c7) 
> [    0.000000] ---[ end trace a6053f496cb6dec0 ]---
> [    0.000000] Kernel panic - not syncing: Fatal exception
> [    0.000000] ---[ end Kernel panic - not syncing: Fatal exception ]---

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
