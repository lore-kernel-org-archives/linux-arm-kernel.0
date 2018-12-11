Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5727C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:49:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622562081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lyYDgmBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622562081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kLPjXgcaSpUU03nzHb/nDg7YRhkuWliepjUWLrewcGc=; b=lyYDgmBuCMVxsy
	gNN0ODhv+PR66PFBlISoDguTJupBsEQxjjzo2HYK5F0vmzlX2UNbbInCa/iQnWfopHSLG96YPd0if
	YPGTarqeSYY0flxbOUBAzHk9541XBpCGvN9RAW7NrrH15HWmHsSMf3D1e8PbICx8ZeurstWYqOElN
	b0y9/ImG4pLTPuT0WCamXut82jv7h+XwS2OoADY70L3EsfbBx5YPKX++ou5cB0OdyY5gQ/j9LYBVN
	mYqZUoCZZLifEbruE6CEVfFDUTH8/CTNt30YW2/JgSHanxHUEGz17W2dQ8UOSyEvgtcXQKd4mcJI2
	Xw2LSXNTFplW7gVw9qZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWfbd-0004p5-Hl; Tue, 11 Dec 2018 10:49:37 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWfbP-0004ne-QF
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:49:35 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 2251E13F86E;
 Tue, 11 Dec 2018 11:48:12 +0100 (CET)
Subject: Re: ufs_qcom_dump_dbg_regs makes the kernel panic
To: Robin Murphy <robin.murphy@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>, 
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
References: <78a1b262-d366-a3d3-12ce-1a813444b6a7@free.fr>
 <0f4cac25-3936-adc8-d8b5-c131dea4b93c@arm.com>
 <338058cc-b040-3c9a-ec31-d15157535dcc@free.fr>
 <2aaa187e-c612-097c-cbb1-fdb46753eb8b@free.fr>
 <d63ae914-f71e-4382-53e4-b024abe84dc0@arm.com>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <abb48910-00a0-3e35-be2a-446b8cef6d9b@free.fr>
Date: Tue, 11 Dec 2018 11:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d63ae914-f71e-4382-53e4-b024abe84dc0@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_024924_151723_96F8C73B 
X-CRM114-Status: GOOD (  12.44  )
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10/12/2018 16:54, Robin Murphy wrote:

> On 10/12/2018 14:57, Marc Gonzalez wrote:
> [...]
>> [   14.135960] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk disabled
>> [   14.140789] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: bus_aggr_clk disabled
>> [   14.148604] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: iface_clk disabled
>> [   14.156687] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_unipro disabled
>> [   14.164398] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_ice disabled
>> [   14.172866] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: ref_clk disabled
>> [   14.180878] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
>> [   14.188272] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
>> [   14.196958] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled
>> /*** System hangs here ***/
> 
> Looks like it's time to rule out the obvious and crank up the 
> clock/power domain debugging to see if turning off all this stuff 
> inadvertently also turns off something else important (and/or the 
> primary CPU gets wedged trying to read some now-unclocked register).

For the record, I'm seeing different types of failures: the synchronous abort
(which I have hopefully fixed), the hard lockup, and now this MMU fault(?)

