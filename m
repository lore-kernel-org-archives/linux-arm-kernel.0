Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECCBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:51:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD0E2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="an8q8ElE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T188J0YV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD0E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TPV/DwFAi+ZKizEhlxdvop84q8rDLSehX/dllB1jKGg=; b=an8q8ElEcSQIdD
	NJGpvALxcYs02ADowufUJ+DgakgTDE3WXSYZzUYaNsPboRXF2IKQxu6JUwjy15D2GTH01jsxCOYpC
	E73WBJfSbhDfa4zitjEqMTs+Lm/qsCUoztr0yaSHXgKCdkRCDSJ8qiD1Sf3Z8dHTgtGdiqlBzajPK
	E8z9hwKU0+JIslaUjm8ZsaogNMBL+DH9n3Hkj+sL+C5BwoxyIVHHb55JGNV9FcMcj32/j+5WQgSuY
	FsRRJg6aMdtei6arKICfl/43IqRHSxkMk8uZM50BqZvokFIOekb32qC6tVKlYTbUpOE/xUjGsukZZ
	Gt3mFZ+MI/XIOSFb5JmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwwFA-0003My-4H; Thu, 21 Feb 2019 21:51:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwF6-0003Mc-TU
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 21:50:58 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7690B2080F;
 Thu, 21 Feb 2019 21:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550785856;
 bh=h6oZyCtlYLrGZq8wIDGwta/uWRrekXkscDhXsehQGP0=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=T188J0YVNc0dIoMKTxgimFU8KK7aYmHL73lf4Be/lVqHSlik0ukgHhSi7wh0T2a99
 zo+U/jzSzoR1DiAappPqkxuNTWk73ypdTW8oFvn1+N09oWo0fEwtYInEDso4hmtmXb
 9e5NQVXX+ALS2WS1XdGkCirMdS+uNDZgjUvbzJTs=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: uniphier: Fix update register for CPU-gear
Message-ID: <155078585575.77512.3010881838838127902@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1549592723-18494-1-git-send-email-hayashi.kunihiko@socionext.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1549592723-18494-1-git-send-email-hayashi.kunihiko@socionext.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Turquette <mturquette@baylibre.com>
Date: Thu, 21 Feb 2019 13:50:55 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_135056_977014_B4B0E0B8 
X-CRM114-Status: UNSURE (   7.42  )
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
Cc: linux-stable@vger.kernel.org,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Kunihiko Hayashi (2019-02-07 18:25:23)
> Need to set the update bit in UNIPHIER_CLK_CPUGEAR_UPD to update
> the CPU-gear value.
> 
> Fixes: d08f1f0d596c ("clk: uniphier: add CPU-gear change (cpufreq) support")
> Cc: linux-stable@vger.kernel.org
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
