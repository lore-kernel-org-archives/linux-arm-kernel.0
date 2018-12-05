Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B136C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C661D205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e6hhUiwa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBuVnp8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C661D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MEhaq/rcveVzfN7LA/3TgtT44pnDMeTQyz1HL9ulVy4=; b=e6hhUiwaLYkJly
	a0iQV//+AY+gWfG61kZw6bsH8pVA2Yxc+zlbaRTyg7lMNqB+zxRCjUzfWl4RihRyDohYjvMRv19Lo
	CMenEfDEL5Ss+6ONG6QEwo16fMDe9tckqRKwzhaU8VN3A8V+8s9qy+Ci5FjaqQRXSojLly8IeqKUl
	30D0xiUxfpqr1+1hWYIsJ6Og7EUVgggKaoWuCaEAHA/SxEzB4g7jtZWEzkSn8Z9J0/5aBcYul7uNQ
	f9JW84y7HGmuMEGU/aKMxBhT6NJX9P23G5b0XqZGpOkFn7FuAFHvbew/GWQloW35fy/aValMVJyXG
	pTBunhRvK3y+TSEIhSqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUavX-0005Al-5z; Wed, 05 Dec 2018 17:25:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUavJ-0004ib-8J
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:25:22 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CDA2A20878;
 Wed,  5 Dec 2018 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544030710;
 bh=1xZHk5U/u8j6lAwFyyDkz4h5vtVcooAHfDHY8mf/cJc=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=YBuVnp8wqbmwcRpe5EJjESQvF/928Cyg4+MP7nUw6MR+1hQk+vTg+OCDUgW4M43yY
 Dr4m129doVz6QpIV7sV+UopY+wgITwxM18uIlVyOEyw6O42ydMGOCbEso9TMkdfSqz
 Y8+f6iWzchDt6GE72mwMqbs9vLEfLYYCWv1lrcL8=
MIME-Version: 1.0
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <90cd96112ca1ade6bff3b58989e290ae3def59e2.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <90cd96112ca1ade6bff3b58989e290ae3def59e2.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154403071006.88331.16284741533378833854@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 06/10] clk: clk-hi655x: Free of_provider at remove
Date: Wed, 05 Dec 2018 09:25:10 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_092521_587684_919267D5 
X-CRM114-Status: UNSURE (   5.87  )
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
Cc: david.brown@linaro.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 andrew.smirnov@gmail.com, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
 linux@armlinux.org.uk, krzk@kernel.org, akshu.agrawal@amd.com,
 cw00.choi@samsung.com, djkurtz@chromium.org, pavel@ucw.cz,
 pombredanne@nexb.com, andy.gross@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matti Vaittinen (2018-12-04 03:37:29)
> use devm variant for of_provider registration so provider is freed
> at exit.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
