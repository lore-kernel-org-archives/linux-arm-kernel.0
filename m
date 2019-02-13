Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64556C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:03:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF23222C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oHivxCv6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ5L+1cB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF23222C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DsOtRAAOcO2NwfaGNhqcjLoqR1bKm7f6wnha6k35JX8=; b=oHivxCv6ZGSBsy
	hug6QVoe2SS7ZoD4zK4YiaMoZa1DEBv8rxFid5oeKtsdd/kHAad0iaIiRNSN+wXJkXpbm+aycSpmI
	AKUpr76pJUMWffM1uzb0DcUKoJ2FK6wd/3u3AMqJSugFz3s4tKeTfAgovT4MVWdz1tgLq3QDxxWAn
	Vz16w2X5nOIB35jA8v+MBICAuPYCKG0y0Dh+5PlaWNV5mnoiZw81LiFw+SALNARsuXyVy3NkNbKz2
	UexBCUqJj+J6JjxxG3PZh2Tmlf0rzwCZzf6XIjI2wjb13uzbDgM9c3M2mki7GunsIY0ZT4b3+ECBy
	bkgqsfNSNMjuqlnHmlxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtjtf-0007wF-Cw; Wed, 13 Feb 2019 02:03:35 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtjtb-0007vq-Pk
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 02:03:33 +0000
Received: by mail-ot1-x344.google.com with SMTP id i5so1328216oto.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 18:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OehTQek4rJm22s9qb4aYOPY6sBsEtb7lgK66ghwhx0U=;
 b=iJ5L+1cBDqa7OxD2EmI1Oe+MjhkPu5w0hAMRCw/wkNLrYf98m6LnJkh6LhjHmuRwON
 zSTgB23xq+EKRo4Pn4Ctq5ASDeVkW23DDLj2srBIq3Eczwlfk+D6KLeXdJHHZf7SPA9j
 ZpJZkN4F2pqhUVyn56cu3wogVfWemjqmAcRSac2DNdr+o1CPR/MToRf0c5LVgXni3D42
 mNhICWzz/r4xxj4HYrO1LAK9+ICx67JAI7FqQXa7FJIE1dyvgi3SBamKRhmXsKW3vbEL
 jiok7cujOlEwUt8r9FZwZf0VwdgMFS/tRqyH8gCVg3hySnAH+Sjm+D7BtX/ApaYPDXZs
 FgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OehTQek4rJm22s9qb4aYOPY6sBsEtb7lgK66ghwhx0U=;
 b=FvvLn/kduhgeqUHDTlFmluOQuFtwKNfqeh879OgpTmUhu7PAnaZzqlZD6GA6DbFLZr
 t5BnEKfdCu/c9dw2qcwNEXJ1mOY9NCWhqYjhABLd2mmgDQ2IpmNaK43WL70ck+dRfeGe
 8N7rH9ElzqnBI6531VMVXeMrGYK4OYHMdR3CJLYcd1p0NYXQSw8v3fRatMzhLLewWM5c
 HPADIsyDQaqSrQdIu6OfiI2XB/D1ga+jrsIXT2cK6gotWbWxGnlZUeYf8a4J2Kad6p9M
 5u+BUrFspAvSTrbWCEyqx2hOFuDr+BQM+woY9JPGCRXTr6RiGKSgY7j3VjHXKCjqjj85
 S2HQ==
X-Gm-Message-State: AHQUAua8cLcEI1SXo1DhHgd2dfLq3YNQg0iP1P+IfobJ7gSlFNVmF6cj
 FZ8XvH0F0yXt/M8qGjahKoDc65bng7J8bBuknksuKw==
X-Google-Smtp-Source: AHgI3IYb8LJhQRhIVI26TzfJ67w/xqlvTc+3gkXnE5yBecnvqnvZcxP2WvBIe9AgXAWfLxdyRUzi35oRo/Q5WKujTio=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr7206175otj.228.1550023410006; 
 Tue, 12 Feb 2019 18:03:30 -0800 (PST)
MIME-Version: 1.0
References: <1550005119-25750-1-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550005119-25750-1-git-send-email-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Feb 2019 00:03:18 -0200
Message-ID: <CAOMZO5Ad-T5tB=n6AhMG-f3Lp36gqHBVDs+NZiqWvL4VdVgEQw@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] drivers/perf: imx_ddr: Add ddr performance counter
 support
To: Frank Li <frank.li@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_180331_859578_DB7AD2CF 
X-CRM114-Status: UNSURE (   8.24  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 6:58 PM Frank Li <frank.li@nxp.com> wrote:

> +static int ddr_perf_remove(struct platform_device *pdev)
> +{
> +       struct ddr_pmu *pmu = platform_get_drvdata(pdev);
> +
> +       cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
> +       perf_pmu_unregister(&pmu->pmu);
> +       kfree(pmu);

Since you allocated pmu via devm_kzalloc(), there is no need to call
kfree() here.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
