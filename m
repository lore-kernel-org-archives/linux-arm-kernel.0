Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851B4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:38:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463FB20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K36QT08n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463FB20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5E+oVL6tbJ8qy8+wF8E8deEb5Y2UEfDg4MtEe2UMDqU=; b=K36QT08nMNQbiR
	XeuyccK5eSWm9aH0p9ZbTtIeazuDXNXc0U+oDQavfexHWuBeEDIafv7xG/dJ86WOzXJpr+fvL229q
	akT1Hg4EEz+8Mf8LZ7hL4wDzbY1g5pncapiUD9Styx6UhRHeW87Zh3DLthU1FN5AjlRLsBEIq5UwS
	y8uUNEO8s8Rx7N28Hko5M4d3CVzjUaSSBD+SbjzMNoXVfhE6Bikjhm4kW433CO70CzlhA7Vz0diLO
	dxxRF2R7tBWPEUX8uGzFZlRIdecEepw+wRJqg10K153EGCCX2uLcOTnryNWyZLZ5EwV68eteNp3Ae
	JXyfopCoo0gu3xcU+gpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKpX-0003vc-1n; Mon, 10 Dec 2018 12:38:35 +0000
Received: from smtp3-g21.free.fr ([212.27.42.3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKpL-0003lK-3o
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:38:26 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 3079113F899;
 Mon, 10 Dec 2018 13:37:53 +0100 (CET)
To: Jeffrey Hugo <jhugo@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: ufs_qcom_dump_dbg_regs makes the kernel panic
Message-ID: <78a1b262-d366-a3d3-12ce-1a813444b6a7@free.fr>
Date: Mon, 10 Dec 2018 13:37:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_043823_438294_BF984807 
X-CRM114-Status: GOOD (  11.38  )
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

Hello,

When the kernel fails to init the UFSHC, it calls ufshcd_print_host_regs()
to help with debugging, which calls the dbg_register_dump hook.

ufs_qcom_dump_dbg_regs makes the kernel panic:

[    3.715634] UFS_DBG_RD_REG_TXUC 000000a0: 00000000 00000000 00000000 00000000
[    3.722750] UFS_DBG_RD_REG_TXUC 000000b0: 00000001 00000000 00000000 00000004
[    3.729943] Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
[    3.737000] Modules linked in:
[    3.744371] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G S                4.20.0-rc4 #16
[    3.747413] Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
[    3.755295] pstate: 00000005 (nzcv daif -PAN -UAO)
[    3.761978] pc : __memcpy_fromio+0x68/0x80
[    3.766718] lr : ufshcd_dump_regs+0x50/0xb0
[    3.770767] sp : ffff00000807ba00
[    3.774830] x29: ffff00000807ba00 x28: 00000000fffffffb 
[    3.778344] x27: ffff0000089db068 x26: ffff8000f6e58000 
[    3.783728] x25: 000000000000000e x24: 0000000000000800 
[    3.789023] x23: ffff8000f6e587c8 x22: 0000000000000800 
[    3.794319] x21: ffff000008908368 x20: ffff8000f6e1ab80 
[    3.799615] x19: 000000000000006c x18: ffffffffffffffff 
[    3.804910] x17: 0000000000000000 x16: 0000000000000000 
[    3.810206] x15: ffff000009199648 x14: ffff000089244187 
[    3.815502] x13: ffff000009244195 x12: ffff0000091ab000 
[    3.820797] x11: 0000000005f5e0ff x10: ffff0000091998a0 
[    3.826093] x9 : 0000000000000000 x8 : ffff8000f6e1ac00 
[    3.831389] x7 : 0000000000000000 x6 : 0000000000000068 
[    3.836676] x5 : ffff8000f6e1abe8 x4 : 0000000000000000 
[    3.841971] x3 : ffff00000928c868 x2 : ffff8000f6e1abec 
[    3.847267] x1 : ffff00000928c868 x0 : ffff8000f6e1abe8 
[    3.852567] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[    3.857900] Call trace:
[    3.864473]  __memcpy_fromio+0x68/0x80
[    3.866683]  ufs_qcom_dump_dbg_regs+0x1c0/0x370
[    3.870522]  ufshcd_print_host_regs+0x168/0x190
[    3.874946]  ufshcd_init+0xd4c/0xde0
[    3.879459]  ufshcd_pltfrm_init+0x3c8/0x550
[    3.883264]  ufs_qcom_probe+0x24/0x60
[    3.887188]  platform_drv_probe+0x50/0xa0
[    3.890993]  really_probe+0x1f0/0x2a0
[    3.894983]  driver_probe_device+0x58/0x100
[    3.898628]  __driver_attach+0xd4/0xe0
[    3.902617]  bus_for_each_dev+0x74/0xd0
[    3.906436]  driver_attach+0x20/0x30
[    3.910169]  bus_add_driver+0x1ac/0x220
[    3.913992]  driver_register+0x60/0x110
[    3.917540]  __platform_driver_register+0x40/0x50
[    3.921413]  ufs_qcom_pltform_init+0x18/0x20
[    3.926248]  do_one_initcall+0x5c/0x180
[    3.930593]  kernel_init_freeable+0x198/0x244
[    3.934156]  kernel_init+0x10/0x110
[    3.938629]  ret_from_fork+0x10/0x20
[    3.941940] Code: f2400842 54000100 8b020002 d503201f (39400023) 
[    3.945875] ---[ end trace 2d10f654364744f5 ]---
[    3.951841] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    3.956528] SMP: stopping secondary CPUs
[    5.005502] SMP: failed to stop secondary CPUs 2,7
[    5.005648] Kernel Offset: disabled
[    5.009292] CPU features: 0x2,21802008
[    5.012676] Memory Limit: none
[    5.016485] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---


The problem appears to be on this line:

	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_RXUC);
	/* reg = 0x800 */
	print_fn(hba, reg, 27, "UFS_DBG_RD_REG_RXUC ", priv);

I'm not sure what's going on, because the driver is supposed to map 0x2500 bytes.
(reg = <0x1da4000 0x2500>;)

Commenting out the last 4 dumps of ufs_qcom_print_hw_debug_reg_all() makes
the panic disappear, but the kernel just hangs after printing UFS_DBG_RD_REG_TXUC

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
