Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F2AC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:40:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A712184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pzQ+iwQk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+sahEKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A712184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4eIm/nNnDhCk8nqtZdm4YZO+OH1fO4pennWafF7fFAU=; b=pzQ+iwQkSHqFHY
	ncbCLk6Clu0Hj/TZegbXZIfDsDuPlqwrdFt67cA7xwAtGdaoftnKTCtuPzL6Fzs7KipVz6Y90Pf8Q
	1wz1+ZwblvO5sCe+JgMvnfMDOr/rtAlE5EA4J8OPgv3kxL1zM270+BkRJzYtMyCLAwwEeA1a0+VP6
	pfPrQk5txi4Vba7buBrO0Jut2Zic4Nks6YxViwtsJu/lR8sZq8BV8l7LsD4EbpFxSuESXSVAT9aZj
	ZSJ0Me1JNxrxuvWeKerKUX9mvAJ/ObMp0WhjT2nFQz7vUwcudwcf5RH6pZO2W2rbUPWTktRHKz8mm
	oqD3dWU5ohOki9SwzAxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTcB-0000Dw-QW; Tue, 12 Feb 2019 08:40:27 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTc7-0000DU-Qp
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:40:25 +0000
Received: by mail-lf1-x142.google.com with SMTP id g2so1309837lfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 00:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kapGc7eEnZJS2jJlq3PavBS0KtBWSH5wGVqr3Ma7PVk=;
 b=C+sahEKzHhNuyY3MtTs3y8VQ7S2IAG+/hRaY3fG2nsqyB5dn7ABC3WFOi8wStHv3yP
 Pqb3+RipqGW0NiCojzGsu/zOL8kzmgBWgF9cMKmMfkmfNWt0nBifx0dH7CMcxf7xlico
 sTy5S+AaQQw0gAmwC9lwp9N29VPzzGGTpNgbkXvVoAewBMpcYbjsTYl3XlwZZoPCDdPg
 L8QhyC0RKUkfyvs/u2CR9HhV5hCMkyAe86BUAj2zW4nYYOQUniI0kkO+nCzLgsMSj7E5
 3LEdyHf1rmtv5U2O9tCjhl3ekcEXHYj0r9etFfxK1baQfOEx7ukvTSmxASzu40aDxXYN
 DMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kapGc7eEnZJS2jJlq3PavBS0KtBWSH5wGVqr3Ma7PVk=;
 b=s+2ygDO4gCQ9a4INQQJYeEZETnfm4P+ZIJhq8kRCq3gUrVZatZ1fDkeRI04JF+jk5i
 4qVHPPWDo5VdvgezRAkw6gqe9Vcpi2FRhHr1KO7UM+MkOkT0EOMzVEgV3vM3yUpREsqk
 f5ufmGX3TWI64ub0plZScmt60Vo8SqKjR0JJIJqa2x9ErNodhhjAPOs5heRXZSx48Yy8
 yFyjR6BAKboF/avnlluQsZC8tI+Dsc9V54HWkMyCZcMv0aEfk0IYXpBvuoTt531MHvbm
 SxsIShK/PeI9AKDb1m6Nz3PJ8oojv0aDfDugonMMbxARL3B4J6hu0RbCfwIznxPsyjTg
 zIbA==
X-Gm-Message-State: AHQUAuaEFEgAw5wMYsU1QqbsNJ5bHSqYpBm5SD8QZXK4bkdvqfIEn59W
 o1WISBB1sMxPn736ce8sjRIrAcqTbPstjRbvFq3phQ==
X-Google-Smtp-Source: AHgI3IZ8z4QC8e7jHotvOMuIrTXc2Rlv1WBYvpBmt3BX2+0iUCQ0UEorBo18AIH3L+tnGeYhYmjSxBCLqxlYBJLmmac=
X-Received: by 2002:ac2:42c5:: with SMTP id n5mr1603960lfl.115.1549960821979; 
 Tue, 12 Feb 2019 00:40:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548052878.git.baolin.wang@linaro.org>
 <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
 <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com>
 <20190201130519.GH20797@sirena.org.uk>
In-Reply-To: <20190201130519.GH20797@sirena.org.uk>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 12 Feb 2019 16:40:10 +0800
Message-ID: <CAMz4kuJdPts31Ak-H=VAivvoqqPtxO5M1RdqrNPwTLT5d1h_7w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
To: Mark Brown <broonie@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_004023_995022_A00CE499 
X-CRM114-Status: GOOD (  14.26  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Lyra Zhang <zhang.lyra@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mark,

Sorry for late reply.

On Fri, 1 Feb 2019 at 21:05, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Feb 01, 2019 at 08:05:30PM +0800, Baolin Wang wrote:
>
> > On Spreadtrum platform, we use one mfd driver [1] to populate the
> > SC27XX series PMICs including SC2731, SC2721, SC2720 and SC2730. So we
> > use sc27xx to be compatible with different PMICs' devices, otherwise
> > it will be difficult to define the mfd cell arrays in mfd driver. Do
> > you have any good suggestion? Thanks.
>
> You can just list all the individual device names in the of_match_table
> for the MFD and then it can bind to any of them.  You can always map
> them onto the same behaviour in the MFD driver if they are identical
> from a software point of view.

If I understood correctly, as you suggested, we should add new
mfd_cell groups to list all different PMICs' device names. Something
like:

static const struct mfd_cell sprd_pmic_sc2731_devs[] = {
{
.name = "sc27xx-wdt",
.of_compatible = "sprd,sc2731-wdt",
}, {
.name = "sc27xx-rtc",
.of_compatible = "sprd,sc2731-rtc",
}, {
.name = "sc27xx-charger",
.of_compatible = "sprd,sc2731-charger",
},  {
.name = "sc27xx-fast-chg",
.of_compatible = "sprd,sc2731-fast-chg",
}, {
.name = "sc27xx-typec",
.of_compatible = "sprd,sc2731-typec",
}, {
.name = "sc27xx-eic",
.of_compatible = "sprd,sc2731-eic",
},

.......

};

static const struct mfd_cell sprd_pmic_sc2730_devs[] = {
{
.name = "sc27xx-wdt",
.of_compatible = "sprd,sc2730-wdt",
}, {
.name = "sc27xx-rtc",
.of_compatible = "sprd,sc2730-rtc",
}, {
.name = "sc27xx-charger",
.of_compatible = "sprd,sc2730-charger",
},  {
.name = "sc27xx-fast-chg",
.of_compatible = "sprd,sc2730-fast-chg",
}, {
.name = "sc27xx-typec",
.of_compatible = "sprd,sc2730-typec",
}, {
.name = "sc27xx-eic",
.of_compatible = "sprd,sc2730-eic",
},

.......

};

......

But from my point, they are just some meaningless duplication, and
will waste lots of code there.

-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
