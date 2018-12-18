Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D2EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:35:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5764920874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kqsd94fG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AEowOSeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5764920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kgE4nK7nFkCw5SixxNlYdW3DcON8aYo39ItM8OBrBm0=; b=Kqsd94fGVRbZ8i
	X7cC8mhDF3NpCpcFS2wK76G6OFcfo44nwCF9/gyio9FHJn8hya4/G5ov+S1lMhU5N5ENieCRt7b7i
	QEv/GtuYEOcMFvJzZg0eTCefNkbxaKKL6UhXHlezBvXEQG0mYlfmJT4uKokYIVYvm3tZbblVVskzo
	/uepOn++VR17LmZdCpLv1RLXz0t6aUkwdmnS5rQrdIJXdGXeg4amN5K6jrHljdxZgnEbcP66Qxhvh
	M/CzdWDqqYga+ximoJGqMkrNfsEnROa4hPgNVfJd/sJcozOd0lqWjTf94fX7sRPJQcOUlEbiggc0O
	WTuVEA66p1C2ldAMNKcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ3Lk-00021J-6w; Tue, 18 Dec 2018 00:35:04 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ3Lf-0001k8-6h
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 00:35:01 +0000
Received: by mail-ua1-x944.google.com with SMTP id v24so5095390uap.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 16:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4ViNA14YSi6FjM+y573Zt463AUIJP5xPpmEwoep9i3A=;
 b=AEowOSeDKrVGmWXdPvTJ72NTlCNi3Jg2gBSy1WrUoOgBERV+mfAxC+tOo/Uqq+EVva
 fwoGEIClB8oGY2qEF7MzpjYepqU69B9IpEBACrPNXucTNGejIpBjOaQWPqg7eSJRe6ah
 g6QfRhMkOekJxtiPior1bDVODIvyZKaBqh8v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4ViNA14YSi6FjM+y573Zt463AUIJP5xPpmEwoep9i3A=;
 b=jbZQr4ZRVNzVAyn9jhTFF0BZlkaCZcvLspSCBtgXFzm8KGOjuAdHhRigOCBylI+uf2
 jdIsKLgZcrMHi93lmZnbYB/6CAObijwt5cko1UwWt64B+1x/WUu3tH1RZAzcDSr4GrAX
 SBOCjfBsnolgLul7E+HXWNiTN88LhY6/9J8gBOA2BCq2r4UkITa1XahRvlfSqPmIKiWk
 dwzW3/TupijAI0iWg4B7xi/qxuBNufHHnJ2a+fI32V+t604pRTfjbAzsAqSTdJDXI71V
 MAvRqP5wafo3SL9mVllwOB2tcc9LB4iXc5zbh//AQht4Ie++om/E+4Xm7/b4YDFbPPzM
 q7nw==
X-Gm-Message-State: AA+aEWZm3PEvRMfRYQqgPgT3SvKk70Sgqx0Svh/P+jdEy61wuVwBL5/5
 MC/ck07t7dg5J0Hk486bRxB6Yo91n6U=
X-Google-Smtp-Source: AFSGD/WF7bFL8diEljNrt+jzX1ikvsPCqUXeLtUD4EQoZJ5ct7ReITshIHf0v9j4HELSS3fJPcrZrQ==
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr7485949uan.107.1545093286062; 
 Mon, 17 Dec 2018 16:34:46 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com.
 [209.85.222.49])
 by smtp.gmail.com with ESMTPSA id g14sm4221787uah.10.2018.12.17.16.34.44
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 16:34:45 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id u19so5118527uae.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 16:34:44 -0800 (PST)
X-Received: by 2002:ab0:146b:: with SMTP id c40mr6928521uae.9.1545093284361;
 Mon, 17 Dec 2018 16:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
 <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
 <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
 <20181217070647.xtvfgsixggua5yod@vireshk-i7>
In-Reply-To: <20181217070647.xtvfgsixggua5yod@vireshk-i7>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 17 Dec 2018 16:34:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
Message-ID: <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Viresh Kumar <viresh.kumar@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_163459_441588_70537C5D 
X-CRM114-Status: GOOD (  22.91  )
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
Cc: Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 linux-pm@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Sun, Dec 16, 2018 at 11:06 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> +Rob +Stephen,
>
> On 14-12-18, 09:04, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Dec 13, 2018 at 8:41 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 12-12-18, 14:18, Jordan Crouse wrote:
> > > > +                     gpu_opp_table: opp-table {
> > > > +                             compatible = "operating-points-v2-qcom-level";
> > >
> > > I think you need to mention "operating-points-v2" as well here.
> >
> > Are you saying the above should be:
> >   compatible = "operating-points-v2-qcom-level", "operating-points-v2";
> >
> > If so I'm not sure I agree.
>
> Well I have my doubts as well on this. This is where the ordering was discussed
> earlier:
>
> https://lore.kernel.org/lkml/152328979897.180276.15963925877442657158@swboyd.mtv.corp.google.com/
>
> @Rob/Stephen: Should the opp-table node above also have "operating-points-v2"
> string in the compatible property ?
>
> > It's _not_ really compatible with the
> > "operating-points-v2" binding.  If you had a driver that had never
> > heard of "operating-points-v2-qcom-level" and had only heard of
> > "operating-points-v2" and it took a look at this node it would have no
> > idea what to do with it.
>
> Well it will parse everything apart from the qcom,level thing, so it can
> actually parse stuff here.
>
> > I'll also note that other instances posted to the list don't list both:
> >
> > https://patchwork.kernel.org/patch/10725801/ - RPM / RPMH PD bindings
> > https://patchwork.kernel.org/patch/10725793/ - RPMH PD device tree for sdm845
> >
> > The bindings patch also makes no mention of needing
> > "operating-points-v2".  I think the common case when a fallback is
> > required it is explicitly called out in the bindings:
> >
> > https://patchwork.kernel.org/patch/10725803/ - qcom-opp bindings
>
> Sure, maybe I am wrong but its better to get some clarity on it from Rob/Stephen.

In case it helps:

https://lkml.kernel.org/r/20181217210849.GA15490@bogus

...shows Rob giving a Reviewed-by with just

  compatible = "operating-points-v2-qcom-level";

...and not:

  compatible = "operating-points-v2-qcom-level", "operating-points-v2";


-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