[    4.282053] UNIPRO_TEST_BUS 000003e0: 00000000 00000000 00000000 00000000
[    4.288833] UNIPRO_TEST_BUS 000003f0: 00000000 00000000 00000000 00000000
[    4.296711] ufshcd-qcom 1da4000.ufshc: UFS Host state=0
[    4.302335] ufshcd-qcom 1da4000.ufshc: lrb in use=0x0, outstanding reqs=0x0 tasks=0x0
[    4.307435] ufshcd-qcom 1da4000.ufshc: saved_err=0x0, saved_uic_err=0x0
[    4.315388] ufshcd-qcom 1da4000.ufshc: Device power mode=0, UIC link state=0
[    4.321825] ufshcd-qcom 1da4000.ufshc: PM in progress=0, sys. suspended=0
[    4.329107] ufshcd-qcom 1da4000.ufshc: Auto BKOPS=0, Host self-block=0
[    4.335781] ufshcd-qcom 1da4000.ufshc: Clk gate=1
[    4.342170] ufshcd-qcom 1da4000.ufshc: error handling flags=0x0, req. abort count=0
[    4.347004] ufshcd-qcom 1da4000.ufshc: Host capabilities=0x1587001f, caps=0xf
[    4.354464] ufshcd-qcom 1da4000.ufshc: quirks=0x0, dev. quirks=0x0
[    4.363091] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk disabled
[    4.367870] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: bus_aggr_clk disabled
[    4.375771] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: iface_clk disabled
[    4.383847] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_unipro disabled
[    4.391561] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_ice disabled
[    4.400016] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: ref_clk disabled
[    4.408039] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
[    4.415444] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
[    4.424115] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled
[    4.432621] ufshcd-qcom 1da4000.ufshc: Initialization failed
[    4.485263] ufshcd-qcom 1da4000.ufshc: ufshcd_pltfrm_init() failed -5
[    4.486307] ufshcd-qcom 1da4000.ufshc: Dropping the link to regulator.5
[    4.490990] ufshcd-qcom 1da4000.ufshc: Dropping the link to regulator.40
[    4.497413] ufshcd-qcom 1da4000.ufshc: Dropping the link to regulator.34
[    4.504327] ufshcd-qcom: probe of 1da4000.ufshc failed with error -5
[    4.511176] Unable to handle kernel paging request at virtual address 0000000a00000000
[    4.517293] Mem abort info:
[    4.524887]   ESR = 0x96000004
[    4.527599]   Exception class = DABT (current EL), IL = 32 bits
[    4.530775]   SET = 0, FnV = 0
[    4.536525]   EA = 0, S1PTW = 0
[    4.539651] Data abort info:
[    4.542689]   ISV = 0, ISS = 0x00000004
[    4.545831]   CM = 0, WnR = 0
[    4.549381] [0000000a00000000] user address but active_mm is swapper
[    4.552584] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    4.558981] Modules linked in:
[    4.564237] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G S                4.20.0-rc4 #12
[    4.567444] Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
[    4.575334] pstate: 20000005 (nzCv daif -PAN -UAO)
[    4.582035] pc : kmem_cache_alloc+0xbc/0x1f0
[    4.586732] lr : kmem_cache_alloc+0x30/0x1f0
[    4.591153] sp : ffff00000807bce0
[    4.595384] x29: ffff00000807bce0 x28: 0000000000000007 
[    4.598644] x27: ffff0000089db068 x26: ffff000008961db8 
[    4.604018] x25: ffff000008970634 x24: ffff00000924e000 
[    4.609314] x23: 000000000003be81 x22: ffff00000835166c 
[    4.614610] x21: 00000000006000c0 x20: ffff8000f9c03c80 
[    4.619904] x19: 0000000a00000000 x18: ffffffffffffffff 
[    4.625199] x17: 0000000000000000 x16: 0000000000000000 
[    4.630495] x15: ffff0000091a9648 x14: ffff8000f8e5e91c 
[    4.635791] x13: ffff8000f8e5e16d x12: 0000000000000010 
[    4.641086] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f 
[    4.646382] x9 : 625e7377645e6372 x8 : 7f7f7f7f7f7f7f7f 
[    4.651678] x7 : ffff000009289000 x6 : 0000000000000000 
[    4.656973] x5 : ffff8000f96b8000 x4 : 0000000080808081 
[    4.662269] x3 : 000000000003be81 x2 : ffff7e0003db5740 
[    4.667565] x1 : 0000000000000000 x0 : 0000000000000001 
[    4.672867] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[    4.678190] Call trace:
[    4.684774]  kmem_cache_alloc+0xbc/0x1f0
[    4.687013]  register_blkdev+0x6c/0x1b0
[    4.691171]  init_sd+0x3c/0x17c
[    4.694696]  do_one_initcall+0x5c/0x180
[    4.697847]  kernel_init_freeable+0x198/0x244
[    4.701682]  kernel_init+0x10/0x110
[    4.706150]  ret_from_fork+0x10/0x20
[    4.709459] Code: f9001fb8 b9402281 b94010a0 11000400 (f8616a78) 
[    4.713398] ---[ end trace 5569ef4940f46939 ]---
[    4.719345] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    4.724042] SMP: stopping secondary CPUs
[    4.731351] Kernel Offset: disabled
[    4.735492] CPU features: 0x2,21802008
[    4.738711] Memory Limit: none
[    4.742521] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---


