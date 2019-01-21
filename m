Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A232C31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:18:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3D92085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bwVhFkbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3D92085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=22/yQonRXJ0VCVEhTuTN7ewVGPYJ52PiF04WdVnCsj4=; b=bwVhFkbDU5V+1i
	tcgnKdhvutpTP4wbru/39PJD1MG6z+Tj1n5WjLbzQU+2d2XaYKBMl9+/20qnnR9TJSABFchcNZhCy
	aWu4WvYkHG+CHAWDpgvGkjjx0+UMHHoh1aRvkA1udTSRBr/UN/3Fx8O6yvfj2+xQ76GdDyWYr7fOS
	IBY5z5CGr3UPDLLPH1xusD7bRL8ExJy+Zag0VmvTsGVk3PttJAM/QnX4NIgzL1gVpxOhGJBoildWV
	zRMqwYcsiGNl5t99RI2rxoSMau3nEcPUwlqilwVUeQ/AWlxwufM/eAUIg/9Le342FfnqIZtiXSgM6
	sVKh7txHeWHDKV70h8RA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldDO-0002Ig-TP; Mon, 21 Jan 2019 17:18:26 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldDL-0002HX-84; Mon, 21 Jan 2019 17:18:24 +0000
Received: by mail-ot1-f67.google.com with SMTP id k98so21183620otk.3;
 Mon, 21 Jan 2019 09:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EFqa7iDie4a4Ugk0nz5p3iJ9mNe61MmNiPA7yNETE+A=;
 b=UscGpuaR3zsmYj4YgglG5pOurT25wHAjRU9VVUxH4nSXMiJFrI+u+J6uRz2G9gjdcK
 MTYY2/Jhy3JWL0+ibrlagEIk/MI7+9ud2CSdY1K9Huta7u+5VQNdV7mfh/W5S92NfRNR
 ubSdGE2hKAoLT5nANAQuhLcpjiteusgnlm3T/XMaeglMSf8AE9cYpIiKYLMMPNWV69ra
 baOpD2jd3i6z+2vwgemL1y64CG4nefXfJI/T17Z1fiFSU3wZy3ILRwJLY9OZQNWg9ueG
 Bw+5SNK7qK8JfklT0V7+FaPzBO3do6FGY9II96oI7GhbLK7p5DMFRFv7T7gsF7Z//IWt
 SDbA==
X-Gm-Message-State: AJcUukd5mFZU2gBGBZvKVlMMrqKbkS8QHnKlMWV19sevn3MZpLcQOhRe
 ceRtFLJ1oYygG7yxilo3xA==
X-Google-Smtp-Source: ALg8bN5rbaU1m3gtFGToJ+cqBuFcMiOvNo70Mpy1u7fQlLuyqXRrBx7gRm33fEnKbPe17VBoWnrTEg==
X-Received: by 2002:a9d:4b15:: with SMTP id q21mr20338887otf.30.1548091102479; 
 Mon, 21 Jan 2019 09:18:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r1sm6393991oie.44.2019.01.21.09.18.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 09:18:21 -0800 (PST)
