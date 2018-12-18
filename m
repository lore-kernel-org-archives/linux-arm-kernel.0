Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3629C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:06:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF2121873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="emzUCkFq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AWlNkkpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF2121873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9nmAFZF+OqWuLhsezuSBq6+JfDLuXv6pby+K74Amm4I=; b=emzUCkFq3AsK9B
	H1qFf5odi1N67ASSHcjS18WN8BhZCoHbngqG2XS08YESiwZMeZGOejBr5Uv0hk8jEUBati6JiG9kr
	KhTztO2mnPkFjhAPmP3lD+9Py9gJ1mS2+ITHLpFg/njYgDYlCsVgWHTHQCgI/2i6RuH2PCml2hTAo
	yl/cpybjiGOVD8uYU2A55L14aiD9Js7MtHnKipTnmIgAgGjSvwRkuQnf23P3lYmx/yTRmg4Aq9yD+
	9gEyeaJP5T4oGeGoZ+55PBTuCOlG1FQd3tWiksxkcPz7GAFdGyjN/7NqLFDCk+vlVo21aUBSddP1r
	h2NzTIaxAjlqo03FisSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKgs-0006Cz-Cn; Tue, 18 Dec 2018 19:06:02 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKgp-0005cN-1Y
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 19:06:00 +0000
Received: by mail-vs1-xe42.google.com with SMTP id n13so2750324vsk.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 11:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l8a6FUoyBp4o5VlAyAA7pq4XpUR46f3nh7T2F8iLGhU=;
 b=AWlNkkpglv7IbPSG5iGUOgirWXB8y+J2i+pOPfuVcgLXfnGHUnzxkc1vq8g3MBXW+c
 Id3c/NmaR4gJDBonMBRl+gNADxn6xUG1WV+0qz13KwlrsbkbFx9aCRLOjmzjLc8WbiwK
 fPbPwBSsgcUlx7GtMzlJoKnas7C92OgwxktZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l8a6FUoyBp4o5VlAyAA7pq4XpUR46f3nh7T2F8iLGhU=;
 b=TQ9O1NMiBc3J8Hwd1qyp/rUVgLqkMj2RC7mHe50S5tk0ZR82zUcnyzdQjS3nkw1O79
 jRb2FFfbUiYGpNIi/IeJJMporOKninS23V58n/weWDYVW0TcVfIogVI7rDXCyM4n1xsc
 Tqh4p1EbaX5FUYFz7WSzHTBhYOGuakki03CWdMWFgublkCPFB/1am1z+k1lv0hlAJftx
 EwOidJS+AdBfZpemGalufPD96NVrCbVBa0C94GxHoCyK28O+FQUJVS7XLjHRR9I79/dV
 RRtN+0DRT2iuhBpZJ8+zmDEazJWkzCc43yNr9+z+7zgMAW6aoLzgEdbYMMMAnKrdE4ZF
 otkw==
X-Gm-Message-State: AA+aEWagFr5rEIENOSWSdn9PoCnMkAZyuL1WXSMo47r3CSFwYT30G4N4
 Zxe/0Ko9W4fSWSnXBxREoOOsjnnM+jI=
X-Google-Smtp-Source: AFSGD/Vbe1cezwnNbrqUVQYFgzTfGHqBQcUbRpHFo2kfOefsqJUL7xY9CEDt/wTgpClnTRCCK0w5PA==
X-Received: by 2002:a67:46c8:: with SMTP id a69mr8891484vsg.45.1545159944746; 
 Tue, 18 Dec 2018 11:05:44 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com.
 [209.85.217.48])
 by smtp.gmail.com with ESMTPSA id x132sm5219308vsc.34.2018.12.18.11.05.43
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 11:05:43 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id p74so10700723vsc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 11:05:43 -0800 (PST)
X-Received: by 2002:a67:dd94:: with SMTP id i20mr1836897vsk.111.1545159943079; 
 Tue, 18 Dec 2018 11:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
 <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
 <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
 <20181217070647.xtvfgsixggua5yod@vireshk-i7>
 <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
In-Reply-To: <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Dec 2018 11:05:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
Message-ID: <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_110559_092723_DC24ABFD 
X-CRM114-Status: GOOD (  29.63  )
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
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
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

On Tue, Dec 18, 2018 at 10:40 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Doug Anderson (2018-12-17 16:34:31)
> > Hi,
> >
> > On Sun, Dec 16, 2018 at 11:06 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > +Rob +Stephen,
> > >
> > > On 14-12-18, 09:04, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Thu, Dec 13, 2018 at 8:41 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > On 12-12-18, 14:18, Jordan Crouse wrote:
> > > > > > +                     gpu_opp_table: opp-table {
> > > > > > +                             compatible = "operating-points-v2-qcom-level";
> > > > >
> > > > > I think you need to mention "operating-points-v2" as well here.
> > > >
> > > > Are you saying the above should be:
> > > >   compatible = "operating-points-v2-qcom-level", "operating-points-v2";
> > > >
> > > > If so I'm not sure I agree.
> > >
> > > Well I have my doubts as well on this. This is where the ordering was discussed
> > > earlier:
> > >
> > > https://lore.kernel.org/lkml/152328979897.180276.15963925877442657158@swboyd.mtv.corp.google.com/
> > >
> > > @Rob/Stephen: Should the opp-table node above also have "operating-points-v2"
> > > string in the compatible property ?
> > >
> > > > It's _not_ really compatible with the
> > > > "operating-points-v2" binding.  If you had a driver that had never
> > > > heard of "operating-points-v2-qcom-level" and had only heard of
> > > > "operating-points-v2" and it took a look at this node it would have no
> > > > idea what to do with it.
> > >
> > > Well it will parse everything apart from the qcom,level thing, so it can
> > > actually parse stuff here.
> > >
> > > > I'll also note that other instances posted to the list don't list both:
> > > >
> > > > https://patchwork.kernel.org/patch/10725801/ - RPM / RPMH PD bindings
> > > > https://patchwork.kernel.org/patch/10725793/ - RPMH PD device tree for sdm845
> > > >
> > > > The bindings patch also makes no mention of needing
> > > > "operating-points-v2".  I think the common case when a fallback is
> > > > required it is explicitly called out in the bindings:
> > > >
> > > > https://patchwork.kernel.org/patch/10725803/ - qcom-opp bindings
> > >
> > > Sure, maybe I am wrong but its better to get some clarity on it from Rob/Stephen.
> >
> > In case it helps:
> >
> > https://lkml.kernel.org/r/20181217210849.GA15490@bogus
> >
> > ...shows Rob giving a Reviewed-by with just
> >
> >   compatible = "operating-points-v2-qcom-level";
> >
> > ...and not:
> >
> >   compatible = "operating-points-v2-qcom-level", "operating-points-v2";
> >
>
> I don't see a problem if both compatible strings are there. Does that
> change anything? I suppose the platform bus populate code won't create a
> device for the subnode if it has 'operating-points-v2', so maybe the
> fallback compatible string should be there? And then the generic OPP
> code can parse out the frequency at least without having to know that
> it's a qcom specific OPP table.

OK, it's fine with me to have the fallback, but if we do we should be
consistent about it and make sure it's in all the bindings and device
tree files...

-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
