Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A911EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:49:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773092192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AZSNECIV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F1wZf7j7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773092192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PIqELhKVVEwca6/1MHGEQoaiXz8RxMxO1M9WpwquPjM=; b=AZSNECIVOTjC381QXjqB+KOGE
	v33m7cAG/Ggffl7kIrUWevttf8RJellMT6zhLqqqge25UJGHSX4dmvus4sNc7UOoMrpPZ6yZls5CV
	QSVBumMEK5nN/iYtKhwqB82ujvlZtTO/U9Ui8G2mGSVAJYcxCgWKNufLeEBhlZDYcrvaNk0lpCCC7
	LZBEbHjEx/yzhNBch49qIYt4XBCzithNP4tka+Js9FMndwDjcwxh6Mq4DaHn/mAq0H+r3goEx8Dmz
	vGLGkq8bN2FWnDHwvtc60vaV68MUFmHzJhnQYr9uMGfE3TsoP2ClMydm6LEQr7cTMvfbk692pFhE/
	MSbs90Xtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZAZ-0004qW-Jc; Fri, 15 Feb 2019 08:48:27 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZAV-0004mc-Be
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 08:48:25 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1F8mMIS009913;
 Fri, 15 Feb 2019 02:48:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550220502;
 bh=Gyk2Q3oXt18BwtJ2h0Yrustu6G0tnn/n4V3TTANsQfg=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=F1wZf7j75Zw457hYSokjJMUi2DELEW0DBuALGTdiCL9t5Ac20IIzJ/HoX3z4UwLcm
 7QBDtefxAzdb1f8eovAaa2HZZXsHTIsdZru7WjxlfTlZt7CpS2w6L35teXXkKDEC1a
 KCUBot7I3fmFxRxjqfTBc3GWDei20/XHcVGe/urI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1F8mME2102622
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 02:48:22 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 02:48:21 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 02:48:21 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1F8mIPL018285;
 Fri, 15 Feb 2019 02:48:19 -0600
Subject: Re: [PATCH v2 0/3] arm64: ti: k3-am654: USB support
To: Roger Quadros <rogerq@ti.com>
References: <1549370722-414-1-git-send-email-rogerq@ti.com>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <d67c23b7-bd1c-c7ae-e878-9437d41e26ff@ti.com>
Date: Fri, 15 Feb 2019 10:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549370722-414-1-git-send-email-rogerq@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_004823_487299_99102926 
X-CRM114-Status: GOOD (  20.83  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05/02/2019 14:45, Roger Quadros wrote:
> Hi,
> 
> The AM654 SoC supports 2 DWC3 USB controller instances. The
> AM654 base board supports the 2nd (USB1) instance in high-speed.
> 
> This series enables support for USB1 instance on the AM654-base-board.
> 
> The series depends on [1] and [2]. Both are in the -next branch of their
> respective maintainer trees.
> 
> To test you can apply on top of linux-next. As usb/next was just pushed
> today, it might have not reached linux-next yet. If so please pull that from [3].
> 
> If using arm64 defconfig, you need to enable
> 	CONFIG_USB_DWC3_KEYSTONE=y
> 	CONFIG_OMAP_USB2=y
> and the necessary USB drivers that you want to test. e.g. USB network adapter.
> 
> [1] AM654 USB2 PHY support https://lkml.org/lkml/2018/12/5/908
> [2] AM654 DWC3 support https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1896101.html
> [3] usb-next https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/log/?h=next
> 
> Changelog:
> v2
> - usb & phy nodes are not kept disabled in k3-am65-main.dtsi.
>    Unused ones are disabled in board dts instead.

Series queued for 5.1, thanks.

-Tero

> 
> cheers,
> -roger
> 
> 
> Jyri Sarha (1):
>    arm64: dts: ti: am654: Add Main System Control Module node
> 
> Roger Quadros (2):
>    arm64: dts: ti: k3-am6: add USB support
>    arm64: dts: ti: k3-am654-base-board: enable USB1
> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 84 ++++++++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 28 +++++++++
>   2 files changed, 112 insertions(+)
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
