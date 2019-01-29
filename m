Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E393BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABE7214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KLn25UvR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aoq3/Eks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABE7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZBi79MRStrZmPrceTNmzyzhYgBzqXj74HnUn10tfeiY=; b=KLn25UvRTxr6I/
	sfTRRdqCSxnfaYoRfsWujkv3MzHdK9EltO65w9YEy7oqRq/PqLvF4MtkO9WwKDqTVZmYZ2vaUqZtT
	4Ch/cUMoBIM1sbVYSR2a4LmPSFyebTbJH2NReBm63FX4U+yqSae4y7Nhsdda4Vhy5mFF1GlOXSYVY
	e0OgO1jRMA20b9hovKyVcJIrvARpKPmadG7gccou6hS4+TVpuHp+n1f5kmXZPH4c2gkgMN63Wwufo
	nUh3GCzdJK8o5zpvdG2cQ6ggzRPkL6O97N/+19AONbKWiz3ZaWS+ROWNbzjaEwVwG0IBE0LAO09TT
	g7MPrbcA4Mzhvv1L12Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOy2-0007Rw-IK; Tue, 29 Jan 2019 08:42:02 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOxz-0007RZ-Db
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:42:00 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c5011d70000>; Tue, 29 Jan 2019 00:41:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 29 Jan 2019 00:41:58 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 29 Jan 2019 00:41:58 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 29 Jan 2019 08:41:57 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
 id C71E342960; Tue, 29 Jan 2019 10:41:55 +0200 (EET)
Date: Tue, 29 Jan 2019 10:41:55 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V2 2/6] clocksource: tegra: add Tegra210 timer driver
Message-ID: <20190129084155.GX7714@pdeschrijver-desktop.Nvidia.com>
References: <20190128091815.7040-1-josephl@nvidia.com>
 <20190128091815.7040-3-josephl@nvidia.com>
 <20190128150908.GB31317@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190128150908.GB31317@ulmo>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548751319; bh=18ujcK4X8+ABSQsap+FuXCbW+XgBeYw4vdjXGHfSnGE=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
 b=aoq3/EksUH7+w14UrUvym6zauD2YE+vHsZ3WM9/os19lJiT2UbwMf4gO/qtWv2kUf
 n5KPwWv7XxgBicmvYadP+6bbhKaxiVysWjJGHQ0E3hMSSZWon7DPhO5YfEqvulu7Uw
 SWrkYn/O/NTIrbCD4ixwi2KbvhEj4EFn9UhswrbPQt9JULphGGmxOwKEORsIYliLDn
 0cBeM2f0nTZjFzsqCE8VKQnZIbOfNZwOwPFFkom7+99tXlgfSgJISdg4+ohBfaNNx5
 onJnCrGOrlrB6LYB5IKqj3s80S6U0MlBHZeN2qvTGMia9ZwcpbbCXCtfDgtE5oTu3O
 tCbWS5mz9MjNg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_004159_502973_295AD288 
X-CRM114-Status: UNSURE (   9.55  )
X-CRM114-Notice: Please train this message.
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
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Joseph Lo <josephl@nvidia.com>,
 linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 04:09:08PM +0100, Thierry Reding wrote:

...

> 
> Up to here this is a duplicate of timer-tegra20.c. And a lot of
> tegra210_timer_init() is the same as tegra20_timer_init() as well. Can't
> we unify the two drivers instead?
> 
> The power cycle restrictions of the architected timer, do they not apply
> to chips earlier than Tegra210 either? So don't we need all of these
> additional features on the timer-tegra20.c driver as well? If so that

No. Chips prior to Tegra114 do not have an arch timer and the arch timer
does work correctly on Cortex-A15 so Tegra114 and Tegra124 can use it.
It's broken on Cortex-A57 though, so we can't use it as a wakeup source
on Tegra210.

Peter.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
