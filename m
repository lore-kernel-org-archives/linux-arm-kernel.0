Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A38EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:47:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A27E2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MUPY3XQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A27E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N9uP/KRxrxm0MIBXJpEWsoOYfQisunLZemgHFRTDae4=; b=MUPY3XQZvP43bn
	YvW8qyhU5s49FOzmhuWaIsaJxUgMALuCASebsW0zgIJrJKaEXk1UnJdwyEGYsPfjmJy81Nb5GAhKh
	bstQa5US5v7vgIm7k4AhUq3XpnfSjnELVaieEIKqY8t8nV4evDpUqpmTEDmpdPXDgc1YXFSEdPn0S
	MCmym5OqvuaHF5Tp5D1JPia3HwITz1X60/nmmtD2/3AcOiFLkTw93JxTQjF7/jk7/3OqxReC36HIJ
	drawdDDVz6ywDz5OyIiTSAdy3OFxCS/ygjxSnGpIfb9Gn+09wpgRBT/R/Zx5PSFkOlLD5umYnHIZB
	QFDDmoLZzmTydx3SwIRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwU5U-0003mg-0k; Wed, 20 Feb 2019 15:47:08 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwU5Q-0003mD-Nh
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:47:06 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id DD5FA80E1;
 Wed, 20 Feb 2019 15:47:11 +0000 (UTC)
Date: Wed, 20 Feb 2019 07:46:58 -0800
From: Tony Lindgren <tony@atomide.com>
To: Christophe Aeschlimann <c.aeschlimann@acn-group.ch>
Subject: Re: da850 dt cpufreq support
Message-ID: <20190220154658.GP15711@atomide.com>
References: <ccdb73e4-e4eb-2552-b62f-6cf57929dfee@acn-group.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ccdb73e4-e4eb-2552-b62f-6cf57929dfee@acn-group.ch>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_074704_807707_EB607F99 
X-CRM114-Status: GOOD (  10.18  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org,
 Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Adding Bartosz, David and Sekhar to Cc.

* Christophe Aeschlimann <c.aeschlimann@acn-group.ch> [190220 15:34]:
> Hi,
> 
> I understand that today the da850-evm is supported in two ways in the
> Kernel, using board file, aka "legacy" and device-tree.
> 
> Am I right to say that when using the device-tree there is no support for
> cpufreq available ?
> 
> The "ti-cpufreq" driver doesn't target the da850 SoC and the
> "davinci-cpufreq" driver doesn't make use of the device-tree bindings.
> 
> Could the generic "cpufreq-dt" driver be used ?
> 
> Best regards,
> 
> Christophe
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
