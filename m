Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D756CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:04:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F818206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bw0BfZQY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hSeZE9k0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F818206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pJW43KtK18I793rywLdHxzZyRDkeqoLOcuDTqVwKChY=; b=Bw0BfZQYqesmr/
	ke5ANBvhAH3uJLUgDw/jladxVhVJrEWIzczV5Why6hIAlvxuzqshDTCEzv5KYBGG/ZluvRGWrM8GZ
	cRGte3RPLd/+HY+8SIcSNWX6mHoEJcEkAwjV5SRXXdT+FyASvycpX2qBe+Dac0DTwhk1u5X8crtPp
	i5/Dgh0rNBCA9iD9rtIdm0eoN9Y6gZIOcUQ4fRihqVdWA3hdb9iEllYRoBecgmxEJkUj1PbU6Jq5c
	iNonBdvG3h9us31/2Z45NWoOmVhgO+H5rMe1J0tTuTd9O3xoHBbm57ky30V0ZY0k9cCIXPvFAKuAs
	ekM1E3nT2yjtuRayS43A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXqtF-0005Vk-4Y; Fri, 14 Dec 2018 17:04:41 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXqtB-0005Ci-7F
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 17:04:38 +0000
Received: by mail-vs1-xe41.google.com with SMTP id v205so3795839vsc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 09:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1F/w/Az1TCUyS4Jd+NbUbkNpxxYjLPVkT4uw4JQuYCk=;
 b=hSeZE9k0AbFPFySZD6Tw876JJwLdDZaYefU/llcQgKyVowWdq1vRgiEOg++N+VO05J
 CMcJNsA6Fgtnv0DztYf/uEnklb6IZ1lUmYUNihkh77a/5xAFx1NxRSIl+SA0iKfJ/Uia
 l1zGukj5/4l+JkCcg2JKrrt3j16l4Tf5bTEDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1F/w/Az1TCUyS4Jd+NbUbkNpxxYjLPVkT4uw4JQuYCk=;
 b=M4q7ELPwdVYjAYrEGFQUeFwa7+r1CLkonWbZGogtfJ3XQnCQJYu+f25EyXmQqnjmYg
 6mipTqaRR5RxJnkJfoADCWrC/0Z+MprR4303DzqrenONeMdccpCKbrja9u2pWWCh4QIm
 nIKvZzR1cMxFw8wJgSi5UBOVuAFwFst0Hz99Ha1mRrJBMzHp4n9D/sodBNECR2PUjHcY
 E69+TNHAnfabvaoYUVbLivP2X0bGqsdnOjYyEgGRnxHlmNq1eJjqYCGW98/0l4NekWrS
 PeQrfeI0wFOukJTZtG1j8MPK6p/whRxEEls3c8l/vCzpG7oeTKsjHFg1yKvmRDATdSWl
 rTAQ==
X-Gm-Message-State: AA+aEWbTFCZ/59QARQ0Gp5mlPueLykEPBAz7i/AecDI5q+isr0zye+vb
 GNlSsH6AG7dT9P1m8WJl507CDSOamd8=
X-Google-Smtp-Source: AFSGD/UoBJDbm1p7KCqwMFNF5bDHhaFG8i6w/GuYe+m/nySdr67waWpA9o6htFJHOdq5cM7c4AlrVQ==
X-Received: by 2002:a67:3ad6:: with SMTP id g83mr1708783vsi.120.1544807063829; 
 Fri, 14 Dec 2018 09:04:23 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com.
 [209.85.217.42])
 by smtp.gmail.com with ESMTPSA id j82sm1572804vsd.23.2018.12.14.09.04.22
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 09:04:22 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id p74so3801516vsc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 09:04:22 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr1536039vsv.20.1544807061720;
 Fri, 14 Dec 2018 09:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
 <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
In-Reply-To: <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Dec 2018 09:04:07 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
Message-ID: <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Viresh Kumar <viresh.kumar@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_090437_261782_1A37BAA4 
X-CRM114-Status: GOOD (  12.93  )
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

Hi,

On Thu, Dec 13, 2018 at 8:41 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-12-18, 14:18, Jordan Crouse wrote:
> > +                     gpu_opp_table: opp-table {
> > +                             compatible = "operating-points-v2-qcom-level";
>
> I think you need to mention "operating-points-v2" as well here.

Are you saying the above should be:
  compatible = "operating-points-v2-qcom-level", "operating-points-v2";

If so I'm not sure I agree.  It's _not_ really compatible with the
"operating-points-v2" binding.  If you had a driver that had never
heard of "operating-points-v2-qcom-level" and had only heard of
"operating-points-v2" and it took a look at this node it would have no
idea what to do with it.

I'll also note that other instances posted to the list don't list both:

https://patchwork.kernel.org/patch/10725801/ - RPM / RPMH PD bindings
https://patchwork.kernel.org/patch/10725793/ - RPMH PD device tree for sdm845

The bindings patch also makes no mention of needing
"operating-points-v2".  I think the common case when a fallback is
required it is explicitly called out in the bindings:

https://patchwork.kernel.org/patch/10725803/ - qcom-opp bindings


-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
