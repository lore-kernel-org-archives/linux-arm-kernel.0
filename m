Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F319C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:02:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7CD20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sas8W9J9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7CD20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1w85oLqlOEUeKLbcxGOrWORB1JDAEKhCw8TXLAlzM3Q=; b=sas8W9J9HPyx4A
	h82KbT1K4dcYiceNbWKZh3LAxiXW5GlSJncLUBaiiBT5lQmZ8+Z8kUdpe561wDA+aR9ctDZLNl4SO
	Ghd4KVG4P1FmAFQ/1VMtL9uI9l8U29xeQEQ2cYTELCtCFq3Q46JpYMjv061s+pAeklvTQ32UXyPz5
	MvkKIKQ08xYWEo34fGaFIDGDsK40BVax2TY7Gu7IyxSk91Dj5JgwMLqZp59ZGzGT+TLetNuFpsYfp
	gu1b+2/06JLhaipgfG5dneqIHEnOcw/bWWNmo514tNf6DGLaBuxXnFN8wrQirtezrPFx12Kg1ZuqO
	Ut/5N6qpn8GJn5zM8yJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXfcF-0001Eh-2N; Fri, 14 Dec 2018 05:02:23 +0000
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXfcA-0001De-1D
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 05:02:21 +0000
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so3823249ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 21:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eCaMjQoJF+/9nPt+yVRblwzG43JzuBI6czYr/M1JOog=;
 b=Jk3zuOzfMD83KaMv87NeUXXXagyf5gqni+NRl2NJJs0celzGlcXJSbbvGz9tY++fiy
 Zh+UDcAlYPJrLswCRpg6Fh/HEWlhr4K3mNkHFfZcEV7rVmS61bMTRDSwpM4TC1Othc3U
 MaNr/vAALOKkvIC2loQwANXzuR2Nko72gPR7rS8Pgy+eqh5n+mr4r/fxlvONrAkz/9i8
 TxbZIDWT40SD2RdVqKgfQ0a+Rc6Imj1RCT2OTZflu7JX/8lQvMoNVecUnx+klmEE0wTl
 YxD0nq4+QAn7ZGd4MfGpSzioJk3bHE/CWffGmLV/Dqx2Jj745kCCOlKVHhmrqI9COMdm
 B3Ew==
X-Gm-Message-State: AA+aEWatnFGHovXisN3uCorxNDzWw787eSDrEwS3JQXwlsZ5GO+K+8eF
 Cbb+TPsmEYvnP4ChcVcDc+ESTRJJgJmxck4AxZer/w==
X-Google-Smtp-Source: AFSGD/WAcqcCXczhW/n2ORIL+U6gvQCHO2YVZ/hdKEffT5iZLZ3A/fkzvZ0r2wWl++yxve3n0NM/n1xIhQzsgbxszjA=
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr802675ljh.63.1544763725591; 
 Thu, 13 Dec 2018 21:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20181213052259.56352-1-cai@lca.pw>
 <20181214040819.58625-1-cai@lca.pw>
In-Reply-To: <20181214040819.58625-1-cai@lca.pw>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 14 Dec 2018 10:31:52 +0530
Message-ID: <CACi5LpNQ1WGE54uv35OwNmJkKR_xnqTNqFK+R9oFBVkb683z_Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
To: cai@lca.pw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_210218_076742_B2AE30CA 
X-CRM114-Status: GOOD (  24.66  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 kexec mailing list <kexec@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 9:39 AM Qian Cai <cai@lca.pw> wrote:
>
> On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
> dump just hung. It has 4 threads on each core. Each 2-core share a same
> L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
> L3 cache.
>
> It turned out that this was due to the TLB contained stale entries (or
> uninitialized junk which just happened to look valid) before turning the
> MMU on in the second kernel which caused this instruction hung,
>
> msr     sctlr_el1, x0
>
> Although there is a local TLB flush in the second kernel in
> __cpu_setup(), it is called too early. When the time to turn the MMU on
> later, the TLB is dirty again from some reasons.
>
> Also tried to move the local TLB flush part around a bit inside
> __cpu_setup(), although it did complete kdump some times, it did trigger
> "Synchronous Exception" in EFI after a cold-reboot fairly often that
> seems no way to recover remotely without reinstalling the OS. For
> example, in those places,
>
> ENTRY(__cpu_setup)
> +       isb
>         tlbi    vmalle1
>         dsb     nsh
>
> or
>
>         mov     x0, #3 << 20
>         msr     cpacr_el1, x0
> +       tlbi    vmalle1
> +       dsb     nsh
>
> Since it is only necessary to flush local TLB right before turning the
> MMU on, just re-arrage the part a bit like the one in __primary_switch()
> within CONFIG_RANDOMIZE_BASE path, so it does not depends on other
> instructions in between that could pollute the TLB, and it no longer
> trigger "Synchronous Exception" as well.
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>
> v2: merge the similar part from __cpu_setup() pointed out by James.
>
>  arch/arm64/kernel/head.S | 4 ++++
>  arch/arm64/mm/proc.S     | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4471f570a295..7f555dd4577e 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
>         msr     ttbr0_el1, x2                   // load TTBR0
>         msr     ttbr1_el1, x1                   // load TTBR1
>         isb
> +
> +       tlbi    vmalle1                         // invalidate TLB
> +       dsb     nsh
> +
>         msr     sctlr_el1, x0
>         isb
>         /*
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 2c75b0b903ae..14f68afdd57f 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -406,9 +406,6 @@ ENDPROC(idmap_kpti_install_ng_mappings)
>   */
>         .pushsection ".idmap.text", "awx"
>  ENTRY(__cpu_setup)
> -       tlbi    vmalle1                         // Invalidate local TLB
> -       dsb     nsh
> -
>         mov     x0, #3 << 20
>         msr     cpacr_el1, x0                   // Enable FP/ASIMD
>         mov     x0, #1 << 12                    // Reset mdscr_el1 and disable
> --
> 2.17.2 (Apple Git-113)
>

Not sure why I can't reproduce on my HPE Apollo machine, so a couple
of questions:
1. How many CPUs do you enable in the kdump kernel - do you pass
'nr_cpus=1' to the kdump kernel to limit the maximum number of cores
to 1 in the kdump kernel?
2. Which firmware version do you use on your board?

Thanks,
Bhupesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
