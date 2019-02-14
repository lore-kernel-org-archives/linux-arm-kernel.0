Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B09DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:32:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046142075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W7tUEoTN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="k36S/amq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046142075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pk5CZ7Vt+FEO1bt2m736k13SA4huUxDWEb26qZ6KLRA=; b=W7tUEoTN7oziVD
	8toYYvkHxEKrnzWwKUw+1H1/PiZEtVamem/nrHnfEXdtxN946PHAvkJANSE9fJuipSspVIGnFMSZR
	lK2DxSkYVzLAV9tmwSqnM3owAump7Mc03+UHJvjIr+AZQwH1VRLCJGMdVjQLRqBkz9aScIENTwKgX
	S708iVFjINM7QMxmt0fn6qI4mXyGY5U3U5hG5B0gspw5aUAT8FeAYCDcrBQfaTbmkeEioM3L+sGZf
	kTjGEQlPtR5mLf3z2wYAD+/UofphfjYcbJI3GDVORwToA/5TneBp6URMJBrUvauGapx7HW5iVIZ8U
	+On6nuSOl2uJIlJAHMBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu7l5-0005bd-WA; Thu, 14 Feb 2019 03:32:20 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu7l2-0005bD-14
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 03:32:17 +0000
Received: by mail-qt1-x844.google.com with SMTP id y4so5331929qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 19:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=to:from:subject:cc:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=Cy4rhueNLwbwxi0b+zjjnk3B2JIvVZxezir+DqM28cY=;
 b=k36S/amqhnNTt6kIs4HWGvdRzjulPf4EbooRY498zNRuhcZIk9ZCMxV2hPUOoKuuI5
 2SR32OLq8oJFBqlo11ZsVpgA+p0w4KW8hZAYR+IQYuC53WQp8mZfSxy/DBAa3m9ki3w/
 EMzEFKvGhlQAbHoMK92dDYE/+wpS2ux+CZ3DbVb7jYUUcGFyBVN9tCv/+etJn39guNIj
 siyjO8tFRgsABmh+5vKXAWT94VDIBsLB/HPimLl/TdPPKioS2NZIFVOyryrsw4wM8Wtt
 4y1iqt45aE4FL6y9IdMwvnbf7yxsYD3PIlud5IfkVMRyKH+nW+nihAoRqwMzurVoEmgl
 sU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=Cy4rhueNLwbwxi0b+zjjnk3B2JIvVZxezir+DqM28cY=;
 b=LfDQ/LCTbXSXYF2gk/ZyXInO/G8jaa8bSE5mvK04ShZRDRrk6kbsldjS4tb7JwELfu
 zNt14NTR7CDKMbxGz9aQZLo3x9QKCGjtHLeiFJf+t+x0DH7DLqhwjSX30atxpFARtL6D
 FCrgZKX6rzEfS9s1ylLNK1f/YGv+8yeOHqGSgjncOur1N2bC2hlxYBtcSMcruu4v3OrK
 lPyXLh0kCUUIucOtqQUUzrVAxiMZ53ot/qPkm1nKgrMFXbFgkGOEPr81hRoOyH4xUBZ7
 wBC9oLam7Yqlk6RqZs4sz8kGKthnu8hml0A+wATefwSHdOR5kpDoXOucOMYsrR+AWJPX
 4Ebw==
X-Gm-Message-State: AHQUAuaazZjb7VssoCI1i2QDG1dnrVIpdNQ4ANGXQtmjV7owhpGdLrdY
 eV++diaxqZE6QE2LxHx+KGtLTwbo8QE=
X-Google-Smtp-Source: AHgI3IZ+g6HSR9FghWd0CiMxLTZ007iihw4l4n/FMKGKh9tv+p0AThytJl5iIAd8JSf1O9LG2G6sAQ==
X-Received: by 2002:a0c:b311:: with SMTP id s17mr1204022qve.69.1550115134360; 
 Wed, 13 Feb 2019 19:32:14 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id o42sm621844qtc.90.2019.02.13.19.32.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 19:32:13 -0800 (PST)
