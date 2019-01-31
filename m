Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD23C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:01:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A808207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Snys99zU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Qg2fhbC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A808207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1VrL+IWEov16qjiA8DKe0HjzhM3o5g1xrgK+KTtw5Ho=; b=Snys99zUKK12g6
	ZFM+XncqK5KN/q0VjuOnIednwgZLuKr44NqUB+Orl0JgM4sKtnQJuSA6YgLFWUwxBy0d0JSxpp+5T
	npgk6Wk08XiAwpCMdZhY9TDQClgRRyaQ8Fkq7yPHGu7nEmt27ubKBlST9+5yGyijOX7tmuMjkWxEf
	7h7tfTuhjFPLcXk9TtoLLV+X9H0x/7eeKFWEoai7qOEXr0Xjj3ElEdmRNs3SoL/IfPhpfiomPKlGg
	A4RoY9TdSck8881xctitoYn/VYgZjIkh/E48QH3TmtXwdPEsw/9Y6fTaFtqohNwrRdHqCxEkj22Sy
	7+Jxp3DKSvZsEnc9yzFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp8Dp-0002UO-JB; Thu, 31 Jan 2019 09:01:21 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8Dl-0002TL-WA
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 09:01:20 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c52b95f0000>; Thu, 31 Jan 2019 01:01:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 01:01:17 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 01:01:17 -0800
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 09:01:16 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
 id 69C964197C; Thu, 31 Jan 2019 11:01:14 +0200 (EET)
Date: Thu, 31 Jan 2019 11:01:14 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V2 2/6] clocksource: tegra: add Tegra210 timer driver
Message-ID: <20190131090114.GZ7714@pdeschrijver-desktop.Nvidia.com>
References: <20190128091815.7040-1-josephl@nvidia.com>
 <20190128091815.7040-3-josephl@nvidia.com>
 <20190128150908.GB31317@ulmo>
 <20190129084155.GX7714@pdeschrijver-desktop.Nvidia.com>
 <20190129102912.GC28850@ulmo>
 <8d5b6a61-8fb8-2f83-5378-9b1a1e5bd03d@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d5b6a61-8fb8-2f83-5378-9b1a1e5bd03d@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548925279; bh=HtN3DGYlflCHFOl7WE+ocafJmSJEbCEg17DDUDX5mfk=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
 b=Qg2fhbC+Mxg+ehN8AJkZnN9hCefruXjO0WHnO0jviodQtdqPZKqFE1CLiH2thRhMs
 0EzsjhDsUk6HqO1yAqvZy5arNVBqrTzLw9xA7SwwCer/E6oOj2fWqZmTpQffTuZxHa
 LvDX4nQuqgZwb8AQPVJAuj44D32Fr6yHhYfOk2GQk5JdC5bUJSG//3BhA2qFnPgs6c
 jWKhDdI4C0uVkjGrcGAjbsGcyTdTfMxw5bQHHollfpbrIA/AHkB1ZAjhNdqxUoXqNZ
 n9ix2sJ0cx9tAPIXv2gWDXJL+j+Zk6rpiiV4kRKy6hEVz5dwM13c+lYKU7xUSo8qBQ
 tKnN9x0Ry9vWw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_010118_051403_3763B2FB 
X-CRM114-Status: GOOD (  19.28  )
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
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:40:06AM +0800, Joseph Lo wrote:
> On 1/29/19 6:29 PM, Thierry Reding wrote:
> > On Tue, Jan 29, 2019 at 10:41:55AM +0200, Peter De Schrijver wrote:
> > > On Mon, Jan 28, 2019 at 04:09:08PM +0100, Thierry Reding wrote:
> > > 
> > > ...
> > > 
> > > > 
> > > > Up to here this is a duplicate of timer-tegra20.c. And a lot of
> > > > tegra210_timer_init() is the same as tegra20_timer_init() as well. Can't
> > > > we unify the two drivers instead?
> > > > 
> > > > The power cycle restrictions of the architected timer, do they not apply
> > > > to chips earlier than Tegra210 either? So don't we need all of these
> > > > additional features on the timer-tegra20.c driver as well? If so that
> > > 
> > > No. Chips prior to Tegra114 do not have an arch timer and the arch timer
> > > does work correctly on Cortex-A15 so Tegra114 and Tegra124 can use it.
> > > It's broken on Cortex-A57 though, so we can't use it as a wakeup source
> > > on Tegra210.
> > 
> > If chips prior to Tegra114 don't have an architected timer, then we
> > can't remove the timer-tegra20 driver, because we still need it on
> > Tegra20 and Tegra30, right?
> > 
> 
> For Tegra20/30, it's Cortext-A9 with TWD timer. (arch/arm/kernel/smp_twd.c)
> 
> Originally, I thought the functionality of timer-tegra20 would be fully
> replaced by TWD timer driver. But from the log in the kernelci test
> farm[1][2], it looks to me the timer-tegra20 driver still works as
> clocksource driver for Tegra20/30. I cannot confirm if the clock event
> device has been replaced by TWD timer in the log. It could be replaced in
> the background. And by looking into the driver, it should be.

The TWD timer runs from the CPU clock so its frequency changes with
CPU DVFS. That makes it difficult to use.

Peter.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
