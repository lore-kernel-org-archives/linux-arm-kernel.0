Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC03C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:22:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2882C218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kB0hZ1/B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArXC18Mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2882C218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3TTr+FAnVQ+E7ntcLjrIYy+XsRZwcGZIuRWWj/KRNGI=; b=kB0hZ1/B8Hi9Qt
	LQb66cNomIoOH6D0aHmjl24WSPAkDI8cc0bKsPKrWzc+r7kLtQY7oB5z8TNT/VsDOEde8gBMV68+7
	hWZ8V5iJXcu7j0bqmtmbPkfAHpsPif3kf4xucc0QjYr9H3LkeNzWkpW2w1rbkOPyKS0Pxj/eHg8rV
	LN1bt+IGnbK/2m3CCSTAgIIMg12wipVQtoVxjQKjeYLscy4OGwxPsWIkx98B9BhQv6zZclfoYjVV5
	yQzIl9NQeO4AJjRZsu3RSODM2eLL9D9SwQfAZthY6iai60iG9YOYov2j0T75yM37sk8QE9GlxlAbm
	HHXwFydfTA/hg4/WTZqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp6fy-00052K-Ca; Thu, 31 Jan 2019 07:22:18 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp6fu-00051s-MM
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 07:22:15 +0000
Received: by mail-pl1-x643.google.com with SMTP id b5so1095675plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7vVl+lLcWQpKtbwDrqxfRh34Za3XoEN0DnU0jE/RFY0=;
 b=ArXC18Mu0+uRBs5/VHHNkVmIvr+XR4U+2TLYANFrRzhaXZMBS0zN7obb5lr03S4kTC
 26rX//ASmC03SY5wRbgyD9yrxIXh0ZNooD9cUw0/tFVW+N3KsmtiZfhPUYYDgV3UQlzc
 MHLGxHIxtvGDuwf4w7kgpSuxn8/Kt9VbSlpkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7vVl+lLcWQpKtbwDrqxfRh34Za3XoEN0DnU0jE/RFY0=;
 b=K4TaRf+CFPuXm+trODrtNRXGS6Y/K/84Tg2ldef2vDj1IYWMu8vk/ag1uQJeIPpCCT
 tIm43Gf9mO38BjXjaBNYZCWyG/9gEkUrEv48OFEou5bzJVdxhhM6ucKiae6eR0y3xzYn
 r2G7sLhun1eeHRIRFGLEjQOtnB/k363pCffPfFoLLbwg2619QME6hFDKNeOhQT+EH4xr
 /+0z6MpPeOlFwJeHf9/d514uup58atc+GYhMBf/erLZEDSovxdUX42qHnmPNhWeyjdsa
 youtUHXSXaKmCJ3Ap4hXgYjpDBmT/0v8ZB/g8oxPtkFIncN9AHlbTVs1/1DK3rp7NXV4
 LNWQ==
X-Gm-Message-State: AJcUukfy9+myfmaudjK73OqiKo6qZAhSb1jvjY0T7UD68Ps6I2sD8KY3
 OE2ATWc5XQhluAwWBQEmTbHpaw==
X-Google-Smtp-Source: ALg8bN5plNepkLA3iyEjfxM/iCvuVR1MYLneESjJvoV2icC7HjSzSu2MtouMhfXr+UrBBAOewTHHbw==
X-Received: by 2002:a17:902:8607:: with SMTP id
 f7mr32815399plo.123.1548919333636; 
 Wed, 30 Jan 2019 23:22:13 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id m67sm5427287pfm.73.2019.01.30.23.22.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 23:22:11 -0800 (PST)
Date: Thu, 31 Jan 2019 12:52:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190131072209.nhbgid3cystvr2p5@vireshk-i7>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
 <20190130190703.GM81583@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130190703.GM81583@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_232214_745137_8875669E 
X-CRM114-Status: GOOD (  10.22  )
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
Cc: nm@ti.com, linux-pm@vger.kernel.org, sboyd@kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
 sudeep.holla@arm.com, dietmar.eggemann@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 30-01-19, 11:07, Matthias Kaehlcke wrote:
> On Wed, Jan 30, 2019 at 05:05:02PM +0000, Quentin Perret wrote:
> > +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> > +					 int cpu)
> 
> why __maybe_unused?

Yeah, it isn't required I think. He probably added it for the case
where CONFIG_ENERGY_MODEL=n, but even then an inline routine is
defined which will accept it as argument and wouldn't do anything with
it. Had it been a macro, we would have required __maybe_unused but not
now.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
