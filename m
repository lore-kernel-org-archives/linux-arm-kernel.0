Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0393CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:01:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8772070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HhFdTjSw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zbG7Jwbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8772070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dJJV79SyNKoTLLN1jn4/VjAso4kL3WJnceb6bgPopDo=; b=HhFdTjSw/Lydyo
	648vNlU2xoYrDfFiBEhjB1BcRoBaLvC7YPbZQoZuLQ6xcoWjZnPgR2liS684TkNPlU4aRq2Fq+dfB
	Bu6P2dWYqdV8DBZ1mNKbalSyX/eiJLkFAXxy563Ouq/oJeM8AySLf8rBxgZFhB8G0IBOLg4YbLSMe
	krPotmDnZ45DfCaWWLTDB185MKTetfxBDncm7vXup1dgslAo2JLO5xC7oHtT68jxXfqPwdGcku5Ve
	SCgsu8ypSj/qOMnR3xaDzXNwu+ynKMw7ptggrwhYwcnvqbyV1XdE3ik/MjY/K+o24b9/gCGvxs+zR
	Rrp3Jq3WSVl4dTWnwLNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxF8l-0005us-Sd; Fri, 22 Feb 2019 18:01:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxF8i-0005uT-M3; Fri, 22 Feb 2019 18:01:38 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B08D32070D;
 Fri, 22 Feb 2019 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550858495;
 bh=RnGSRIRoxLinEss0lsHeRvJ3ZVh/iBaXxkaLvx+Segk=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=zbG7Jwbmrjosvtr835wNymcHR5dWwrlBWgksNT221wD27k5eQgotdBWo5OHgqVug6
 OKsJJicTRVR/0T4lJwa3H3JTb6EqBGzDQhzD2Dl3FhrDl3cyevnwxh0ieY0ly+HWjI
 hVj7J3Vaq4rQDXzhGZNjNSl047WRbaThSXNQEv3g=
MIME-Version: 1.0
Subject: Re: [PATCH -next] clk: mediatek: fix platform_no_drv_owner.cocci
 warnings
Message-ID: <155085849499.77512.81847793194913571@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214015616.130334-1-yuehaibing@huawei.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214015616.130334-1-yuehaibing@huawei.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 YueHaibing <yuehaibing@huawei.com>
Date: Fri, 22 Feb 2019 10:01:34 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100136_739245_01FB17D4 
X-CRM114-Status: UNSURE (   5.26  )
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
Cc: linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org,
 YueHaibing <yuehaibing@huawei.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting YueHaibing (2019-02-13 17:56:16)
> Remove .owner field if calls are used which set it automatically
> Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
