Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80398C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476582082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ke1NmeNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476582082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mpZma6hbRHDI/DkYPZdjURCZ2dbN5e/ApSt9qvdkWuI=; b=Ke1NmeNdEi5d0S
	nICAXRk0AgKxb8WL9EUXYj5+HbAgEBStdZnguuR6j3DHPf+OyYg1c7Hxd9Dj5dZxzlNgx8YtqtP6L
	GFT5jSPm4pXa9YDO2zuznLO2KOJ6rC2jadUyAXsE1d7llIq7rbvN4EiElOyFfiy4s9FAq36zeQT2L
	k1z3sa10Yc9K2nX4u/KPJ1boKdoaMGOp5ZauOBooZ3+jMhUSAqylHbZeH+wB+MTIyJ77byx2C1Od+
	kBMUa9rY3IagymVVOlrKpOsqWXhd06B42faV9D3wVuzprOom92i7DEUqaESaHG8G3y2cXaZFth4Qt
	46GWSuwNAdsnHyGEDtEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUDwn-0001jl-1B; Tue, 04 Dec 2018 16:53:21 +0000
Received: from mail1.bemta23.messagelabs.com ([67.219.246.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUDwk-0001ir-5H
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:53:19 +0000
Received: from [67.219.246.101] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-b.us-east-1.aws.symcld.net id 05/20-10856-2E0B60C5;
 Tue, 04 Dec 2018 16:52:50 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRWlGSWpSXmKPExsXi5LtOQPfRBrY
 Yg6t/5S3mHznHanHl63s2i02Pr7FaXN41h83ixRZxB1aPTas62Tzudx9n8ti8pN7j8ya5AJYo
 1sy8pPyKBNaMe2/XshU8Z6k4v7ufsYHxG3MXIxeHkMAqRolptxawQTirGSUar8M4exglniw+x
 djFyMnBJqAv8e3PQSYQW0RAWeLUxj52kCJmgSlMEr2HDrKAJIQFkiSOf33ICFGULDFt0UugHR
 xAtpXEmifsIGEWARWJM6dXMYPYvAKGEk27loDFhQTSJA5O38oKYnMKaEssWwZyBCcHo4CYxPd
 Ta8D2MguIS9x6Mh/MlhAQkFiy5zwzhC0q8fLxP7BeUaD5LQf3sEDEFSQ+H5zHBtGrI7Fg9yco
 21yib+FuZggbaNfC11D3CEqcnPmEBeRkIaAfG67wTmCUmIVk8ywkk2YhmTQLyaRZSCYtYGRdx
 WiWVJSZnlGSm5iZo2toYKBraGikCySNzPQSq3ST9EqLdVMTi0t0DfUSy4v1iitzk3NS9PJSSz
 YxAqM9pYChbgfjj6XphxglOZiURHk3qLHFCPEl5adUZiQWZ8QXleakFh9ilOHgUJLgPboeKCd
 YlJqeWpGWmQNMOzBpCQ4eJRHejDVAad7igsTc4sx0iNQpRkUpcd4bIH0CIImM0jy4Nliqu8Qo
 KyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmLd5LdAUnsy8Erjpr4AWMwEtztnCBLK4JBEhJdXA6
 H3lrJCvvo6tseT8yWK1DrNmXQ5/aZXxJ/jknbOTX5bz2ds/cCvYuPjuqhmBT3+8P6at7bbo3N
 QpjyMmLc01uGnpET35TZ3A8rzPYfNOnbpifybsosdUD6vXx7Mv/I0yO7Ui0G9Tn1nC7Kw1zGe
 Xq0qYqrxPv+GRqrjdfurDCZ8lLrTkTfr5MUCJpTgj0VCLuag4EQC5jCFCcAMAAA==
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-25.tower-385.messagelabs.com!1543942370!4338264!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30255 invoked from network); 4 Dec 2018 16:52:50 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
 by server-25.tower-385.messagelabs.com with DHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Dec 2018 16:52:50 -0000
Received: from MTK-SMS-XCH03.digi.com (10.10.8.197) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Tue, 4 Dec 2018 10:52:49 -0600
Received: from DOR-VMS-XCH01.digi.com (10.49.8.98) by MTK-SMS-XCH03.digi.com
 (10.10.8.197) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Dec 2018
 10:52:49 -0600
Received: from DOR-SMS-XCH01.digi.com ([fe80::894b:3bdc:74ae:6efc]) by
 DOR-VMS-XCH01.digi.com ([fe80::c47f:be41:1dc7:5ab8%11]) with mapi id
 14.03.0415.000; Tue, 4 Dec 2018 17:52:47 +0100
From: "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v1 0/4] ARM: dts: ccimx6ulsbcpro: Add 10" AUO/Goodix
 LVDS panel accessory kit
Thread-Topic: [PATCH v1 0/4] ARM: dts: ccimx6ulsbcpro: Add 10" AUO/Goodix
 LVDS panel accessory kit
Thread-Index: AQHUbHTA2vWQEtRqSkqOSfrk549Zi6U/Tk0AgC+rlgA=
Date: Tue, 4 Dec 2018 16:52:47 +0000
Message-ID: <20181204165246.GA8605@agonzal-linux>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
 <20181104085425.GG26016@tiger>
In-Reply-To: <20181104085425.GG26016@tiger>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.24 (2015-08-30)
x-originating-ip: [10.101.2.194]
Content-ID: <957967DC1D77AD47AC1E44DA136A34E7@digi.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_085318_268324_7361A43F 
X-CRM114-Status: UNSURE (   9.80  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Nov 04, 2018 at 08:54:26AM +0000, Shawn Guo wrote:
>On Thu, Oct 25, 2018 at 05:09:29PM +0200, Alex Gonzalez wrote:
>> Alex Gonzalez (4):
>>   drm/panel: simple: Add AUO G101EVN010 panel support
>>   ARM: dts: ccimx6ulsbcpro: Enable AUO G101EVN010 lcdif panel
>>   ARM: imx_v6_v7_defconfig: Select TOUCHSCREEN_GOODIX
>>   ARM: dts: ccimx6ulsbcpro: Add support for Goodix touch controller
>
>It looks good to me.  Ping me when the patch #1 gets accepted and I
>will apply the test then.
>
>Shawn

Hi Shawn,

Patch #1 is already applied to drm-misc-next (thanks to Thierry for fixing it 
up for me)

Alex
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
