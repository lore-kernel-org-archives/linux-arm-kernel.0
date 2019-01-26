Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9208FC282C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:32:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CD4218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QvkSufU5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="kO+IeRtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CD4218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fnTq1s+lKDGsFM/oBfiTlAlWicP8J+TBQUab/cd6nXU=; b=QvkSufU5uILSKO
	1QKLhZ4rDIiMt/IDU4lGRoSevxihu+5VB/4xTD78tTNVuIXrpZSyzxeIqHetEan2/JNM0FPDPfnh4
	Gg5YzPUe8pukzRP60tQOJV782B6qdpc1pvrmUJ5KxVPa5I8ldi4leanbnHxzbA8LkIIcH1vrkdIWu
	bvn5EwqieBn5P6C6aL1PFmx+9F7xlWQ6KjBX5ppTG4wr/80BO8cO77mAo8pJTT3G+8K1adGwfUaOb
	n6N6L3d4qa7j0eMZVk1ukCKKebwlLv5O2/PYM+cST+LAwVlJL9SkRM2Zp2CQcLiZ5ZDsEX8DWVwy8
	D30rRBB7Gt38gEbWuqaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnTgV-0006X9-KE; Sat, 26 Jan 2019 19:32:07 +0000
Received: from mo6-p02-ob.smtp.rzone.de ([2a01:238:20a:202:5302::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnTgQ-0006WK-MH
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 19:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548531120;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=Uwkip8Wbya1rcLsLOp4PFx2RZVRL78FTKAYH2T5nrwY=;
 b=kO+IeRtI3Yp7TOvYMCasC72fSYFITcSU46Mpc8NIHGppWoVQ++mFNAwX07WjMR/J8Y
 xI6mfmM597e08OsvHA6ZEZ/eF0YrPMaGTPjW5h+XuoH8r4Hp8QnzSIFcLYwkjlzb/J+N
 ycXEsQ2/Gl4k0LCo1nByctSxwGvptA862kAOlsvVgIflJMs9/anBF7fhmiaFMfRZEptu
 fs2hTKsCPqGdkQkpKZ0d6IiBHZY3p2LW3HUqDVTxay8EAJPZJe1ZBSgeNMrXCTXc3LJy
 UXhBEQeV7z0H2IzrdWJjP7sdalDw7AHNQOkM//9YZIbiv9JiAl8C6qlkhCDdWR1fieSi
 4nGg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/zswDuotw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
 with ESMTPSA id 608499v0QJVqspE
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH
 bits, eq. 15360 bits RSA)) (Client did not present a certificate);
 Sat, 26 Jan 2019 20:31:52 +0100 (CET)
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/3] bus: ti-sysc: Fix timer handling with drop
 pm_runtime_irq_safe()
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190126194145.2b3484da@aktux>
Date: Sat, 26 Jan 2019 20:31:51 +0100
Message-Id: <2369C6FA-32A2-4F29-9DFB-60D576AB867F@goldelico.com>
References: <20190122175717.13428-1-tony@atomide.com>
 <20190122175717.13428-3-tony@atomide.com> <20190126194145.2b3484da@aktux>
To: Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_113202_878459_A2E1F568 
X-CRM114-Status: GOOD (  11.75  )
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
Cc: Ladislav Michl <ladis@linux-mips.org>, Keerthy <j-keerthy@ti.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Andreas Kemnade <andreas@kemnade.info>, Thomas Gleixner <tglx@linutronix.de>,
 linux-omap <linux-omap@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> Am 26.01.2019 um 19:41 schrieb Andreas Kemnade <andreas@kemnade.info>:
> 
> On Tue, 22 Jan 2019 09:57:16 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
>> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
>> them with ti-sysc") started producing a warning for pwm-omap-dmtimer:
>> 
>> WARNING: CPU: 0 PID: 77 at drivers/bus/omap_l3_noc.c:147
>> l3_interrupt_handler+0x2f8/0x388
>> 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle):
>> Data Access in Supervisor mode during Functional access
>> ...
>> __pm_runtime_idle
>> omap_dm_timer_disable
>> pwm_omap_dmtimer_start
>> pwm_omap_dmtimer_enable
>> pwm_apply_state
>> pwm_vibrator_start
>> pwm_vibrator_play_work
>> 
>> This is because the timer that pwm-omap-dmtimer is using is now being
>> probed with ti-sysc interconnect target module instead of omap_device
>> and the ti-sysc quirk for SYSC_QUIRK_LEGACY_IDLE is not fully
>> compatible with what omap_device has been doing.
>> 
>> We could fix this by reverting the timer changes and have the timer
>> probe again with omap_device. Or we could add more quirk handling to
>> ti-sysc driver. But as these options don't work nicely as longer term
>> solutions, let's just make timers probe with ti-sysc without any
>> quirks.
>> 
>> To do this, all we need to do is remove quirks for timers for ti-sysc,
>> and drop the bogus pm_runtime_irq_safe() flag for timer-ti-dm.
>> 
>> We should not use pm_runtime_irq_safe() anyways for drivers as it will
>> take a permanent use count on the parent device blocking the parent
>> devices from idling and has been forcing ti-sysc driver to use a
>> quirk flag.
>> 
>> Note that we will move the timer data to DEBUG section later on in
>> clean-up patches.
>> 
> together with 1/3 it fixes things on pyra.
> 
> Tested-By: Andreas Kemnade <andreas@kemnade.info>

H. Nikolaus Schaller <hns@goldelico.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
