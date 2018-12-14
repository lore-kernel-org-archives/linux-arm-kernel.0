Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EC4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:04:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9BC20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UF19vITa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbpQPcF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9BC20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0P5VJ45zsw4dJLdywFY/5nWXQWNYpAe+L8/sUEu2rPg=; b=UF19vITayiW/LJ
	p6rxr4+NxHKSP5qYyl9N1t8OIasZIREaSXVGsJU3mGgyT2anIzLYmo8b3ZPWsbFDTgd3k8/mTEmje
	R9GQ4DK34PyPIvViOcQ+mUg52cIwXpEpQpioCR9Cx15yT69etko0c7Fea/tW7F2Yb+r8ipppx6QEU
	VY0NWsQSuTD42TVSzJeBiW73vpiyW4E+GPtjV9Y6WlVP52iIVfLe7IJYgU69O66orK0t0xdhM1M0r
	jDYYLzW+k3A4clDL8VmuennjzjS6jwX8WTC+dp7in1fSOjHQd81M3QMwdWZYna+kv2Hx0UKJszzJ5
	PWELe3QY1ePuMMHa+TrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp0U-0003q6-6P; Fri, 14 Dec 2018 15:04:02 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp0Q-0003pD-Fq
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:03:59 +0000
Received: by mail-lj1-x242.google.com with SMTP id s5-v6so5138674ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u/qGRSrhkslRfRZkCOSZnGtEVWI+I6J5PC6Xl0kVfQ8=;
 b=AbpQPcF1RdcDXZRWJoX/EauVBx+LTUdwfG2YHOniVGj5EvV38YIB21Bh0Hd5ncW7Ne
 xKjFsRDAmL+71LSUUspZC+jfp60xt6WzwC3XqL8qTaEiVLeC1YownsCOxULMviXYvxbq
 9ByJXg5lyOYZm1vzyxgrG1NoQ5CvYem5alYRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u/qGRSrhkslRfRZkCOSZnGtEVWI+I6J5PC6Xl0kVfQ8=;
 b=C0oapDjRV/QuPTKxSv8fPzXP2TQ+KTE/D36+pJIrRw0jcxxRIhBsQdwcM/FmltPuCw
 2Yj+hwCYEpg9B20YOTvUN16nkQfYCXjoQpIYHGfq9vd5tBjQXRto/6PO62sdmQxTScsI
 RK3RwQH4oyUy3Hl00d4DTUgG/JigPcF7SnibNA920kiaXyE2k58YSn1Hy1Fb1dFJaCXW
 RoeoI6ODrcLNAETCGa+z9crGZd4ykxp0+300SMSAp0Np0SwKjNBn4UzaDGh8TvtaHUr2
 KlOQh/npU/0OpmxAj/bnJPbnjQg34aJ1DOWDJLQrcUXjb3OxQLNEJ8340hAWArtueBq9
 e1Qg==
X-Gm-Message-State: AA+aEWZF3TfVbdD4zjl7klBYAsQu8DDOQUUvaITOF7ZMiS5ctqHz4mOb
 OZQF5jIPtdqH9hXErqZcFE1ksE6+eIDhhgjvb546Hw==
X-Google-Smtp-Source: AFSGD/UNcTZ6znxZsSFExRyVIZFvjBO6lvO1MpJWcsFs2NIOJvNhMoCgY6G6Z9YNMbcugl9AbzR4YB4Wja/7+NSKRT4=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr2082817ljk.4.1544799823976; 
 Fri, 14 Dec 2018 07:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-20-robh@kernel.org>
In-Reply-To: <20181205195050.4759-20-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Dec 2018 16:03:31 +0100
Message-ID: <CACRpkda2qA4AQG3sT+7LEvuGV=8EtnLFnAn8WCPbnoD75X7EbQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Use of_node_name_eq for node name comparisons
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_070358_524395_5947867C 
X-CRM114-Status: UNSURE (   8.43  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 8:51 PM Rob Herring <robh@kernel.org> wrote:

> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied!

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
