Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0826C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:04:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC8B21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D5WKBdQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC8B21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kiLdrNVdibyZIjQd2oUsuFZ6RHnXpHciiwLFsRjL0/E=; b=D5WKBdQELtb3Oh
	CsIVflCQvQuq/Ch4gTArh0cN6DlDOE8jrOM3kw5JLb9aYO//9clkxTlsS1BjGrA0sMpqBO9dt7mRJ
	dwksv+WncS1AXe2+f878m1Vn2KQ7eTxMaV8Vq/v+otR4tnwr3i3nI8E0f1U4vZe2+x1ZuE9LG9t96
	z05bBxmgVHFNd4nYzhYHsJEeDQr2P/rCkUCWk6Dbz1FNAcYIgI2eA6k8sa+5KsUqk31Jsgr7b+Lgc
	gwgoDRfgUGkDkr7u4HeOwylXxoyuuIZ+uwsNqf9Ri1pW4855muLqMHyS62GgxxGjHm93zYH8Nh7II
	zWCu0MQwaH+Jx9Eq66/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go0xn-0006Wk-I5; Mon, 28 Jan 2019 07:04:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go0xl-0006WQ-0s
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 07:04:10 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 316A6C049DC1;
 Mon, 28 Jan 2019 07:04:07 +0000 (UTC)
Received: from localhost (ovpn-112-14.rdu2.redhat.com [10.10.112.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8829C83BEF;
 Mon, 28 Jan 2019 07:04:04 +0000 (UTC)
Date: Sun, 27 Jan 2019 23:04:03 -0800 (PST)
Message-Id: <20190127.230403.636736583040998189.davem@redhat.com>
To: khoroshilov@ispras.ru
Subject: Re: [PATCH] net: stmmac: dwmac-rk: fix error handling in
 rk_gmac_powerup()
From: David Miller <davem@redhat.com>
In-Reply-To: <1548532137-15618-1-git-send-email-khoroshilov@ispras.ru>
References: <1548532137-15618-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 28 Jan 2019 07:04:08 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_230409_082060_42AAED9D 
X-CRM114-Status: UNSURE (   9.13  )
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
Cc: ldv-project@linuxtesting.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, joabreu@synopsys.com, david.wu@rock-chips.com,
 peppe.cavallaro@st.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Sat, 26 Jan 2019 22:48:57 +0300

> If phy_power_on() fails in rk_gmac_powerup(), clocks are left enabled.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Applied, thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
