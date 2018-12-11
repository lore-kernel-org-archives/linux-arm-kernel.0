Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423D0C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:12:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1059D20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lviyodq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1059D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TOpPMcz2KIjYFTYgklaobO2Qkn75543wmC6vYR/w+3g=; b=Lviyodq/LQ8fzt
	vPcI9LIwlqpaAufdLI2VPc97ZaSBemPplGF9/mTOOiYdALV8kFoappWQ1CPq/7g1te0nQ7IbIixru
	nij/2h/r0YCiRXtgBcpyFdRuqEupK6c8yaLO5nDcrCqyKAT1hXMHfxdUDh07oOgtxT0R8QkUs1zrl
	gWaHrlN3KWY1KwiTFAoBQ9MydqO2Tdr2wa93k4WoXR5PjOGUyQ8s4QIZZ00K1i3PIrfn7SMYlZUiq
	E8fgkLMBk2L3A6Atgfwgl6u6NOq4WSBOkn2HrNj/8MTJB0rZxudUpm0ZpWF4eb8QlOWkRAVfNsiJs
	0PawMAr2S7UK6aygNVUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWnSQ-0008O7-8I; Tue, 11 Dec 2018 19:12:38 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWnSM-0008MT-Me
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 19:12:36 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 78B6B8027;
 Tue, 11 Dec 2018 19:12:26 +0000 (UTC)
Date: Tue, 11 Dec 2018 11:12:20 -0800
From: Tony Lindgren <tony@atomide.com>
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 Theodore Ts'o <tytso@mit.edu>
Subject: Regression in next-20181211 with fsverity changes
Message-ID: <20181211191220.GW6707@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_111234_771465_C4A0FBD3 
X-CRM114-Status: UNSURE (   5.31  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-omap@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Looks like commit 4de97efb578a ("fsverity: Move verity status check
to fsverity_file_open") causes a boot regression for me with root
on ext4 SDIO card, see below.

Any ideas what goes wrong?

Regards,

Tony

8< ----------------------
Starting init: /bin/sh exists but couldn't execute it (error -95)
Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.20.0-rc6-next-20181211 #1080
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c0112a18>] (unwind_backtrace) from [<c010d090>] (show_stack+0x10/0x14)
[<c010d090>] (show_stack) from [<c08eb854>] (dump_stack+0xb0/0xe8)
[<c08eb854>] (dump_stack) from [<c0110da4>] (handle_IPI+0x318/0x380)
[<c0110da4>] (handle_IPI) from [<c0534930>] (gic_handle_irq+0x94/0xa8)
[<c0534930>] (gic_handle_irq) from [<c01019f0>] (__irq_svc+0x70/0x98)
Exception stack(0xee911ef8 to 0xee911f40)
1ee0:                                                       00000001 00000001
1f00: 00000000 ee90a180 00000000 c0e13fc4 00000000 ef6afbb8 c0ec8830 de03d29f
1f20: 00000000 00000000 00000000 ee911f48 c01a4120 c06f8fb4 20000153 ffffffff
[<c01019f0>] (__irq_svc) from [<c06f8fb4>] (cpuidle_enter_state+0x270/0x46c)
[<c06f8fb4>] (cpuidle_enter_state) from [<c06fb0a4>] (cpuidle_enter_state_coupled+0x148/0x3e0)
[<c06fb0a4>] (cpuidle_enter_state_coupled) from [<c0173398>] (do_idle+0x234/0x2b8)
[<c0173398>] (do_idle) from [<c01737b4>] (cpu_startup_entry+0x18/0x1c)
[<c01737b4>] (cpu_startup_entry) from [<8010274c>] (0x8010274c)
---[ end Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance. ]---

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
