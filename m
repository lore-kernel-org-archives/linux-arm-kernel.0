Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC91C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:38:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF67020815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X1SYZ9Rr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVm+bgmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF67020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kYUHF/8fTwhEGBZKM4irECPWym5phzPin7GpFK0x05s=; b=X1SYZ9RrGWtQYV
	syQA1oxEgLNT4rcuFzXeWizGP0bgJ+tF1W2jqJpAptIwuJ6RZgOULnbmGlXrpdl9GFEgZqk6nNDEN
	l6uCKIO5tSrV6m03uvt6t3qrunnx5gRtiiBZoJ+D1amFvquCiuOf1hJuaETHtnzOajCP3Pcj3CxER
	7Smrim+5Uzgv+GIIdhyHKg09TOQOZjJC4L/E2Np2IPNjRFZP6F5s8nzL+wuSqOsQVGoEVfpxPk3OX
	wtQd+UpX6JYGmc3vxfB7NuTBiomkJZZ7FvE9U8hHS3SjsuML1wFK0GeHOM5Ip2KnVNxOvv2JLuLLY
	RbkKPfYPslv+KzGP1uHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf0Ob-00060h-2R; Thu, 03 Jan 2019 10:38:37 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf0OX-0005zf-R0
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 10:38:35 +0000
Received: by mail-pg1-x530.google.com with SMTP id z11so15861645pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 02:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zbJC8oznvoWlhWC1pdmFRtt84rPSKGXbCP0A/gGjpLY=;
 b=jVm+bgmDw+dMhdoqMW4nTn1bbyppO7s5apbhgDvoy4u2rDv4nET1hVcFCDzazmk0Ts
 YyuW0w9spf6ELgA7dO5g7kxrmK50h60Salr0EcZq5OAXftKt+21SJACjyqLCMfemRciv
 +aMKZe7UdXa+Y90qryB73mjl5VxJPozqxf7v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zbJC8oznvoWlhWC1pdmFRtt84rPSKGXbCP0A/gGjpLY=;
 b=N3p214mFfCOwW9jfZCUlllx2vwDQHaLXsdFOxFBV0t6jVG8ADKSXdVcxE8rUCDp+Hv
 e+QvjkRHV+kkeNOJlAmjbeW0dYflzy+rt2juVbhpD5hvNE/CxQipTzvsqJfZ7LH6cnmO
 p6lZI9Yft8yIVkfRChlrsBbE99iFBZv/qnAPBmGdbcZuslk9BL2YXdC/A42y8oP8wKor
 TY1b/7gX4G6W1TJzp7iWM2ZHxIR+JpFsZXbxU4KTkPv2bynpgTHrOIkptbKtd90HjXb3
 iFv/nu0/2GA7Qpi4+R4E+SoBPkgQV/wfDc7hZgMgxS10G8ku7+rOff/DQwRaQH/0yfz9
 UotQ==
X-Gm-Message-State: AJcUukeXzTLnBhQ8EAdsC+zVd2bKA3N2QjiylpwBriSnPNfT0oF9Qymm
 7SUQVW6tGUoP1Cc8MC2WknsRPw==
X-Google-Smtp-Source: ALg8bN6CHJAkHgaAlhEiwu88S/eCCydcTHMQAfmZ6bSjP28JKKRLh5FaVVLyxD4tGs2EKknfqhLvww==
X-Received: by 2002:a63:d047:: with SMTP id s7mr44317100pgi.311.1546511912918; 
 Thu, 03 Jan 2019 02:38:32 -0800 (PST)
Received: from localhost ([122.166.131.155])
 by smtp.gmail.com with ESMTPSA id o4sm85031729pgs.12.2019.01.03.02.38.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 02:38:32 -0800 (PST)
Date: Thu, 3 Jan 2019 16:08:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [BUG] dev_pm_opp refcount issue on Arm Juno r0
Message-ID: <20190103103829.2bqxhkpihp4r7x22@vireshk-i7>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <20190103070514.o6yaqvpxouazosnn@vireshk-i7>
 <20190103103318.GA23511@e107155-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190103103318.GA23511@e107155-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_023833_869301_05416A74 
X-CRM114-Status: GOOD (  10.57  )
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
Cc: nm@ti.com, Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Quentin Perret <quentin.perret@arm.com>,
 Douglas Raillard <Douglas.Raillard@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 03-01-19, 10:33, Sudeep Holla wrote:
> As you already state the checks are unnecessary, if we drop them we don't need
> to add any firmware specific callbacks. I am thinking if it makes sense to
> add a generic helper function to remove the OPPs from a device. If we have
> that any driver needing that can use it. The main reason I think helper is
> useful is that we need exactly same fix for SCMI driver too.
> 
> Thoughts ?

Okay, will do that and fix both the drivers as well.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
