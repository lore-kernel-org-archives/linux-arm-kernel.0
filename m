Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:20:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67BF20659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pKhWhX45";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbPJHVc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67BF20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DVaVp78I3veqLrGXaXWhUVUyuNGmmyF0C1QHu72C06o=; b=pKhWhX45N5kGi+
	cupPCaS9ck8zJh+w5+D+Y4A7WAAIgTMcekzhmAX8Yiy7PbcQPR9tT5oJqKRr7VKi2cIO3ziSt/WM0
	oNrZfP1HRh7gF7lPtfR09Y821wxcddZPJk8kPXGhVML6+u3A57yFX/j3B+dT5RXkcY24n1XcFiJuD
	JntSfyLOVHc4nh2hWPvLCtdAh9aQ8ANUWB1B4iWW/jH6Ip1k09nMsWF1VV2dMEB3IL0Hw2Fz6sEXK
	Kh55F57Hqpl9huAMLJwXn81nNwx3FrujDgQRauDgiqJCzQV+gR2wZ+jwEx3PuDGVO5gXzwzETtZbg
	CYdppivwvDDhi4U/rZIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2A8-00010z-D0; Mon, 14 Jan 2019 13:20:20 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2A4-00010R-U1
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:20:18 +0000
Received: by mail-vs1-xe44.google.com with SMTP id n10so13556611vso.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BPyljIgp2wEitX709Kaplkdsc+3QnHtjc7OXNLr97mY=;
 b=VbPJHVc46QXcFBKFE3I2nW4/kRQrqfB08PxGSuaaIrhrC6UYG1BJDZq7bu1hGXPn1Y
 PpadgyAB7lxGLRYe00psCeAzPZ5B9QaW54JJ+wthLjKNI2/CTpNKH8fRbSvJyZmpZ1U4
 vNJaWxsd3DQvZiYhRQ6f0HdQ1g1RMQdpxMLJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BPyljIgp2wEitX709Kaplkdsc+3QnHtjc7OXNLr97mY=;
 b=I2o0eUBtt08fLJ0t8gJYMZkX7VUB3ciZhFGheCFEMDv3abkr3c5GhutpOnO8AjSSDz
 huf4rkBTqz+9/KbCjWhtUzWbXGNPf8LtnwW1RlPxXESwz5bG4Nj6fLncHDcDhP5S/POq
 5/R86BUA+HxrZYWlQwcmpjX++Nb+t0tA+5DSj0ZJbzh3k4NwDBZ2yJ8U57QhAktOEiqM
 BKqCBlbs+KDCQfS6EGJ8pGpFvd8d98gxRuHT+mk0XiXZt1GhHUIo+bfskZN/75ft8t8p
 muR72HJZwrMNsuk/2ueUEMi1Attrz5jWlhyaiPfgL+EWXAiCAaH6MD/yz7KvRQW1USPr
 hoNQ==
X-Gm-Message-State: AJcUukd4BSRvaZfxwkQ1UmNP3UA9NiAiY/Ezh8fIdXfPL8yeZhN5+dqJ
 /exGLFoe+axzke/3m67Fp4DfHtfukeEHLZSpst82xA==
X-Google-Smtp-Source: ALg8bN4iQ+FKWGs0V8+Zfasd85Mka6IBshlzF/S6RTztWRmgXRPrclByZfy62qQD/mNO0aEYsQCE2HrmYxPIE4GOWWk=
X-Received: by 2002:a67:7685:: with SMTP id r127mr10202029vsc.35.1547472015449; 
 Mon, 14 Jan 2019 05:20:15 -0800 (PST)
MIME-Version: 1.0
References: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
 <CAPDyKFpTW07CsemS1=0kTEc88-ZXb6+HUVaviGb+8eWBOyRjvA@mail.gmail.com>
 <675cab05-164f-fd72-9d87-1506dc5a6b7a@i2se.com>
In-Reply-To: <675cab05-164f-fd72-9d87-1506dc5a6b7a@i2se.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 Jan 2019 14:19:39 +0100
Message-ID: <CAPDyKFoOz4MB0QkM=JAera4-wF7LBsv23wW+YfQwkbStmRL0Bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: handle mmc_of_parse() errors during
 probe
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_052016_993974_6090B4E0 
X-CRM114-Status: GOOD (  14.90  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Al Cooper <alcooperx@gmail.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, "# 4.0+" <stable@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 14 Jan 2019 at 13:01, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> Hi Ulf,
>
> Am 14.01.2019 um 12:44 schrieb Ulf Hansson:
> > On Sun, 23 Dec 2018 at 22:00, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >> We need to handle mmc_of_parse() errors during probe.
> >>
> >> This finally fixes the wifi regression on Raspberry Pi 3 series.
> >> In error case the wifi chip was permanently in reset because of
> >> the power sequence depending on the deferred probe of the GPIO expander.
> >>
> >> Fixes: b580c52d58d9 ("mmc: sdhci-iproc: add IPROC SDHCI driver")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Applied for next, thanks!
>
> since this fixes a regression can this applied to fixes, please?

Of course, my apologies! I don't know why I didn't notice earlier,
especially due to your descriptive changelog.

I moved patch to fixes, thanks!

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
