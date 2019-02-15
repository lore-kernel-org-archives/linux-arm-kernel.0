Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0588BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:48:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C4A2190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mBSIUDGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C4A2190C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tY7z+STQ0BmPdbzLgFj7frfQS33aU3qFbqnaM6PQwLo=; b=mBSIUDGpymMl6G
	au57zYCPdazvEpuAEPV8ZksTKAXYZ19NnlpIzyD0pPNfDVr4QnKTYxssLS9/0lb4G3uWQ6nQi+wRe
	NTPuVwQIKt2k9kvKPy1hb4HDKjHhAZu0Kpy9lHKAqLqYnsld3E9BgjkBTDxqdAFk2kNo1wxOt/qpB
	z+QofVkP5WaVohqObz8lQWfOgFUNhaWe7HhOluNWidMshm/6zSx9vEwNy8Ct8aAICzBvJ+BnYEwOm
	HhvPE4iVNDVQlV71foOpg7lg7WsBGyEV4YM3WySm5EDkZI38zxV/gXmCk3E8bED/vZXo8aiM0AXQb
	dz7cssE7uLPyb13LaH8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufil-0002wo-4g; Fri, 15 Feb 2019 15:48:11 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufig-0002jy-1E
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:48:07 +0000
Received: by mail-qk1-f193.google.com with SMTP id u188so5923483qkh.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kUJ7gaBepC2S8gJFGlWCEqe6HsjSRxervJVmX8hunf8=;
 b=s3806ARLSrlSKAS/CnZQAalG7SMNIfFNJdEFlCR1p58MN1jsiTC1R4eUPD7Wwa84SH
 zjy2VG9HQM+U1z0aGRjTgEBoZvl3+O3lZySv+eVwqS6ZAfS860iX/unh3zDZMqSZegDt
 3rYv7lsqV4TLHJ5aepRhrjwwjXXgNkKD3tvorWNL0/PsC7dL0iQYwfzFMj+G/heR5OG+
 TWTN9xjAspz1dy04pfqcZQlWetxtAUyDxH7KNTKJ2LTGnJiArM+M1Su9OZHks2B1sLYV
 BfEitlFNILR4WZAJrbz9wlCrmFuWOZKT6ztpUAP5TwikdtP6R/3WV/OhrkDjhSFZe58y
 2hmQ==
X-Gm-Message-State: AHQUAuZnpPVYRRvqRk9bS6h5Yq62TSjrLAFHJMAif1jZhXL0kT2G82VH
 qFPapQH1PIKKsxrWlHeqsZQPb+FaB7uDNMEgH+Q=
X-Google-Smtp-Source: AHgI3Ia6EJ4VBJjfsEfTZEeF3woDAcdeiTsZseDvYTzrav4ejbnQHhxgU3CBBKTneZHxK9R+eeUwqf2kq+kNdX9REAs=
X-Received: by 2002:a37:d492:: with SMTP id s18mr7120227qks.343.1550245685017; 
 Fri, 15 Feb 2019 07:48:05 -0800 (PST)
MIME-Version: 1.0
References: <20190212112126.572-1-shawnguo@kernel.org>
 <20190212112126.572-6-shawnguo@kernel.org>
In-Reply-To: <20190212112126.572-6-shawnguo@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:47:48 +0100
Message-ID: <CAK8P3a3CtXq1ZoO-Lh6Zvm=VqVRfUVJKuptFCNY33M9G6BgRCg@mail.gmail.com>
Subject: Re: [GIT PULL 6/7] i.MX defconfig updates for 5.1
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_074806_273563_D7F8DE3D 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 12:22 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-5.1
>
> for you to fetch changes up to 90a50f9f4ddcd35d0d4af536cf1f767ea2041cb8:
>
>   arm64: defconfig: Add IMX2+ watchdog (2019-02-11 11:03:07 +0800)
>
> ----------------------------------------------------------------
> i.MX defconfig updates for 5.1:
>  - Enable a number of i.MX SoC and driver options in arm64 defconfig.
>    The built-in drivers include: clock, pinctrl, power domain, serial,
>    MBox, SCU, Ethernet, MMC, regulator and watchdog, which are mostly
>    essential for building an useful kernel image for i.MX8 platform,
>    booting with rootfs on NFS or eMMC.


Pulled into arm/defconfig, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
