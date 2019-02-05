Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66732C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 04:55:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6D320821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 04:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fDmPSFPX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtUrEgaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6D320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sy1b0jALDyYqADe+/AC8pfIp/aZ5nNUuNO+54LNEMF8=; b=fDmPSFPX0L/d0k
	m3HNS+Z7VxCkKww3LmE/1Myh7PZ+oADHElX5CYZBqI3XE0Ltd5qxYCMU+fBAUTqTVMh5srriIWFIj
	VswD1b9U0r5UoiUECKWwq4/othRjyH3FKwi2ibtvC2jb9G9a8i+WJjwjVD4mg1kZrl6Ty2ShQzuuL
	Lr9G5H7r5DyV7w/xW6CkyDpN32Qzcfw+OV1Zcl8MP8M1Yahn7X2Dd/XGsMRDxNyA0VZ6yRqSHemsD
	SzxgMRExjc/bFUzwgiLfaBxlgYjoUc5vi+ZRKnzhJzkVKoe0p4hONS+BBnnJU2KeZGDucIzzzHTf7
	7QP5HDLKABmbrpv8OZYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqslW-0000uS-B9; Tue, 05 Feb 2019 04:55:22 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqslT-0000u2-MY
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 04:55:21 +0000
Received: by mail-pf1-x443.google.com with SMTP id z9so970414pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 20:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Pj29ZP53jXH3k34XhVa5Kv7d7T0KHRmwkYPC25H6maI=;
 b=GtUrEgaZgCXKg6irY0VrzPG+p4ZCyRvQ2NjMRs+NabyR9G6/hUNxjQUlfzI5Mukl6J
 Dzn27FCI4MaunKw8W5WZA2bWzEdXIJJcT/6L66necL5Ypb38D4KxjPBocy6GXPHp2y7g
 ZFEICyBaxiCeq03Iw4xawYbDDUCzIIuoK3msM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Pj29ZP53jXH3k34XhVa5Kv7d7T0KHRmwkYPC25H6maI=;
 b=JvaU1xIqEs+Ou4Rc4ojawGP2tuU3b0eDbM623fSlCvAdLHj3M7znymlnTSZ6LSpPCf
 rJN8zAsFqps9ZS7aC+nrAk6YjWBFKncdtKPhnEhu0GTMS+emvjMQG7GP7lS1ZUZz0w5l
 eL8JY4i1kdU+lmNutu61J80wHx6UG9kCndFXg9Oyk6dFIoxd/Ttbv85oGKNOfmiHjBPG
 RDtGbBg+nI3nMXEuHtMcwmFWsAOmqhrSt2S0+TBaT02i1/OeiZB8Nnd/9gs6+Y3IlkpE
 CeruH3FbLVvXUBXvmR3UHOcW98NQ6k0Wy9QjpUPrVNKUFLFQ00IXpK7329HsQfajUtdv
 vBVw==
X-Gm-Message-State: AHQUAuak8XoMBJ+qCBQWei3utDdEXE9nsP1eRp6y3P76Gmub1u47ZVM8
 yD+nKSkGsCaukq60L1eWIa0sI05yk8k=
X-Google-Smtp-Source: AHgI3IYW1/4douBppUhRF/OoyBCckP25XlC7Is6qmjf7KrqFcvc+4c59iKTrvM+amQbB/u9gHh37ug==
X-Received: by 2002:a62:444b:: with SMTP id r72mr3132836pfa.184.1549342517262; 
 Mon, 04 Feb 2019 20:55:17 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id 184sm2211166pfe.106.2019.02.04.20.55.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 20:55:15 -0800 (PST)
Date: Tue, 5 Feb 2019 10:25:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v4 0/5] Register an Energy Model for Arm reference
 platforms
Message-ID: <20190205045513.p4ljxgsnvmk3fzgw@vireshk-i7>
References: <20190204110952.16025-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190204110952.16025-1-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_205519_774260_AFBB4183 
X-CRM114-Status: GOOD (  15.33  )
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
 linux-kernel@vger.kernel.org, mka@chromium.org, sudeep.holla@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04-02-19, 11:09, Quentin Perret wrote:
> The Energy Model (EM) framework feeds interested subsystems (the
> scheduler/EAS as of now) with power costs provided by drivers. Yet, no
> driver is actually doing that upstream yet. This series updates a set of
> CPUFreq drivers in order to register power costs in the EM framework for
> some of the Arm reference platforms for EAS: Hikey960, Juno and TC2.
> =

> The series is split as follows:
>  - Patch 01 introduces in PM_OPP a helper function which estimates the
>    CPU power using the P=3DCV=B2f equation also used by IPA. It should be
>    noted that this introduces duplicate code with IPA, which will
>    eventually be fixed by migrating IPA to using PM_EM. The ideal plan
>    would be to do so later, in a separate patch series. I would indeed
>    prefer to keep the thermal and CPUFreq discussion separate at this
>    stage, if deemed acceptable.
>  - Patches 02-04 make use of that PM_OPP helper function from the
>    following CPUFreq drivers: cpufreq-dt, scpi-cpufreq and
>    arm_big_little.
>  - Patch 05 modifies the SCMI cpufreq driver to pass the power costs
>    obtained from firmware to PM_EM. This patch is independent from the
>    rest of the series.
> =

> =

> Changes since v3 (20190201093101.31869-1-quentin.perret@arm.com)
>  - Moved the OPP count inside dev_pm_opp_of_register_em() (Matthias,
>    Sudeep)

Applied. Thanks.

-- =

viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