To: Andrey Konovalov <andreyknvl@google.com>
From: Qian Cai <cai@lca.pw>
Subject: livelock with KASAN_SW_TAGS
Message-ID: <7ec14ad5-8d64-b842-a819-9d57cc8495e2@lca.pw>
Date: Wed, 13 Feb 2019 22:32:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_193216_120230_02DDA9ED 
X-CRM114-Status: UNSURE (   8.96  )
X-CRM114-Notice: Please train this message.
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
Cc: aryabinin@virtuozzo.com, Will Deacon <will.deacon@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 kasan-dev <kasan-dev@googlegroups.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Running LTP msgstress03 [1] triggers endless soft lockups below after a few
minutes on a ThunderX2 server. It works fine with KASAN_GENERIC and finish the
test in roughly 11 minutes.

[1]
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c

# ./scripts/faddr2line vmlinux _raw_spin_unlock_irqrestore+0x44/0xac
_raw_spin_unlock_irqrestore+0x44/0xac:
arch_local_irq_restore at arch/arm64/include/asm/irqflags.h:88
(inlined by) __raw_spin_unlock_irqrestore at include/linux/spinlock_api_smp.h:160
(inlined by) _raw_spin_unlock_irqrestore at kernel/locking/spinlock.c:184

This code:

	asm volatile(
		"msr	daif, %0
	:
	: "r" (flags)
	: "memory");

[  545.622261] watchdog: BUG: soft lockup - CPU#12 stuck for 23s!
[kworker/12:1:1439]
[  545.629847] Modules linked in: thunderx2_pmu ip_tables xfs libcrc32c sd_mod
ahci libahci mlx5_core libata dm_mirror dm_region_hash dm_log dm_mod efivarfs
[  545.643692] CPU: 12 PID: 1439 Comm: kworker/12:1 Tainted: G        W
5.0.0-rc6+ #44
[  545.652082] Hardware name: HPE Apollo 70             /C01_APACHE_MB         ,
BIOS L50_5.13_1.0.6 07/10/2018
[  545.661947] Workqueue: events free_obj_work
[  545.666173] pstate: 60400009 (nZCv daif +PAN -UAO)
[  545.670981] pc : _raw_spin_unlock_irqrestore+0x44/0xac
[  545.676166] lr : _raw_spin_unlock_irqrestore+0x38/0xac
[  545.681389] sp : 30ff80098de3fa70
[  545.684724] x29: 30ff80098de3fa90 x28: 00000000000044c0
[  545.690048] x27: 0000000000000001 x26: 8aff808ba9f844d0
[  545.695380] x25: 0000000000000001 x24: 0000000000000001
[  545.700705] x23: 0000000000000000 x22: 62ff808b7d00df00
[  545.706038] x21: 62ff808b7d00df00 x20: 0000000000000000
[  545.711366] x19: ffff1000105d6ac0 x18: ffff1000148a5538
[  545.716720] x17: 000000000000001b x16: 00000000000000ff
[  545.722040] x15: ffff1000148a5000 x14: 000000000000004c
[  545.727358] x13: 0000000000000001 x12: efff100000000000
[  545.732678] x11: 0000000000000002 x10: 00000000000000ff
[  545.738034] x9 : 00000000ffffffff x8 : 4cff800832347840
[  545.743354] x7 : bbbbbbbbbbbbbbbb x6 : 0000000000000008
[  545.748711] x5 : 000000000000005a x4 : 0000000000000000
[  545.754041] x3 : 30ff80098de3fa04 x2 : 0000000000000003
[  545.759422] x1 : 62ff808b7d00df18 x0 : 4cff800832347850
[  545.764761] Call trace:
[  545.767225]  _raw_spin_unlock_irqrestore+0x44/0xac
[  545.772027]  free_debug_processing+0x308/0x410
[  545.776489]  kmem_cache_free+0x604/0x9f0
[  545.780442]  free_obj_work+0x92c/0xa44
[  545.784241]  process_one_work+0x894/0x1280
[  545.788349]  worker_thread+0x684/0xa1c
[  545.792122]  kthread+0x2cc/0x2e8
[  545.795367]  ret_from_fork+0x10/0x18

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