Rebooting, I get yet another failure:

[    4.295129] UNIPRO_TEST_BUS 000003e0: 00000000 00000000 00000000 00000000
[    4.301900] UNIPRO_TEST_BUS 000003f0: 00000000 00000000 00000000 00000000
[    4.309776] ufshcd-qcom 1da4000.ufshc: UFS Host state=0
[    4.315409] ufshcd-qcom 1da4000.ufshc: lrb in use=0x0, outstanding reqs=0x0 tasks=0x0
[    4.320501] ufshcd-qcom 1da4000.ufshc: saved_err=0x0, saved_uic_err=0x0
[    4.328454] ufshcd-qcom 1da4000.ufshc: Device power mode=0, UIC link state=0
[    4.334890] ufshcd-qcom 1da4000.ufshc: PM in progress=0, sys. suspended=0
[    4.342179] ufshcd-qcom 1da4000.ufshc: Auto BKOPS=0, Host self-block=0
[    4.348853] ufshcd-qcom 1da4000.ufshc: Clk gate=1
[    4.355242] ufshcd-qcom 1da4000.ufshc: error handling flags=0x0, req. abort count=0
[    4.360076] ufshcd-qcom 1da4000.ufshc: Host capabilities=0x1587001f, caps=0xf
[    4.367529] ufshcd-qcom 1da4000.ufshc: quirks=0x0, dev. quirks=0x0
[    4.376153] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk disabled
[    4.380934] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: bus_aggr_clk disabled
[    4.388836] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: iface_clk disabled
[    4.396918] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_unipro disabled
[    4.404633] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: core_clk_ice disabled
[    4.413079] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: ref_clk disabled
[    4.421113] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: tx_lane0_sync_clk disabled
[    4.428506] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane0_sync_clk disabled
[    4.437187] ufshcd-qcom 1da4000.ufshc: __ufshcd_setup_clocks: clk: rx_lane1_sync_clk disabled
[    4.445686] ufshcd-qcom 1da4000.ufshc: Initialization failed
[    4.486278] ufshcd-qcom 1da4000.ufshc: ufshcd_pltfrm_init() failed -5
[    4.487401] ufshcd-qcom 1da4000.ufshc: Dropping the link to regulator.5
[    4.491976] ufshcd-qcom 1da4000.ufshc: Dropping the link to regulator.40
[    4.498412] ufshcd-qcom 1da4000.ufshc: Dropping the link to regulator.34
[    4.505334] ufshcd-qcom: probe of 1da4000.ufshc failed with error -5
[    4.513185] spmi spmi-0: PMIC arbiter version v3 (0x30000000)
[    4.524036] Unable to handle kernel paging request at virtual address 0039b70e092828aa
[    4.524258] Mem abort info:
[    4.531662]   ESR = 0x96000004
[    4.534331]   Exception class = DABT (current EL), IL = 32 bits
[    4.537507]   SET = 0, FnV = 0
[    4.543268]   EA = 0, S1PTW = 0
[    4.546396] Data abort info:
[    4.549432]   ISV = 0, ISS = 0x00000004
[    4.552574]   CM = 0, WnR = 0
[    4.556124] [0039b70e092828aa] address between user and kernel address ranges
[    4.559346] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    4.566420] Modules linked in:
[    4.571757] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G S                4.20.0-rc4 #12
[    4.574971] Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
[    4.582859] pstate: 60000005 (nZCv daif -PAN -UAO)
[    4.589561] pc : kmem_cache_alloc_node+0x13c/0x210
[    4.594259] lr : kmem_cache_alloc_node+0x38/0x210
[    4.599030] sp : ffff00000807b290
[    4.603777] x29: ffff00000807b290 x28: 0000000000000000 
[    4.607122] x27: 0000000000000022 x26: 0000000000000000 
[    4.612505] x25: 00000000ffffffff x24: 0000000000002942 
[    4.617801] x23: ffff000008108824 x22: 00000000ffffffff 
[    4.623097] x21: 00000000006080c0 x20: ffff8000f9c03980 
[    4.628391] x19: 0039b70e092828aa x18: ffffffffffffffff 
[    4.633686] x17: 0000000000000000 x16: 0000000000000000 
[    4.638982] x15: ffff0000091a9648 x14: ffff8000f6e35283 
[    4.644270] x13: ffff8000f6e35282 x12: 0000000000000038 
[    4.649565] x11: 000000000000000b x10: 0101010101010101 
[    4.654861] x9 : ffffffffffffffff x8 : 7f7f7f7f7f7f7f7f 
[    4.660157] x7 : fefefeff646c606d x6 : 0000000000000001 
[    4.665452] x5 : ffff8000f96b8000 x4 : 0000000000000000 
[    4.670748] x3 : 0000000000002942 x2 : 00008000f5187000 
[    4.676044] x1 : 0000000000000000 x0 : 0000000000000000 
[    4.681343] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[    4.686677] Call trace:
[    4.693254]  kmem_cache_alloc_node+0x13c/0x210
[    4.695483]  alloc_desc+0x44/0x1b0
[    4.699977]  __irq_alloc_descs+0x1fc/0x2b0
[    4.703367]  irq_domain_alloc_descs+0x50/0xe0
[    4.707451]  irq_create_mapping+0x94/0x130
[    4.711865]  irq_create_fwspec_mapping+0x190/0x310
[    4.715876]  irq_create_of_mapping+0x80/0xa0
[    4.720662]  of_irq_get+0x74/0xe0
[    4.725041]  of_irq_to_resource+0x38/0x100
[    4.728274]  of_irq_to_resource_table+0x50/0x80
[    4.732291]  of_device_alloc+0x11c/0x1f0
[    4.736689]  of_platform_device_create_pdata+0x74/0x130
[    4.740882]  of_platform_bus_create+0x174/0x370
[    4.745812]  of_platform_populate+0x78/0xe0
[    4.750321]  devm_of_platform_populate+0x50/0xb0
[    4.754526]  pmic_spmi_probe+0x54/0xf0
[    4.759362]  spmi_drv_probe+0x48/0xc0
[    4.762919]  really_probe+0x1f0/0x2a0
[    4.766632]  driver_probe_device+0x58/0x100
[    4.770286]  __device_attach_driver+0x98/0xf0
[    4.774291]  bus_for_each_drv+0x64/0xd0
[    4.778785]  __device_attach+0xd8/0x130
[    4.782429]  device_initial_probe+0x10/0x20
[    4.786258]  bus_probe_device+0x90/0xa0
[    4.790424]  device_add+0x454/0x630
[    4.794230]  spmi_device_add+0x30/0x80
[    4.797712]  spmi_controller_add+0xd0/0x1d0
[    4.801535]  spmi_pmic_arb_probe+0x398/0x540
[    4.805629]  platform_drv_probe+0x50/0xa0
[    4.810130]  really_probe+0x1f0/0x2a0
[    4.814030]  driver_probe_device+0x58/0x100
[    4.817683]  __driver_attach+0xd4/0xe0
[    4.821669]  bus_for_each_dev+0x74/0xd0
[    4.825481]  driver_attach+0x20/0x30
[    4.829223]  bus_add_driver+0x1ac/0x220
[    4.833033]  driver_register+0x60/0x110
[    4.836601]  __platform_driver_register+0x40/0x50
[    4.840465]  spmi_pmic_arb_driver_init+0x18/0x20
[    4.845314]  do_one_initcall+0x5c/0x180
[    4.849991]  kernel_init_freeable+0x198/0x244
[    4.853537]  kernel_init+0x10/0x110
[    4.858036]  ret_from_fork+0x10/0x20
[    4.861350] Code: 17ffffc5 b9402281 d5384105 b94010a0 (f8616a79) 
[    4.865287] ---[ end trace 018ba04c46f3a5d7 ]---
[    4.871243] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    4.875921] SMP: stopping secondary CPUs
[    4.883238] Kernel Offset: disabled
[    4.887377] CPU features: 0x2,21802008
[    4.890588] Memory Limit: none
[    4.894398] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---



Looks like the UFS debug code might be smashing memory it doesn't own?
I'm kinda puzzled right now. I'll keep digging.
Are there debug options that might help figuring things out? UBSAN?

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