Date: Mon, 21 Jan 2019 11:18:21 -0600
From: Rob Herring <robh@kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
Message-ID: <20190121171821.GA13557@bogus>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_091823_290003_64E88844 
X-CRM114-Status: GOOD (  16.08  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 10:04:06AM +0200, Mike Rapoport wrote:
> Add check for the return value of memblock_alloc*() functions and call
> panic() in case of error.
> The panic message repeats the one used by panicing memblock allocators with
> adjustment of parameters to include only relevant ones.
> 
> The replacement was mostly automated with semantic patches like the one
> below with manual massaging of format strings.
> 
> @@
> expression ptr, size, align;
> @@
> ptr = memblock_alloc(size, align);
> + if (!ptr)
> + 	panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
> size, align);
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reviewed-by: Guo Ren <ren_guo@c-sky.com>             # c-sky
> Acked-by: Paul Burton <paul.burton@mips.com>	     # MIPS
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
> Reviewed-by: Juergen Gross <jgross@suse.com>         # Xen
> ---
>  arch/alpha/kernel/core_cia.c              |  3 +++
>  arch/alpha/kernel/core_marvel.c           |  6 ++++++
>  arch/alpha/kernel/pci-noop.c              | 13 +++++++++++--
>  arch/alpha/kernel/pci.c                   | 11 ++++++++++-
>  arch/alpha/kernel/pci_iommu.c             | 12 ++++++++++++
>  arch/arc/mm/highmem.c                     |  4 ++++
>  arch/arm/kernel/setup.c                   |  6 ++++++
>  arch/arm/mm/mmu.c                         | 14 +++++++++++++-
>  arch/arm64/kernel/setup.c                 |  8 +++++---
>  arch/arm64/mm/kasan_init.c                | 10 ++++++++++
>  arch/c6x/mm/dma-coherent.c                |  4 ++++
>  arch/c6x/mm/init.c                        |  3 +++
>  arch/csky/mm/highmem.c                    |  5 +++++
>  arch/h8300/mm/init.c                      |  3 +++
>  arch/m68k/atari/stram.c                   |  4 ++++
>  arch/m68k/mm/init.c                       |  3 +++
>  arch/m68k/mm/mcfmmu.c                     |  6 ++++++
>  arch/m68k/mm/motorola.c                   |  9 +++++++++
>  arch/m68k/mm/sun3mmu.c                    |  6 ++++++
>  arch/m68k/sun3/sun3dvma.c                 |  3 +++
>  arch/microblaze/mm/init.c                 |  8 ++++++--
>  arch/mips/cavium-octeon/dma-octeon.c      |  3 +++
>  arch/mips/kernel/setup.c                  |  3 +++
>  arch/mips/kernel/traps.c                  |  3 +++
>  arch/mips/mm/init.c                       |  5 +++++
>  arch/nds32/mm/init.c                      | 12 ++++++++++++
>  arch/openrisc/mm/ioremap.c                |  8 ++++++--
>  arch/powerpc/kernel/dt_cpu_ftrs.c         |  5 +++++
>  arch/powerpc/kernel/pci_32.c              |  3 +++
>  arch/powerpc/kernel/setup-common.c        |  3 +++
>  arch/powerpc/kernel/setup_64.c            |  4 ++++
>  arch/powerpc/lib/alloc.c                  |  3 +++
>  arch/powerpc/mm/hash_utils_64.c           |  3 +++
>  arch/powerpc/mm/mmu_context_nohash.c      |  9 +++++++++
>  arch/powerpc/mm/pgtable-book3e.c          | 12 ++++++++++--
>  arch/powerpc/mm/pgtable-book3s64.c        |  3 +++
>  arch/powerpc/mm/pgtable-radix.c           |  9 ++++++++-
>  arch/powerpc/mm/ppc_mmu_32.c              |  3 +++
>  arch/powerpc/platforms/pasemi/iommu.c     |  3 +++
>  arch/powerpc/platforms/powermac/nvram.c   |  3 +++
>  arch/powerpc/platforms/powernv/opal.c     |  3 +++
>  arch/powerpc/platforms/powernv/pci-ioda.c |  8 ++++++++
>  arch/powerpc/platforms/ps3/setup.c        |  3 +++
>  arch/powerpc/sysdev/msi_bitmap.c          |  3 +++
>  arch/s390/kernel/setup.c                  | 13 +++++++++++++
>  arch/s390/kernel/smp.c                    |  5 ++++-
>  arch/s390/kernel/topology.c               |  6 ++++++
>  arch/s390/numa/mode_emu.c                 |  3 +++
>  arch/s390/numa/numa.c                     |  6 +++++-
>  arch/sh/mm/init.c                         |  6 ++++++
>  arch/sh/mm/numa.c                         |  4 ++++
>  arch/um/drivers/net_kern.c                |  3 +++
>  arch/um/drivers/vector_kern.c             |  3 +++
>  arch/um/kernel/initrd.c                   |  2 ++
>  arch/um/kernel/mem.c                      | 16 ++++++++++++++++
>  arch/unicore32/kernel/setup.c             |  4 ++++
>  arch/unicore32/mm/mmu.c                   | 15 +++++++++++++--
>  arch/x86/kernel/acpi/boot.c               |  3 +++
>  arch/x86/kernel/apic/io_apic.c            |  5 +++++
>  arch/x86/kernel/e820.c                    |  3 +++
>  arch/x86/platform/olpc/olpc_dt.c          |  3 +++
>  arch/x86/xen/p2m.c                        | 11 +++++++++--
>  arch/xtensa/mm/kasan_init.c               |  4 ++++
>  arch/xtensa/mm/mmu.c                      |  3 +++
>  drivers/clk/ti/clk.c                      |  3 +++
>  drivers/macintosh/smu.c                   |  3 +++
>  drivers/of/fdt.c                          |  8 +++++++-
>  drivers/of/unittest.c                     |  8 +++++++-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/xen/swiotlb-xen.c                 |  7 +++++--
>  kernel/power/snapshot.c                   |  3 +++
>  lib/cpumask.c                             |  3 +++
>  mm/kasan/init.c                           | 10 ++++++++--
>  mm/sparse.c                               | 19 +++++++++++++++++--
>  73 files changed, 409 insertions(+), 28 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
