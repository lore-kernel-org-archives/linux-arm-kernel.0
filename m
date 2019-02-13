Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4689BC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:51:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188CB222BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h4ZqhAYm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Al4jtBgl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Lk0Cf7eE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188CB222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3pYMYC+XaVlXOviEcH/bpeDBCAKrvZwVGiOTtN1kKMU=; b=h4ZqhAYm/nmybGvuzufUOXlUY
	H3fqkPIOtoMX92HNaETPXlhqo4tpLdSq1O+7ZvklVtpLEhqItMBCzuKTeofWIJOpvm0cKC27Ksihg
	tIhfoxvo8o8f54uIEibRuga4dUPGTL1dNJ78yytu7KWVTU00mklNLBOTHPwKBnmdmg/5Z92wxmA/l
	7kja8ZVihyk9NP2/ISEly9M8i7dPgrIs20D1n+FES2TQ2P3LhJmbhSMh7dXq53RlHQrVE16XnbJEu
	nP2/cXU3PHKyOJcy8yd1TNpm1wAigPqrMZTzRXNayjF8pmqBwLasQ6WdKt+EQSRXpCDXj/ziCrpjv
	7HAzSGQ7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrCi-0008BK-HG; Wed, 13 Feb 2019 09:51:44 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrCe-0008AU-TI
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:51:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 670C3608CB; Wed, 13 Feb 2019 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550051499;
 bh=Vs+50u4QSysEwvPfccTmoCqeFX05ffDTaj3MJz0B670=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=Al4jtBgl5La/iug7F1/r93K6MwbhWPJhZ2Sr7FVWgmMdda/qkPYGyIUsj0tZNA76W
 Y1rzeD+o9waRqCOlCIR8Owz6rLFvLfaSIsGa8i+KQ6SA+Wt+BiKH6llixH8pgv00ar
 pOReyBZY7E+MB4Bbl3stT3nwQZaMCdyDnQ4xmkRw=
Received: from [10.79.128.39]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 9CDC26087F;
 Wed, 13 Feb 2019 09:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1550051498;
 bh=Vs+50u4QSysEwvPfccTmoCqeFX05ffDTaj3MJz0B670=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=Lk0Cf7eE02GVh2/hv2jM4yg7+BAET8jRgyBDoHlgNTzh/153Uc7pmhY5uRJ0Q9mvu
 FKuFpUYBecuDyepAqDygn+goftI6OKmxRfjqcqMl07dJlyxem1PeGoZpbFMlTC2IHx
 KRvs0sqn9+Bw679Hz1JK4nqAFFpOXRbgP0J6AGGE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CDC26087F
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/rwsem.c:65
To: Pintu Agarwal <pintu.ping@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rt-users@vger.kernel.org,
 linux-mm@kvack.org, Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
 "Xenomai@xenomai.org" <xenomai@xenomai.org>
References: <CAOuPNLgaDJm27nECxq1jtny=+ixt=GPf2C7zyDsVgbsLvtDarA@mail.gmail.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <6183c865-2e90-5fb9-9e10-1339ae491b71@codeaurora.org>
Date: Wed, 13 Feb 2019 15:21:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAOuPNLgaDJm27nECxq1jtny=+ixt=GPf2C7zyDsVgbsLvtDarA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_015140_994112_2580A8B0 
X-CRM114-Status: GOOD (  16.34  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Pintu,

On 2/13/2019 2:04 PM, Pintu Agarwal wrote:
> 
> This is the complete logs at the time of crash:
> 
> [   21.681020] VFS: Mounted root (ext4 filesystem) readonly on device 8:6.
> [   21.690441] devtmpfs: mounted
> [   21.702517] Freeing unused kernel memory: 6528K
> [   21.766665] BUG: sleeping function called from invalid context at
> kernel/locking/rwsem.c:65
> [   21.775108] in_atomic(): 0, irqs_disabled(): 128, pid: 1, name: init
> [   21.781532] ------------[ cut here ]------------
> [   21.786209] kernel BUG at kernel/sched/core.c:8490!
> [   21.791157] ------------[ cut here ]------------
> [   21.795831] kernel BUG at kernel/sched/core.c:8490!
> [   21.800763] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [   21.806319] Modules linked in:
> [   21.809474] CPU: 0 PID: 1 Comm: init Not tainted 4.9.103+ #115
> [   21.815375] Hardware name: Qualcomm Technologies, Inc. MSM XXXX
> [   21.822584] task: ffffffe330440080 task.stack: ffffffe330448000
> [   21.828584] PC is at ___might_sleep+0x140/0x188
> [   21.833175] LR is at ___might_sleep+0x128/0x188
> [   21.837759] pc : [<ffffff88b8ce65a8>] lr : [<ffffff88b8ce6590>]
> pstate: 604001c5

<snip...>

> 0000000000000000 ffffffe33044b8d0
> [   22.135279] bac0: 0000000000000462 0000000000000006
> [   22.140224] [<ffffff88b8ce65a8>] ___might_sleep+0x140/0x188
> [   22.145862] [<ffffff88b8ce6648>] __might_sleep+0x58/0x90
> [   22.151249] [<ffffff88b9d43f84>] down_write_killable+0x2c/0x80
> [   22.157155] [<ffffff88b8e53cd8>] setup_arg_pages+0xb8/0x208
> [   22.162792] [<ffffff88b8eb7534>] load_elf_binary+0x434/0x1298
> [   22.168600] [<ffffff88b8e55674>] search_binary_handler+0xac/0x1f0
> [   22.174763] [<ffffff88b8e560ec>] do_execveat_common.isra.15+0x504/0x6c8
> [   22.181452] [<ffffff88b8e562f4>] do_execve+0x44/0x58
> [   22.186481] [<ffffff88b8c84030>] run_init_process+0x38/0x48
> [   22.192122] [<ffffff88b9d3db1c>] kernel_init+0x8c/0x108
> [   22.197411] [<ffffff88b8c83f00>] ret_from_fork+0x10/0x50
> [   22.202790] Code: b9453800 0b000020 6b00027f 540000c1 (d4210000)
> [   22.208965] ---[ end trace d775a851176a61ec ]---
> [   22.220051] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> 

This might be the work of CONFIG_PANIC_ON_SCHED_BUG which is extra debug 
option enabled in *sdm845_defconfig*. You can disable it or better
I would suggest to use *sdm845-perf_defconfig* instead of
sdm845_defconfig since there are a lot of debug options enabled
in the latter which may be not compatible when IPIPE patches
are applied.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
