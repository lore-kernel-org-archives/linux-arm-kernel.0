Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9266CC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:41:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6471220851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mdk0aIwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6471220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gNbRbYrthu//X1TLxD4leDCpj4iikbh09yT7Gg3+p0Q=; b=Mdk0aIwl/Oz5vc
	OBOZqLkDc2Yhg5MuSU16Er5bD/+nwOg5rIsj3jC/0zmJot4vSXgzBg9FFzdTu/CVR3JX33xYiX+Th
	GvXHF0Urck6mo85ZBslGpk70y+E0IKLazKjJ1rJrRf/sR/e3toM3rjNDViuHwDv/gC+enLAyj3Da9
	aWJ0YdobcuGSCH7mqcP0hX3Xk0DVO1Ms7D17o+CQj4Gg1/NbU1A8quv3uaUccSfmnTLmOcOoSdknk
	8Fg2ZALB4+mqMzyA5sFrNZUMVdT/iCZQvxnJk7C1E6MepVb4HpsUJbYLlSolV/W43W8o28j1KsT5S
	q3/PP55XrIe+HipgeQsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXE7v-0005XJ-60; Wed, 12 Dec 2018 23:41:15 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXE7r-0005Uy-7s; Wed, 12 Dec 2018 23:41:12 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id E6393149B2E87;
 Wed, 12 Dec 2018 15:40:59 -0800 (PST)
Date: Wed, 12 Dec 2018 15:40:59 -0800 (PST)
Message-Id: <20181212.154059.943420976868382142.davem@davemloft.net>
To: biao.huang@mediatek.com
Subject: Re: [v6, PATCH 0/2] add Ethernet driver support for mt2712
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181212.152114.107710423985118689.davem@davemloft.net>
References: <1544607332-29921-1-git-send-email-biao.huang@mediatek.com>
 <20181212.152114.107710423985118689.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 12 Dec 2018 15:41:00 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_154111_284763_62D04D3E 
X-CRM114-Status: UNSURE (   6.70  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 andrew@lunn.ch, netdev@vger.kernel.org, liguo.zhang@mediatek.com,
 joabreu@synopsys.com, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: David Miller <davem@davemloft.net>
Date: Wed, 12 Dec 2018 15:21:14 -0800 (PST)

> From: Biao Huang <biao.huang@mediatek.com>
> Date: Wed, 12 Dec 2018 17:35:30 +0800
> 
>> Changes in v6:
>>  modifications according to comments from Rob/Andrew/Sean:
>>  1. use delay_ps instead of delay stage.
>>  2. add comments in driver to avoid confusion.
>>  2. rewrite set_delay function.
>>  3. modify binding document for properties: tx-delay-ps/rx-delay-ps/pericfg etc.
> 
> Series applied to net-next, thank you.

Please send me a follow-up patch to fix this:

WARNING: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.o

Thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
