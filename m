Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30113C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:07:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BB521903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jdLsI/PM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BB521903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IAOpvJdM4VjM+cbv2GtaU4XSfMcovUofntrvIqeAbH0=; b=jdLsI/PM4+mIor
	WbpiNXIe2bjiPMZWycS4IN0B0EIR92T5mQqcxST443uO0DsNrzR9RGDAtsTe5qncTA/shTMVu3Cym
	+7MPnGl+kxAftaoI5onOJE8s6LqNqJ8DAkRgt2/RhfgjY73QJcM6MZQoJsATOgGZCBjb/stxNTx6X
	mgTfa4mNuojF13SKNoDHDpKNiEub9wn/RZ7CCZEtZzvx4VTXpbo1HTZhfzFUIQHCwU4Hme0G2lBAK
	xxIfvTu7unSrmnHGihpKHQRjohQ2D/LqT06GnYjrV7j0snYMR4beiXugapwvhrOSsp9MPSWWTykhC
	IsZcgwnM1MNOTznOACIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaOGd-0006kq-Tr; Fri, 21 Dec 2018 17:07:19 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaOGa-0006jq-Ia
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 17:07:18 +0000
Received: by mail-ed1-f66.google.com with SMTP id y56so5198795edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 09:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3hPsT6hn4cJMGwyqOid1QQE02WRghMsDgsiF8hyM1/I=;
 b=Pgq40JkdD43Q1n+Ifnzgy8ufsbJlliL1mGta+/wmBKt701/isScSktthebj+SpuyWE
 fnp9TX9rIiZztNSGseb3Lhq8B7YNOMrE79uhyaSq3CC3kAnHShlXyK+7X244eRYaJdLB
 MxYIx2NbE7rUIKEQaLNz+wFkhYQ7RuH7ulZbTZHoq0L1b61X+eTCN5G9mxXVeEjzLUSc
 5MnS5Vv8H5+Z1E7HXc4VovYaZz4/0x8A7DZS0IcRvMZg+Ovd+oQOvaGgYtpKMFajhJyX
 OZkdqvef8Z/tmLlqzM+N+jYSqKdsA9Ton7NSJBD4dME1Joxogcmk51SuGMFYJdMr7RS4
 oryg==
X-Gm-Message-State: AA+aEWbhOlBrk7HsFUKCs1l849zvCCHXYzCTbn8iBe0yi5zClOxbhkac
 ZVCsKogKj7ywaxwKCtFbcPDE0DABWlQ=
X-Google-Smtp-Source: AFSGD/WSrEbnTL1Pjk/x7LgwyoXIqB9TDtRegMuhhMNv6/4CEdluUpFhhmIKBnfvx5Tn043sq/RWOA==
X-Received: by 2002:a17:906:1001:: with SMTP id
 1-v6mr2560599ejm.91.1545412024555; 
 Fri, 21 Dec 2018 09:07:04 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44])
 by smtp.gmail.com with ESMTPSA id y17-v6sm3673995ejj.43.2018.12.21.09.07.03
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 09:07:04 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id n190so5969061wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 09:07:03 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr3715562wmc.116.1545412023510; 
 Fri, 21 Dec 2018 09:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-3-codekipper@gmail.com>
In-Reply-To: <20181221152110.17982-3-codekipper@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 22 Dec 2018 01:06:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v67NS8QenKMYSE9DBsCSSbhMDZbsG=agkxxQWUgOtqtMfg@mail.gmail.com>
Message-ID: <CAGb2v67NS8QenKMYSE9DBsCSSbhMDZbsG=agkxxQWUgOtqtMfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] ASoC: sun4i-i2s: Add regmap field to sign extend
 sample
To: Code Kipper <codekipper@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_090716_613754_4A9D748B 
X-CRM114-Status: GOOD (  10.49  )
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "Andrea Venturi \(pers\)" <be17068@iperbole.bo.it>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Mark Brown <broonie@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs this is set by default to transfer a 0 after
> each sample in each slot. Add the regmap field to configure this
> and set it so that it pads the sample with 0s.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

The code matches the description, however I lack the in depth
knowledge to understand the difference.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
