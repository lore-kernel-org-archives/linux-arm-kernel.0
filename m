Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9960BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:32:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AFB206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YhIH8Pn7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cWR1GpfA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gFgwfpnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AFB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:To:References:
	In-Reply-To:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SpQoZbAYQOFFlVUiHXY136AjqVMDF2r2tORyVsLfSOY=; b=YhIH8Pn73MhQXT
	ABIouhZSMiBy+C0wCPdXWviFV+tkaPWH6iJqxEtCW6GgRERu7PSL+Zi/8irTnMPwrR+jnl0qbOVix
	JynXDH1F6t+xMcDRpYFrThJyc2zL8heJoLz1WPrPMRVPe1XFFiK0cIvpYWRkaq7UpZzBy/PWMtdws
	1toyxv4ajiYlSqNbV4jBvfemoa+NeoX4lvqlKiP+otEX/j5u7vmAsMc7t8k7nZ8j2P1FORiXwJoU+
	AwXLpmrrReONtmh4Y/5mtu/pHZX1+xjEdtsXe0j9IfCMuK5tnE96i5FVILKe4CJAEeMk0vSUICU6u
	jMpJLmf4lxoIHfvLcXhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghYZL-00067h-78; Thu, 10 Jan 2019 11:32:15 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghYZH-00067C-8C
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 11:32:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 28E7C608A5; Thu, 10 Jan 2019 11:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547119930;
 bh=H71mAAF+/Swkti+M7Ut2UeO+/FLR+Pmb716MuGIJzeY=;
 h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
 b=cWR1GpfAcRwUVBECSzVJIrpcjZt3c8utviOER4JPPqQeB9MlP+3GvGtkt1rjPkZn9
 98YwFsdau+3NyauHtplTf42eLmwbsHqqhqG21GVNr21joCIx/I9GmvbYiy40L+pR25
 JiVTxenBfEnUzpzA7Kd8PvEbmRKvMdbpfWS2LEOA=
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi
 [88.114.240.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: kvalo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 87CD060247;
 Thu, 10 Jan 2019 11:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547119929;
 bh=H71mAAF+/Swkti+M7Ut2UeO+/FLR+Pmb716MuGIJzeY=;
 h=Subject:From:In-Reply-To:References:To:Cc:From;
 b=gFgwfpnVMLj+KJm+Cf29MjJsGYv58wrxOumxoXgG4Mb2sI/i+3RYdlwnSqgraG61/
 kGPYlnMtbD4dHGrV7IAGwXw/tZ/XAfj3IT6BdHEt1AfQQ56BRkT/6R13uPdeMZg/BE
 188U5uIflEkXI2DBLRmO7d1dDwabE6iycZ6UGfP8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87CD060247
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=kvalo@codeaurora.org
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] wlcore: Fix memory leak in case wl12xx_fetch_firmware
 failure
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1545205829-31979-1-git-send-email-zumeng.chen@gmail.com>
References: <1545205829-31979-1-git-send-email-zumeng.chen@gmail.com>
To: Zumeng Chen <zumeng.chen@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190110113210.28E7C608A5@smtp.codeaurora.org>
Date: Thu, 10 Jan 2019 11:32:10 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_033211_334295_41155132 
X-CRM114-Status: UNSURE (   8.55  )
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
Cc: tony@atomide.com, Zumeng Chen <zumeng.chen@gmail.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Zumeng Chen <zumeng.chen@gmail.com> wrote:

> Release fw_status, raw_fw_status, and tx_res_if when wl12xx_fetch_firmware
> failed instead of meaningless goto out to avoid the following memory leak
> reports(Only the last one listed):
> 
> unreferenced object 0xc28a9a00 (size 512):
>   comm "kworker/0:4", pid 31298, jiffies 2783204 (age 203.290s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>   backtrace:
>     [<6624adab>] kmemleak_alloc+0x40/0x74
>     [<500ddb31>] kmem_cache_alloc_trace+0x1ac/0x270
>     [<db4d731d>] wl12xx_chip_wakeup+0xc4/0x1fc [wlcore]
>     [<76c5db53>] wl1271_op_add_interface+0x4a4/0x8f4 [wlcore]
>     [<cbf30777>] drv_add_interface+0xa4/0x1a0 [mac80211]
>     [<65bac325>] ieee80211_reconfig+0x9c0/0x1644 [mac80211]
>     [<2817c80e>] ieee80211_restart_work+0x90/0xc8 [mac80211]
>     [<7e1d425a>] process_one_work+0x284/0x42c
>     [<55f9432e>] worker_thread+0x2fc/0x48c
>     [<abb582c6>] kthread+0x148/0x160
>     [<63144b13>] ret_from_fork+0x14/0x2c
>     [< (null)>] (null)
>     [<1f6e7715>] 0xffffffff
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

ba2ffc96321c wlcore: Fix memory leak in case wl12xx_fetch_firmware failure

-- 
https://patchwork.kernel.org/patch/10736825/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
