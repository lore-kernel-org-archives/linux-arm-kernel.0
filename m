Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5C9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:41:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDF620873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U2RMF/4c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a4UW5Zk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDF620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hr/JSbTJz+lB8lrhfoO4xY3Tz890jOYarQLmvB1Mn6c=; b=U2RMF/4cnUcAx4
	Xjq2OZL5BQFuCVNTLvbbwKX/dqAPex9FFQEP/rauZIyjPAMHedkBt5AzttY3vfxLRSeTbfRS2M5Y7
	ifsHKgaeMG6lfzfeDHRLGH5K8nZikPsBzwyL0vIXviuDNaHuefb0W1YODEMoqB7Ak7pVCv4EGv0+R
	ImfcdN4AmSPd1Ebn8J8Ju1MBXI4tKIk4e83rO3FuB0zsKC6PJiWL36Gf+v45Gea8FKyIfrmPGwhHc
	VyFAVlziSRjBxvvY2TWR576YK8TAqmNydonFe7CL+JOBvzqLLw920bdNcJwHCDtJ7iCcEttxqWi1j
	SufUQQV7gRovYL4t5eLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZieS-0002TE-Sz; Wed, 19 Dec 2018 20:41:08 +0000
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZieP-0002SX-E9
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 20:41:06 +0000
Received: by mail-vk1-xa43.google.com with SMTP id j23so4810063vke.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 12:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LUjgM4oOk40T3klE6kpKvxcnvoJM5vX5IrI0GyvZdyM=;
 b=a4UW5Zk0k6NDion9D5AGgWwYcEHXajC2Km6cZmd/Yj9fwgvAqQUPRZMJIeLoJCrqkP
 gzpy0k7l2AnpCWfkf8sT5JjWQbrJQ8ya+YWTvVfDSJOk8MkfaTG7vk2NijUyttAOG3tW
 FuMyawnYxebkOVzRv6EdCV61pOHpa25kO5CIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LUjgM4oOk40T3klE6kpKvxcnvoJM5vX5IrI0GyvZdyM=;
 b=ZcXavzi3iuC7kKVHc0BO7gWq5IgxHpO4sR1QvQv/uGuZ+dgv7Kez4t7u4vV0t8d3nD
 JXcmpFrV0EnsKLy6o/Aklko8FQOPpmgqgwJjfHhwIkX5q80a4IduTBYPnH8lYLLqukN3
 JZM+ROuAkKtLqPG8EjXkKQIzwCB54KDBBdsdfBQwzuzFd2t5XgrnpxRUn03EoBSzYR0q
 RqjsLYTUJVDc2MSyWcBalIlnDGqLvFSsa1r/+k0O0Ccd4jszGK3bFCnFLa/Otz0V56ss
 PB/IHLz057axqX8PIqd+YhYlXkbFz8ZyYjRkvC9/amV7h6vyLT7MD2HyoJ0S8q04MPb3
 gSmQ==
X-Gm-Message-State: AA+aEWa0NvyLAO1WK/DLME/eXUmDdCECO4er94vWvbjWa4oJGpUArP1B
 K6H2ePSh8UKw1UmUliOLykDRMBiZqjk=
X-Google-Smtp-Source: AFSGD/W+lCyAIsFsYQH2Ljt/O+YTZ3makPeeePxs3UnzKlhuiN/z5yVB4rrozlDps/JHE9nAj57b7A==
X-Received: by 2002:a1f:60c9:: with SMTP id u192mr9636684vkb.36.1545252053146; 
 Wed, 19 Dec 2018 12:40:53 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com.
 [209.85.217.51])
 by smtp.gmail.com with ESMTPSA id i136sm17829749vka.18.2018.12.19.12.40.51
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 12:40:52 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id n10so909832vso.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 12:40:51 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr11009460vsj.144.1545252051529; 
 Wed, 19 Dec 2018 12:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
 <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
 <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
 <20181217070647.xtvfgsixggua5yod@vireshk-i7>
 <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
 <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
In-Reply-To: <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Dec 2018 12:40:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
Message-ID: <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_124105_479251_47B0D1FF 
X-CRM114-Status: GOOD (  16.04  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, vireshk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Dec 19, 2018 at 12:09 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 18, 2018 at 10:49 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-12-18, 11:05, Doug Anderson wrote:
> > > OK, it's fine with me to have the fallback, but if we do we should be
> > > consistent about it and make sure it's in all the bindings and device
> > > tree files...
> >
> > Sure.
> >
> > I am not sure what's the right way to do it is, i.e. should we keep the
> > "operating-points-v2" string or not.
>
> Does having it buy you anything? Given the QCom one doesn't have any
> frequency or voltage, I don't see how it would be useful to have it.

...but it does have a frequency, doesn't it?

+   compatible = "operating-points-v2-qcom-level";
+
+   opp-710000000 {
+     opp-hz = /bits/ 64 <710000000>;
+     qcom,level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+   };

-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
