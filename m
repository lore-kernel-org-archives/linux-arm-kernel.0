Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8B8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:39:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7D020657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y6HBYiBX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeTyiLcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7D020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cGjrTHCVgPIHOY8d5bc7S1f2wDo/Dd+zMICN0Cfq4ZE=; b=Y6HBYiBXuVrq8B
	aW2AvpsWyq8AdOjlKzGriQNGa5Uber9INCwk8hu33txAsMQ9X1rJgh2og7GAcl346koQmJ8wR+fex
	7J3QS9w4j0RxMtNVzxmkJRV+54QsDlBS3l8tpe3clqnPh7UIRNuPu4rKHW+k38tHBNer98feZXMwJ
	inHMxfjQsfDYXxi9SIW61Z4IQSYsZtLnSnZXM9OXJe5l+ZXZNK5v7AbnGKufnjdDgb0qS3dgFOC91
	T1cDDegbrxEFpkUdbPQgUby1b4n3N62EnsHV6cbX1flmVWt4ngKvPaBNf2aSsvQ+rNhTJBJg9a4X+
	eX7Npmo0VxmG/hvcwkjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIlJ-0004p7-O2; Wed, 09 Jan 2019 18:39:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIlE-0004jb-Db
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:39:30 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C9A4D20657;
 Wed,  9 Jan 2019 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547059167;
 bh=VrH//XlMJm8zf4cEdUsxKdKXXd1j0P1uCJjI7t/nZdg=;
 h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
 b=KeTyiLcPUS/vkj0DieVFRd7UHbTgmSMcgPhE8vs+lcj3oavDNQVHp4Nb6Wz/yo3hU
 88xrMfrKSDcxhYY11gImwy/riO+cBEjlNxmCwLVg75vR1oGyVxMbnRjVmIlG7A6Mf3
 r1zuRuL7LU5i880pPkKFAKOknoU+TwPXpsE/6kcI=
MIME-Version: 1.0
Subject: Re: [PATCH V4 10/20] clk: tegra: dfll: build clk-dfll.c for Tegra124
 and Tegra210
To: Jonathan Hunter <jonathanh@nvidia.com>, Joseph Lo <josephl@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <20190104030702.8684-11-josephl@nvidia.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20190104030702.8684-1-josephl@nvidia.com>
 <20190104030702.8684-11-josephl@nvidia.com>
Message-ID: <154705916710.15366.6261013325488194200@swboyd.mtv.corp.google.com>
Date: Wed, 09 Jan 2019 10:39:27 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_103929_086759_12F9F11A 
X-CRM114-Status: UNSURE (   6.00  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Joseph Lo (2019-01-03 19:06:52)
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Tegra210 has a DFLL as well and can share the majority of the code with
> the Tegra124 implementation. So build the same code for both platforms.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
