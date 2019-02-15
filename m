Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45B2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:38:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AE92192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H5OpmXPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AE92192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lvxu7Zi+qtvHtaJwE+vWeXVVGWpFXoxCclDisaS1AiI=; b=H5OpmXPV/9KVNx
	fBed7rqZaCzkKGDHVaw823ukVYmIq5ppX6+sh5s4CgqYP7+IfSHWhG7ZBcEhKtnHzKhNRZZrPUxxl
	KHAucbFVEM6i/FoSBFqOFNZkvGxXe599OLLeBf26oUK7r8S+5w5srFioCpr+NEODlrcJ9+VYngFfT
	sB2MLw1F95IeWIKYLJTlMe/VRgneRtFIhWylKleuYmtNrCxO1sDuLh7tL1VEGh3NvvV7iEH/TIsrg
	GZvLmVmPgNwrVdD1mHHJIsV9daZ63dOAXy5XyOLUIjgo9ik+KMDF3cHIxTv5Kz/KU7Nx2kzQoJtZL
	a/9dp+U6t3tiza57oV6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guedU-0000oB-Vr; Fri, 15 Feb 2019 14:38:40 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guedR-0000nl-ES
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:38:38 +0000
Received: by mail-qt1-f193.google.com with SMTP id y4so11038253qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iPYKr/cxTe8zePEWJAtl/2EFtNqsbRETxXwwumQ0GQc=;
 b=bbatMzLbgGRL5in7kyyU/zpAkDoJUtk3vTdxSuCcGIiFB3ZyTNkjOxCkqJHk6Y0kKr
 prNsqd5CPx+UBgA1N7LA5kg7JBb3t1IphTInKaggPWkUdyjyZI4ylN8PUdfK+q6cMcSb
 XqHIZcYefCPF+GizgS/N1gZQ1J0fFsstGmKv5FcgKRrFZ6uWLdQJGclkCkcqNVsRGY/f
 X91M7phA9jX3rLCDxLWiMW7o8LB3rXrM7xEzQdIRGcg7NgYs1p0NO2dbrprhSmOfogDR
 0VDV+VwNrCjBb1H/MRPGsquV+mIMsmiJx3M4DLeYgeLuJ5vz/nbkdvpsLSHqQAQKCACn
 JKag==
X-Gm-Message-State: AHQUAuaSBCsD62WcZ7eEbQwaSdMUWMzTaNw55P2uiWpXXdMqTUrPZcGi
 ZG17RaCO4jt8ivzmoXDRVTllU34MdQ0swrITATI=
X-Google-Smtp-Source: AHgI3IaMJ+7zoHLigukvfYxDbIrvgu1KIylJmCB2E81lWC5lMWlWZiVnP2LtFMOtkVA2yKcLi/ZlHl87KISmwrQ1Irs=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr7888386qta.152.1550241515004; 
 Fri, 15 Feb 2019 06:38:35 -0800 (PST)
MIME-Version: 1.0
References: <2d2b3aa7-25ef-05e6-7616-506643f4bbf2@hisilicon.com>
 <231af4e4-00e8-c854-0f48-91d781452547@hisilicon.com>
In-Reply-To: <231af4e4-00e8-c854-0f48-91d781452547@hisilicon.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:38:18 +0100
Message-ID: <CAK8P3a2nyxbBoy7zqYLcBLX3u8izYZOPxwxHC3Mw62FaiS7NCg@mail.gmail.com>
Subject: Re: [GIT PULL v2] arm64: dts: hisilicon dts updates for v5.1
To: Wei Xu <xuwei5@hisilicon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_063837_486268_746EA36B 
X-CRM114-Status: GOOD (  11.75  )
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
Cc: Tangkunshan <tangkunshan@huawei.com>,
 Linus Walleij <linus.walleij@linaro.org>, Linuxarm <linuxarm@huawei.com>,
 Haojian Zhuang <haojian.zhuang@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, arm-soc <arm@kernel.org>,
 huangdaode <huangdaode@hisilicon.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhangyi ac <zhangyi.ac@huawei.com>, jinying@hisilicon.com,
 John Garry <john.garry@huawei.com>, John Stultz <john.stultz@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Salil Mehta <salil.mehta@huawei.com>, Guodong Xu <guodong.xu@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Alistair Strachan <astrachan@google.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Leo Yan <leo.yan@linaro.org>, Olof Johansson <olof@lixom.net>,
 Jan Kiszka <jan.kiszka@web.de>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 Shiju Jose <shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 12:32 PM Wei Xu <xuwei5@hisilicon.com> wrote:
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-5.1v2
>
> for you to fetch changes up to 8d26c1390aec795d492b8de5e4437751e8805a1d:
>
>   arm64: dts: hikey: Revert "Enable HS200 mode on eMMC" (2019-02-04 10:20:42 +0000)
>
> ----------------------------------------------------------------
> ARM64: DT: Hisilicon SoCs DT updates for 5.1
>
> * Hi6220 SoC and related boards:
>   - Add DMA entries to enable DMA for Bluetooth transfers
>   - Add power-on delay to make wifi stable
>   - Revert HS200 mode to avoid eMMC controller resets and block read failures
>
> * Hi3660 SoC and related boards:
>   - Fix SD card detection via setting cd-gpios correctly
>
> * Hi3798 SoC and related boards:
>   - Fix malformed SPDX license identifier


Pulled this version now, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
