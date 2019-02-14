Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6BBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:56:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE25A21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DEcOCxra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE25A21B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ZxJvqbVD/5u7FL4hVytuXbHzjIbIyX5jNjXux1XVg0=; b=DEcOCxra0gH+bt
	Z8CPjAdMV71MMtkvOp1+znjKTqfbGcr1IkrgIe89said3oak9FKIU39dqbPlmpNNgxnkEqA3dNPGR
	EsRMNl73JKNobGEkdC7LJK/+es5vLAxItY/ZFcXtxIKxdHTn94gcOFKXi/qRShVY69NzzmXMlsFVV
	KTbXmqpCBuHBIds4Szrl+8o7UEOHiQ74EfgTzXAtmE9TttrjBzH1IGTC4tKtuRSGhmCHJFtxbgMLF
	7a1rW/nrqWSeB6QWBkiAmhsGFyXeDPHVT0CLBwMtTrb/+bo80eND95qHOOjhm02JFJ7M+S5St52vw
	5UpupNEVpCAKNtGugHMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guOza-0000s9-Hk; Thu, 14 Feb 2019 21:56:26 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guOzX-0000rq-7Q
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 21:56:24 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id EA76A14D92FE6;
 Thu, 14 Feb 2019 13:56:17 -0800 (PST)
Date: Thu, 14 Feb 2019 13:56:14 -0800 (PST)
Message-Id: <20190214.135614.1795866372655163721.davem@davemloft.net>
To: thor.thayer@linux.intel.com
Subject: Re: [PATCHv4 5/6] net: stmmac: socfpga: Use shared System Manager
 driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <1550177058-1860-6-git-send-email-thor.thayer@linux.intel.com>
References: <1550177058-1860-1-git-send-email-thor.thayer@linux.intel.com>
 <1550177058-1860-6-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Thu, 14 Feb 2019 13:56:18 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_135623_276116_5B945FE8 
X-CRM114-Status: UNSURE (   7.02  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 arnd@arndb.de, mchehab+samsung@kernel.org, catalin.marinas@arm.com,
 will.deacon@arm.com, linux@armlinux.org.uk, bjorn.andersson@linaro.org,
 dinguyen@kernel.org, joabreu@synopsys.com,
 linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, olof@lixom.net, peppe.cavallaro@st.com,
 lee.jones@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: thor.thayer@linux.intel.com
Date: Thu, 14 Feb 2019 14:44:17 -0600

> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> The ARM64 System Manager requires a different method of reading
> the System Manager than ARM32. A new System Manager driver was
> created to steer ARM32 System Manager calls to regmap_mmio and
> ARM64 System Manager calls to the new access method.
> 
> Convert from syscon to the shared System Manager driver so that
> both ARM64 and ARM32 are supported.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>

Acked-by: David S. Miller <davem@davemloft.net>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
