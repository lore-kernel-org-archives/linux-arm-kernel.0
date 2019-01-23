Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC517C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:37:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8602A20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uKxVvK+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8602A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BwsYw76hlX9q0AcZScNlz8T4rlMf/0Y6CL9eBq/AlCk=; b=uKxVvK+WxZGJgB
	9U6xHA50cEtql5PNPYiug1XfyBF946DnyY61LNmylFNlVxT/cUaB/bTP3JTMZC7kzd2lSYtjGxxze
	7op1XeNUAgR0aE8gLX5HeDmeEtCsowyTyuNlB/OE62264KmjqN65LUCtoKAV8vsZCF++u9w2pU/iJ
	TDzcymuD/BK1+MQyH5PFzUNR7QkBrukpAXuyTyURGet35X28Ynez8E5kCfHwv9mdcboIWQpT16nRI
	K8CuST8BCaAcHL+Aoom/hOo5IvVSiR9iiQ6wOITHRIUVH/A04JPhLeDTB/3RE5q/UkyrnAgFW9Dok
	WfSbblQeYAE4FpqvoLsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm7Tx-0001Dc-Eo; Wed, 23 Jan 2019 01:37:33 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm7Tv-0001DC-4I
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 01:37:32 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id E421B14D63A88;
 Tue, 22 Jan 2019 17:37:23 -0800 (PST)
Date: Tue, 22 Jan 2019 17:37:23 -0800 (PST)
Message-Id: <20190122.173723.1609622837834592384.davem@davemloft.net>
To: panfilov.artyom@gmail.com
Subject: Re: [PATCH net-next 1/1] net: stmmac: implement the SIOCGHWTSTAMP
 ioctl
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190120160515.26473-1-panfilov.artyom@gmail.com>
References: <20190120160515.26473-1-panfilov.artyom@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Tue, 22 Jan 2019 17:37:24 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_173731_173575_D03E7B93 
X-CRM114-Status: UNSURE (   6.51  )
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
Cc: alexandre.torgue@st.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
 peppe.cavallaro@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Artem Panfilov <panfilov.artyom@gmail.com>
Date: Sun, 20 Jan 2019 19:05:15 +0300

> This patch adds support for the SIOCGHWTSTAMP ioctl which enables user
> processes to read the current hwtstamp_config settings
> non-destructively.
> 
> Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
