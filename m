Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE118C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:27:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A102084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M+Jb1d+0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEvJUX7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A102084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cD9/5CgUMAZTPcyhm8XSY6slE61vs3NJ23/LADMhF24=; b=M+Jb1d+0GvqxAy
	bHer/KRJeEkbl41DRr1pDNIDY+q3Wvj8In7NIjYYCKM04MN2H8k8SiEoWzAmoW6e0BmR2LNaG15Q+
	CLsZKEYuVno/+1v1iQ8NLuu5/+8Hl8dVl1eT8TloGxQt2lxAHqbZ3ZhfrypRkRkPdFcfFhbtRlIFA
	HO52eGn7CQ0DI0SguVEWwe6iOyZyuzAg7+STb33fRwOEwZVrKoTowj/FNyP7XNLgNHBX7sSY7TkGt
	PYRMMbu7g56t3TFx7iEgvTDqgm1qHdLovLAxQMvlF3IxGAv+FGhiQZq5DBot4CFyT6RfLOTuwj7Ft
	7RTwTzVgC4s9nkdORFGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYoFf-0000C1-37; Mon, 17 Dec 2018 08:27:47 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYoFb-0000B2-Ca
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 08:27:45 +0000
Received: by mail-vs1-xe41.google.com with SMTP id e7so7185848vsc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 00:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ePRLGvAvByKgzB9cfX2ljCN93S/dzHvixVBNukQwq3k=;
 b=HEvJUX7Lwc65ev82aaEutpI/r2TGz359VQn79FR9tc0VHjbqXNDnGXflJ5od6Pl3V4
 Fx8DlFap59l6/8NfVEqUx8uGtjElBHIsRnZbqKRwEUChsC9e6Rt74L0b12rpci9WtCgM
 y0IC+dRvvpkyOZOOSN6ZZgDS2h80QKrFmIyy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ePRLGvAvByKgzB9cfX2ljCN93S/dzHvixVBNukQwq3k=;
 b=UFhFBpDm91rzBmApnUxgxAeairtlOG3MYLfLGR71xQ9rVgdz5AzLcJI5CbUU4HHC5s
 GUraT1eXm5yaZUEnuLR9Kj57Z1eglCQ6q4ql74kEC9yTa6Y9U7Il0fbPhGMSFGPPa+HA
 lk1y2c9MGj5XNWde5+EoNnT3dC0q5vavvDgHVuva5pfioSleCbx+HqcUvvdO09LPF6qn
 wT7wiU+IQozT4jRCXdRczxNX0a+Z8cNc/XP4Ygy257IZ9GRtKhbkHzDfNG+faLBQys82
 O2yVK2t+auSNDWGAjc1rknUZ3KwuKzZxEyduJ/3ylZTtDUAssuqXMGNBV19JApLT4Qpn
 gkdQ==
X-Gm-Message-State: AA+aEWbIGaEbdDzP72ubTP5sjtwc6zyI+5Yz97KLpwEx016uOxpTgUtt
 frOhVNhKwfVVsGOIuFtMG+Z6D3w4zpyAKgrnQ2MznA==
X-Google-Smtp-Source: AFSGD/W1DVp03FXlfyH9tz4mSw3V0LLdyuUbsKtQizq/soTXcUbw3xdgW20uZ14I7uzCz76JLrM4bO6R0uKQ0eRUe7Q=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr5879700vsa.165.1545035252165; 
 Mon, 17 Dec 2018 00:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20181210183507.9617-1-faiz_abbas@ti.com>
 <378ace78-7345-8875-f3e7-7cddcaf5e4bc@ti.com>
 <38fe3521-f029-5e1b-78be-f265c5764a3b@ti.com>
In-Reply-To: <38fe3521-f029-5e1b-78be-f265c5764a3b@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Dec 2018 09:26:56 +0100
Message-ID: <CAPDyKFpPCmuCVXEK0S5dOauDChKQShGUTenM1RzqSCPF29=3iQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add driver Support for MMCSD on AM654x
To: Sekhar Nori <nsekhar@ti.com>, Faiz Abbas <faiz_abbas@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_002743_427690_673B81FA 
X-CRM114-Status: GOOD (  20.27  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>,
 Kishon <kishon@ti.com>, Michal Simek <michal.simek@xilinx.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 17 Dec 2018 at 09:24, Sekhar Nori <nsekhar@ti.com> wrote:
>
> On 17/12/18 1:45 PM, Faiz Abbas wrote:
> > Hi,
> >
> > On 11/12/18 12:05 AM, Faiz Abbas wrote:
> >> The following patches add driver support for MMCSD on TI's AM654
> >> platforms.
> >>
> >> Previously I had added the support to sdhci-of-arasan driver with
> >> a separate phy driver[1]. Since then it has turned out that tuning
> >> operation (for HS200, HS400 and SDR104 speed modes) will require
> >> configuration of phy registers. This completely breaks the model of
> >> the sdhci-of-arasan driver which relies on a separate driver to
> >> configure the phy register space.
> >>
> >> Because of this, I am creating a new driver with both the sdhci and
> >> phy register spaces. This helps me use the phy registers in a future
> >> patch that adds tuning support.
> >>
> >> DT patches will be posted in a separate series.
> >>
> >> Changes in v3:
> >>  1. Removed reference to clk_ahb as its not being used.
> >>  2. Added comment for pm_runtime being used for enabling
> >>     clocks.
> >>
> >> Changes in v2:
> >>  1. Reset OTAP delay back to default value in init.
> >>  2. Improved patch description for patch 2.
> >>  3. Minor style fixes.
> >>
> >> [1] driver and phy patches posted before
> >>     https://patchwork.kernel.org/project/linux-mmc/list/?series=26623
> >>
> >> Faiz Abbas (3):
> >>   dt-bindings: mmc: sdhci-am654: Document bindings for the host
> >>     controllers on TI's AM654 SOCs
> >>   dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am65
> >>   mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
> >>
> >>  .../devicetree/bindings/mmc/arasan,sdhci.txt  |   4 +
> >>  .../devicetree/bindings/mmc/sdhci-am654.txt   |  37 ++
> >>  drivers/mmc/host/Kconfig                      |  12 +
> >>  drivers/mmc/host/Makefile                     |   1 +
> >>  drivers/mmc/host/sdhci-of-arasan.c            |  46 ---
> >>  drivers/mmc/host/sdhci_am654.c                | 374 ++++++++++++++++++
> >>  6 files changed, 428 insertions(+), 46 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> >>  create mode 100644 drivers/mmc/host/sdhci_am654.c
> >
> >
> > Gentle ping.
>
> I see these in linux-next.
>
> aff88ff23512 (Faiz Abbas) 6 days ago  mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
> 7f6e4cc6727d (Faiz Abbas) 6 days ago  dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for AM65
> 351b766ef2c7 (Faiz Abbas) 6 days ago  dt-bindings: mmc: sdhci-am654: Document bindings for the host controllers on TI's AM654 SOCs

Correct!

Apologize for not confirming that I have applied them. I don't know
why I missed that for this series.

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
