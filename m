Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ABFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:05:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845652075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NCcoeRLt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p15U12WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845652075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tYIW0JqhtfjJZpTbWldtRhFKJb8v07CB6zP1plWgtnc=; b=NCcoeRLtpH22ul
	qC91E9dsVuJ8f8M+tSRBAtr/sKVy+XX/RrvKoAQWtQgaEV+eVEGsZxoPyfuVj53SBfbDWw/DsWIpM
	nAEYrx4Af4KTC9rk2NlzsjC6U7Muz5gmnZeQ4+Qv2RYbS9NIjxd+bmGf1RgMHXM0a/NUmXxhqX4pX
	v6KkzVvcHHfwj586tyh9cv7XtjyXya1RlCUcVDA3i0BPZvEAOW81ZlzTg7vLSORlML/aqa2c3rOiV
	gVaJCXsgrz4CuJgFbTRIq6gOTg3CDWxdSA1b7tDVo1XnaNxqZfI3JCiRsTLHVZBC+alegcEmQD5yd
	3ziI3aROJFzCHSRCkQQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grSVe-0006NU-HU; Wed, 06 Feb 2019 19:05:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grSVR-000642-JG
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 19:05:11 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2F1FD2186A;
 Wed,  6 Feb 2019 19:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549479909;
 bh=ZemIRr87mympofqI890c43n5tJ0wMqXKtody80aXefg=;
 h=To:In-Reply-To:Subject:References:From:Date:From;
 b=p15U12WOtgy22aGvOYLQNlxQ1xH4+RObL7wE3aBFhY9SdtCScEF/MDzdIMgNL6r2k
 YR7qvpEMPXuF+lxD1qiz4siHucR73AtS/fp7bGNU0fAoK1aarI5EqMv9/abYwsCHLn
 uqZHE92esHGjN7ookCADXONeM8Wi79i50ad0+naA=
MIME-Version: 1.0
To: akshu.agrawal@amd.com, andrew.smirnov@gmail.com, b.zolnierkie@samsung.com,
 corbet@lwn.net, cw00.choi@samsung.com, djkurtz@chromium.org, krzk@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 linux@roeck-us.net, matti.vaittinen@fi.rohmeurope.com,
 mazziesaccount@gmail.com, mturquette@baylibre.com, pavel@ucw.cz,
 pombredanne@nexb.com, rafael.j.wysocki@intel.com, sjhuang@iluvatar.ai,
 sre@kernel.org, vkoul@kernel.org
In-Reply-To: <05409aafa108c77b2b878ed9663717c4b4a183ca.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v7 2/3] clk: clk-max77686: Clean clkdev lookup leak and
 use devm
Message-ID: <154947990848.115909.478174902516192562@swboyd.mtv.corp.google.com>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
 <05409aafa108c77b2b878ed9663717c4b4a183ca.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 06 Feb 2019 11:05:08 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_110509_813039_C8EA1DC7 
X-CRM114-Status: UNSURE (   5.50  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matti Vaittinen (2018-12-07 03:10:15)
> clk-max77686 never clean clkdev lookup at remove. This can cause
> oops if clk-max77686 is removed and inserted again. Fix leak by
> using new devm clkdev lookup registration. Simplify also error
> path by using new devm_of_clk_add_hw_provider.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
