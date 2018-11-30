Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54730C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:13:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211312082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V0MYv1Z6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VApAm0kk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211312082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bN/yP3URcvv9D5e/J10qobAlhq8wqIPfgdiYcoeOACE=; b=V0MYv1Z6I4R04T
	U8V8crtpfz5m0Cd7Kb+rNxiConAUe0r4sv94YjUbDbiPHCnE2N1cTABONi0IXxfg7eudPbunrZPwd
	H7WlV/tmEa5+98pwVh6lqcfZed97VhItdflaIUpEG/hRFh0hJw5YM/p0ur4btYRF8IvwBBh858xPC
	8Gg2e61EcU5HY4xh8oUK17GsiT4P3Tf2TZHvdovXGtCj8ovhLezmdaRqmSk4ldx4ZNtciOBZG121o
	AfdKFohRqkuMfKl8Di6RnQnbblXMbTb21KJ2k/TLUDKViY0odLs+/TyOlhNjXk8woQNmo6U76QWvO
	bFy2A/ncOqQv3b97e1FQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSczt-0007Oy-DS; Fri, 30 Nov 2018 07:13:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSczp-0007OF-Kx
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 07:13:55 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0F8242082F;
 Fri, 30 Nov 2018 07:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543562023;
 bh=LgAiJxMiwpPQwI0FkQS1J58MaTUS/KzWDBb8bzTmmnI=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=VApAm0kkaTnsz6qGs1+jC6GYJPYH1AsId7OuKbz0kAto45o2YfirPHHagYcP0K/Q2
 Ka/dcFm2UEfkDEUm+Nj41yw1UThVk11pwMY7tUYF+NigcnvPhkmWApRAxNsHe0MmbN
 OKzoUmT4vGjnSupbbqiakX3He7bq04IYN6lr1E3s=
MIME-Version: 1.0
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>,
 YueHaibing <yuehaibing@huawei.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542281788-129746-1-git-send-email-yuehaibing@huawei.com>
References: <1542281788-129746-1-git-send-email-yuehaibing@huawei.com>
Message-ID: <154356202192.88331.9059182727616559057@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH -next] clk: stm32mp1: drop pointless static qualifier in
 stm32_register_hw_clk()
Date: Thu, 29 Nov 2018 23:13:41 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_231353_708941_4B2D34ED 
X-CRM114-Status: UNSURE (   5.86  )
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
Cc: kernel-janitors@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting YueHaibing (2018-11-15 03:36:28)
> There is no need to have the 'struct clk_hw **hws' variable static
> since new value always be assigned before use it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
