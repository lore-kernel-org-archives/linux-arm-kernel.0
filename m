Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:49:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D23B21852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U3sHZrac";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYz0Zyyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D23B21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ALQgqVbF+WGOdEm99WltlQNE57KHkpy+ID3i72uGjE=; b=U3sHZracPjf5Uq
	/oMFg2AddFbUqGJOL7v6wodqDlA/C+Pq1o/UBfOXVt9SZkFmkoU50243N8jZuycv6vkw34OkiP/5B
	j3McS1FDZvv9IwrxHnMr18bRh8NbA55fqZCpDAaR7CQJx0d4vflyE60urUliDgDj7PyVzuDwBbcX9
	YG9rtevMt1hnuA9lNvjSCUw+6Y9pucgZm+2ZTX4LQ4ifec8QwNqY5rH/yWwIFJuzuHpI52QJb4VfW
	V5CNirbCzZoxvyRqO13cFgrhEwSh2mqvEzKHf15FMT3X/JUQB1/lWk4eRsXUiM67/l2mjKefWvdmc
	LKuQsv5FF897UYtGeL4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZTnL-0004BD-9r; Wed, 19 Dec 2018 04:49:19 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZTnH-0004Aa-C0
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 04:49:16 +0000
Received: by mail-pf1-x441.google.com with SMTP id i12so9228796pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 20:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=scGrml26Zf7uVLDIopW/jwNFR9iRLVqffN7zX67JjmE=;
 b=jYz0Zyyx1boERAcfU1fIpHn/i5gAYPEOTxdsGMC6m6b2WxhT+RZSYVlT+tpWrjFjU9
 gV+hFomuEahr9OZmOhSYW2GiadXDQimmMNUt0WBnyXQzvrE1AmqT2QeEhLEaomvwCIlY
 FpJpxL/cvBaPi9piz/AtUAtJtOpIKaM5MJ1e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=scGrml26Zf7uVLDIopW/jwNFR9iRLVqffN7zX67JjmE=;
 b=s/+gAuS7ew0apRZZ6PKIe4Rnlkk5gH0iPjH4biXHU/yk7rATsA8Hwsrq4ix0len1hi
 XpLofAAd8SjabG8kCbjyO4Gqf1r3bQfSkYJpX+JekJQ1rw4AYDvBY4Kfmp51pkDDYuv1
 9k4/4CmrcUnZCamS3pnuvv3UPOBd1KwG3pcKImZfzrW3E1Wv6dHVXeI0X/+nMup5GtVz
 Tc5Pst/YtGoXJatGo1nsgC28qk8OxIWUGhHD5S6zs5bSOm4nLEW6E19uHrRdVVu1VRv6
 tGSqZvln3GYcjSnpkPHN/F6Zz7FfXwQeoOo1EWx1OioPdDtiXXz4lbX1rPxqtRrXZjB9
 lm5Q==
X-Gm-Message-State: AA+aEWYAloJuwjTEH6Zoet3bKp8GeueQq/EkAFUMRBNaD9u9S8R3BNR4
 CLVWmfpX1hCA/OnAw4W1Qi+Fiw==
X-Google-Smtp-Source: AFSGD/WHhzdhk1avQ677TvQ2vYZVMDrGsHLAg6wwPROrLDhG/sECorRcdnbU9HjvTRHntGY4JDlcVw==
X-Received: by 2002:a62:ca05:: with SMTP id n5mr19227786pfg.154.1545194944195; 
 Tue, 18 Dec 2018 20:49:04 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id r76sm26552594pfb.69.2018.12.18.20.49.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 20:49:03 -0800 (PST)
Date: Wed, 19 Dec 2018 10:19:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
Message-ID: <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
 <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
 <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
 <20181217070647.xtvfgsixggua5yod@vireshk-i7>
 <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_204915_409051_3BF75BEF 
X-CRM114-Status: GOOD (  11.04  )
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

On 18-12-18, 11:05, Doug Anderson wrote:
> OK, it's fine with me to have the fallback, but if we do we should be
> consistent about it and make sure it's in all the bindings and device
> tree files...

Sure.

I am not sure what's the right way to do it is, i.e. should we keep the
"operating-points-v2" string or not. Another example I see is (which can be
compared here) is the board specific DT files. Normally the root node's
compatible is a long list of strings like:

compatible = "nvidia,p2371-2180", "nvidia,p2180", "nvidia,tegra210";

which starts from platform-specific string, then mach, then board, etc..

We do keep all of them in those cases and that makes me wonder why the same
shouldn't be done for OPP bindings.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
