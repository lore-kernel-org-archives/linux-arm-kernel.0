Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A0AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:07:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAFD217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qOvcsjNf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkG3/mue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAFD217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XXF7AsqUfj9O3D/7F9MRvUowzOO+lAkkDLMzO5buRss=; b=qOvcsjNf9iQuTY
	v3is7CccTlFPYcipLzpvyfISVlzd+puD1O0vHwZp86I6yAfvVy0/0cebjK1C9HWR6MEWwtEK66LuA
	JkBp63ZIPythEDwUIvHFDeqRnOnVP9Xs2wjvvN/KWowuzCJmf1GxtKkKYNnv6RuRR0agdH+9OwX/D
	eQvn+GlqtSWNlkoGsalssnE2viX0cMntlcF08LWeYH3MUyTD7DxceYY823Mvtq+UEHe5KmgugsJNW
	Op1BhbU++USR6sjI+j3Z9MncnC/XePkUgYmCgJjXwZ43KleJA2kr5dbiUiLk7i1P3Fe7JS2RvGa2O
	HeW/m9XNZiqKMtf3aaOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYmzZ-0003Am-EJ; Mon, 17 Dec 2018 07:07:05 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYmzW-00039b-8b
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 07:07:03 +0000
Received: by mail-pf1-x443.google.com with SMTP id 64so5886696pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 23:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=E0u1zLt4ijZJe8ppni4O3OxM0EUfb6IIjgvBUmNbB3I=;
 b=NkG3/muewT0bWM+LTOLEM/H/qVke9Kyb9gSk+KvogJTUliSNFbdSgKIGr8krpx9A6H
 0UYVXJRX5nyvAusjELXhboks6W0ZfajWtUfcojEfRrMStM/zPA5SnovXJla+n2i7fj2L
 ARtzeA/Z5iUptEW7I7SPIHaDwgjlJJ8cSxlxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=E0u1zLt4ijZJe8ppni4O3OxM0EUfb6IIjgvBUmNbB3I=;
 b=GMBzd2tuVpIy+Cx+swjGYjOQr82g5i0kyW8mqUzA7Ue8hmvnPcKSbgI1abHyYRPmlh
 7rtVLJPqjM1biG7HoreCWH4rYwAHyGONiV3fdgUMm7fRMNVbgR7+uGcaH7xpVzQVWD5I
 Ts8oLHb6MTgqjsed1vKmoV7gYzEv3cWyj0SKetd3j3oZPpsgbp/8eTt0x/YAU482qo+h
 j0cXHzRFVaV1xXeiJTrp/Ae5tpjUAQVOGyZ1Z7e3SsSd7FTx9f7ogZJnpEN5e/u5ZQIt
 87RDSbtnAe4VdWXGY1pFzSpMQNyKyuo+naw9tc4BIYNrnyq2UxT6+WyCS1S/r+qLdLnw
 WQeQ==
X-Gm-Message-State: AA+aEWYpJvsT0wk8buU8l5esovwsNrA5PROoFT55bqC4YhUayX+TGksW
 gRcHmdunyPv8ak7VT1ngZ1+LcA==
X-Google-Smtp-Source: AFSGD/U7pQII4Sg3xKHFbk6qetd2vLAHV6qvT3cTASOaNbHkBxd+q66jlUwER7cem24c4s2dozsnyQ==
X-Received: by 2002:a62:7f94:: with SMTP id a142mr11996724pfd.96.1545030410911; 
 Sun, 16 Dec 2018 23:06:50 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id k15sm17926787pfb.147.2018.12.16.23.06.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Dec 2018 23:06:50 -0800 (PST)
Date: Mon, 17 Dec 2018 12:36:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Doug Anderson <dianders@chromium.org>, robh@kernel.org,
	sboyd@kernel.org
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
Message-ID: <20181217070647.xtvfgsixggua5yod@vireshk-i7>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
 <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
 <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_230702_309828_888C8E13 
X-CRM114-Status: GOOD (  18.66  )
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
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+Rob +Stephen,

On 14-12-18, 09:04, Doug Anderson wrote:
> Hi,
> 
> On Thu, Dec 13, 2018 at 8:41 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 12-12-18, 14:18, Jordan Crouse wrote:
> > > +                     gpu_opp_table: opp-table {
> > > +                             compatible = "operating-points-v2-qcom-level";
> >
> > I think you need to mention "operating-points-v2" as well here.
> 
> Are you saying the above should be:
>   compatible = "operating-points-v2-qcom-level", "operating-points-v2";
> 
> If so I'm not sure I agree.

Well I have my doubts as well on this. This is where the ordering was discussed
earlier:

https://lore.kernel.org/lkml/152328979897.180276.15963925877442657158@swboyd.mtv.corp.google.com/

@Rob/Stephen: Should the opp-table node above also have "operating-points-v2"
string in the compatible property ?

> It's _not_ really compatible with the
> "operating-points-v2" binding.  If you had a driver that had never
> heard of "operating-points-v2-qcom-level" and had only heard of
> "operating-points-v2" and it took a look at this node it would have no
> idea what to do with it.

Well it will parse everything apart from the qcom,level thing, so it can
actually parse stuff here.

> I'll also note that other instances posted to the list don't list both:
> 
> https://patchwork.kernel.org/patch/10725801/ - RPM / RPMH PD bindings
> https://patchwork.kernel.org/patch/10725793/ - RPMH PD device tree for sdm845
> 
> The bindings patch also makes no mention of needing
> "operating-points-v2".  I think the common case when a fallback is
> required it is explicitly called out in the bindings:
> 
> https://patchwork.kernel.org/patch/10725803/ - qcom-opp bindings

Sure, maybe I am wrong but its better to get some clarity on it from Rob/Stephen.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
