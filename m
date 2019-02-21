Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E371BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:58:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC0D20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L9xSyv3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC0D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0zCYz8OWx7wtE3S8dNnSzbCQFpAzJ4+zcGpED7awvcM=; b=L9xSyv3kLV4IWl
	igGTBU1YotgOZTbgCCDczjSpQftcT4I/VEqQLwXiHXDl4t3J3wZoyi6R/pxLkTtSx8vngLjiq55J8
	MNgM+ULhuMfe92ROf+WgdFj6UjrW+u5iTUAEQDQue7AmR/SRhE+COXIC/4AuG/TZCyIiV5GxGGOzS
	1b+TW2Onz+hd8MLlb1KMGBPhmgrqzP3VlWWu5YOLgGAYA3e3Xyqge1bchuNG/vEp1oaQfMU9UB4Pr
	3uZWMm1rm+0tfdPcfHCfPCn2vLe7y4MEyyXSNMN7rBJrftQRm4q/1zTTx59WKeWmd8lHWkSh6/XI1
	mqXeteeZ4++DdhhUGcig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwl78-0004t0-6Z; Thu, 21 Feb 2019 09:57:58 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwl75-0004sb-8O
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 09:57:57 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gwl6u-0006MY-Rp; Thu, 21 Feb 2019 10:57:45 +0100
Date: Thu, 21 Feb 2019 10:57:44 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: Re: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Message-ID: <20190221095744.xtp25ock7o4ydl6g@linutronix.de>
References: <20190215200533.ypfrdekg7j4ucu6a@linutronix.de>
 <20190216113338.irr5j4ukhpwngval@shell.armlinux.org.uk>
 <20190220110039.2p2iglhqlf6xapsb@linutronix.de>
 <f05d2cae-5664-6cc7-51c8-933d6d1403ec@hotmail.de>
 <VI1PR0702MB3840118FE9014CB1E9801F83E47E0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <VI1PR0702MB3840118FE9014CB1E9801F83E47E0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_015755_436697_68E64838 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "yadi.hu@windriver.com" <yadi.hu@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-02-21 09:31:53 [+0000], Bernd Edlinger wrote:
> Never mind, now I found out how to prove that it is not a RT issue:
> 
> $ cat t2.c 
> int main() {
>   *((char*)0xFFFFFFFF) = 1;
> }

I've sent another example to in this thread to rmk.

> $ gcc t2.c -o t2
> $ ./t2 
> BUG: using smp_processor_id() in preemptible [00000000] code: t2/832
> caller is debug_smp_processor_id+0x18/0x24
> CPU: 1 PID: 832 Comm: t2 Not tainted 4.18.0-00005-g7523d7f #1
> Hardware name: Altera SOCFPGA
> [<80112e68>] (unwind_backtrace) from [<8010da28>] (show_stack+0x20/0x24)
> [<8010da28>] (show_stack) from [<806bcaec>] (dump_stack+0x78/0x94)
> [<806bcaec>] (dump_stack) from [<8043f2d0>] (check_preemption_disabled+0xe4/0x120)
> [<8043f2d0>] (check_preemption_disabled) from [<8043f324>] (debug_smp_processor_id+0x18/0x24)
> [<8043f324>] (debug_smp_processor_id) from [<80116ba0>] (__do_user_fault+0x48/0x13c)
> [<80116ba0>] (__do_user_fault) from [<8011700c>] (do_page_fault+0x2f4/0x328)
> [<8011700c>] (do_page_fault) from [<80117200>] (do_DataAbort+0x58/0x100)
> [<80117200>] (do_DataAbort) from [<80102460>] (__dabt_usr+0x40/0x60)
> Exception stack(0xbf197fb0 to 0xbf197ff8)
> 7fa0:                                     00000001 7e963d94 00000001 ffffffff
> 7fc0: 000103f8 00000000 000102e0 00000000 00000000 00000000 76fa9000 7e963c3c
> 7fe0: 00000000 7e963c3c 76e47bbc 000103e0 60060010 ffffffff
> Segmentation fault
> 
> 
> What exactly is the reason why we should not apply this patch in the non-RT kernel as well:
> 
> https://marc.info/?l=linux-rt-users&m=154997565610392&w=2

I'm not sure that this is the right thing to do. I think you should
invoke harden_branch_predictor() before the interrupts are enabled so it
is invoked on the same CPU that triggered the exception.

> Thanks
> Bernd.

Sebastian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
