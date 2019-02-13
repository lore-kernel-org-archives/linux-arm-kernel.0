Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8E3C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:46:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178EB222B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o3AyofOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178EB222B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m4eKhSbOezDfKr9QeB8vnV+/yQ1B1NcfSoq/Ea/fPt0=; b=o3AyofOR3k856o
	cZDJTaFhcEOT6tJesv/HDsxaj4mrMZR3q/MnVB6FpBSALfzMrBmssYuL4SkwGtekI9167hvtW5NrG
	jOL8aGQJiHZZI4YH1ZAdr4JcbdsxCe0y6e73V6351bTqBlNS/x+0rc6JFUXdsPL09FBdXKEGCPOaa
	1vi3FgPuRREfglxGZPnIVFJlRWsv/wB9ubtZBqvMwFTyjzORoLCAhw6nE4F4L9jro8uNDDzZFRDA8
	JSC638q4ZSMcWFLJpemPafXZZD6j3sQTXselOw63tl8FZuZewBfD0veJFpyWS5NP1SuM2GkNQb80B
	UDS2py6ViYWVsV7opj7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqBe-0000L4-Q2; Wed, 13 Feb 2019 08:46:34 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqBb-0000CQ-6r
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 08:46:33 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gtqBW-0003Ar-6X; Wed, 13 Feb 2019 09:46:26 +0100
Date: Wed, 13 Feb 2019 09:46:25 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] arm: kprobe: make patch_lock a raw_spinlock_t
Message-ID: <20190213084625.mlttbc45ur3gvkzr@linutronix.de>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207102749.15205-3-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_004631_490587_968DD7CB 
X-CRM114-Status: UNSURE (   7.85  )
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
Cc: Yang Shi <yang.shi@linaro.org>, tglx@linutronix.de,
 Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018-12-07 11:27:48 [+0100], To linux-arm-kernel@lists.infradead.org wrote:
> From: Yang Shi <yang.shi@linaro.org>
> 
> When running kprobe on -rt kernel, the below bug is caught:
> 
> |BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:931
> |in_atomic(): 1, irqs_disabled(): 128, pid: 14, name: migration/0
> |Preemption disabled at:[<802f2b98>] cpu_stopper_thread+0xc0/0x140
> |CPU: 0 PID: 14 Comm: migration/0 Tainted: G O 4.8.3-rt2 #1
> |Hardware name: Freescale LS1021A
> |[<8025a43c>] (___might_sleep)
> |[<80b5b324>] (rt_spin_lock)
> |[<80b5c31c>] (__patch_text_real)
> |[<80b5c3ac>] (patch_text_stop_machine)
> |[<802f2920>] (multi_cpu_stop)
> 
> Since patch_text_stop_machine() is called in stop_machine() which
> disables IRQ, sleepable lock should be not used in this atomic context,
>  so replace patch_lock to raw lock.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
ping

Sebastian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
