Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35415C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:37:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B36217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JQM3EZTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B36217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g2Msyomqr2PCO3BV1R6ToBi6EBneZZaoE8+jH+ETh80=; b=JQM3EZTroqtRf2
	8RKIZamEzl9CU9lRIIyj1YWJMk4h2yXkJiyXDaqP5Jb52jLFbB2regmM1j3/ubFf6uBv8/qdlhH2P
	lh35UI76FEUlilFxux5Spfr4+2FrAv7RgwNdAFP3A5vz89HU5rX410pRL/dkZ9MxhNE3GNzLMgkmJ
	fn21e+MGhONApjZG41vra8vejD2feyPuyo4WGBCJaxIUCjQ0JOcFIBS/9d8adRkW9ERGhtnknhaUJ
	0gSBU7XKlX6wTar6r2U10JXaUEI65aPqaV5rzSkMtJZVOvVqydKFpcypgSIVMW2DaOyJdrWR4JLvw
	PSYRPdLf/TOnLeKJJKXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBp3-00038m-SH; Tue, 18 Dec 2018 09:37:53 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBp0-00037N-Va
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:37:52 +0000
Received: by mail-oi1-f195.google.com with SMTP id w13so1416941oiw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 01:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NtEbTZIVa3HtZubsN6gQw/OvUX1eel6J+S3vlFJZdMA=;
 b=pQkP3OCQry5U1do0AUY90oEnhHIQWqJuxZjTMtXNmwYeVauFD+V3nSAvfLY1x8mngl
 Lr5v3BViHA/e+Es1WioP+dBpt0rfKShAXGsBN8ILKPnFZkz37tS0/LotiYonvHPVFwwp
 ngbbmPz05vnHJqFN8LsYhE+dOafepvGAaMvbjQ8umNRmGl6k9mftsQzk56tcBl4UQ9qE
 pcg1dLSxGtXJAFiWUKm4vJ/bFPWi8F3U1NcO2h+2xST87AoJHQLB26zSQgkP3TrwsC4n
 xhJvZMiPP1zq4pOWrVyLNum8R7guSv7UjQKr6oXhFrLJ0sqP1tkcOt5/ZAlpnThKrJ/7
 db3Q==
X-Gm-Message-State: AA+aEWarW7LgTYDXVzbb+42Ix2BwF6zDFr1W+WUfci+yA2QWANbXIs7j
 bL0brMaoYutCJRNzABUqCNwFBMm8X9GjRwU+mIw=
X-Google-Smtp-Source: AFSGD/UAgt+i+CCX/hSPt2IZPUFnCkHDZdPdmfTJn1PefSS/ZauMF3UUjgctFFr3j5ZFu/KuogslbboVLDWygfW0K44=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr7705258oia.95.1545125859261; 
 Tue, 18 Dec 2018 01:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-12-josephl@nvidia.com>
In-Reply-To: <20181218091232.23532-12-josephl@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Dec 2018 10:37:27 +0100
Message-ID: <CAJZ5v0h0n2AXERvXFX_dQWMUw_89ap_LgB6dUK0ThJgZ+unkkQ@mail.gmail.com>
Subject: Re: [PATCH V3 11/20] cpufreq: tegra124: do not handle the CPU rail
To: josephl@nvidia.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_013751_019789_CAFA7E10 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 10:13 AM Joseph Lo <josephl@nvidia.com> wrote:
>
> The Tegra124 cpufreq driver has no information to handle the Vdd-CPU
> rail. So this driver shouldn't handle for the CPU clock switching from
> DFLL to other PLL clocks. It was designed to work on DFLL clock only,
> which handle the frequency/voltage scaling in the background.
>
> This patch removes the driver dependency of the CPU rail, as well as not
> allow it to be built as a module and remove the removal function. So it
> can keep working on DFLL clock.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I'm assuming that this entire series will go in via arm-soc, so I
won't be picking up the cpufreq patches from it.

Please let me know if that is not what you want.

Thanks,
Rafael

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
