Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87233C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 07:01:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4690120857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 07:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fkl1188X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4690120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BZpByZqH63h5SCrAQBk/QGP4pu8NmkK+YPIcO8LV/sk=; b=fkl1188XAnPDXz
	Up8QRytfJMZcBXwHTcdpiaeCQCMSjFHVekB7ZnJB8155axv7zrPo7W3xCcmbwXh72Yq4v2tI7u3BE
	/hHCOgsiYa5Q8a1EbN0Ht6Ud1i14sAKeUbBJbH1msz8f6bOT4wxRebA40qMXBCMhL0CNxSJVM4TzM
	ZsdTZknVuHs0Wm6jktwlk3IlZReHCp3cqCG251F+iB60typFpwpkbFVDYNI6Lz/kCktiTMYiFYtnm
	1rEx4N9QaCf0A60yaI5WNGytPaQVHl16KcpVOqZG2h5ESrYFl8cWQUKRfWIGXL+/foLkF3vwi1S1w
	51AKBXfcHSgGyBsZoXgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsMdh-0003Pi-BP; Sat, 09 Feb 2019 07:01:25 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsMdf-0003P7-2Q
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 07:01:24 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id DF220149DE371;
 Fri,  8 Feb 2019 23:01:17 -0800 (PST)
Date: Fri, 08 Feb 2019 23:01:17 -0800 (PST)
Message-Id: <20190208.230117.1867217574108955553.davem@davemloft.net>
To: yzhai003@ucr.edu
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190207174623.16712-1-yzhai003@ucr.edu>
References: <20190207174623.16712-1-yzhai003@ucr.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Fri, 08 Feb 2019 23:01:18 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_230123_110555_E8E2F7F0 
X-CRM114-Status: UNSURE (   6.55  )
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
Cc: csong@cs.ucr.edu, alexandre.torgue@st.com, netdev@vger.kernel.org,
 zhiyunq@cs.ucr.edu, linux-kernel@vger.kernel.org, wens@csie.org,
 peppe.cavallaro@st.com, maxime.ripard@free-electrons.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Yizhuo <yzhai003@ucr.edu>
Date: Thu,  7 Feb 2019 09:46:23 -0800

> In function sun8i_dwmac_set_syscon(), local variable "val" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used directly in the if statement, which
> is potentially unsafe.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>

This doesn't apply to any of my trees.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
