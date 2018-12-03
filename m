Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2750CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6232206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wn0rkl1j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="PHgdoWRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6232206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uwiufB0uAEZyze/rgK4T5Ez6Pz3EIDbZvo+QMTk7Gh0=; b=Wn0rkl1j23z5IZMdTOZq9X09R
	dIVCSEC60GdJWFBZYxTJcnC8ZaP/S1oaE+GiB5WWmUXI2DLoalpOPB0n9Shu4yItEal66Kfruiaez
	wcZsbbOnypO0hBuLjoSM1SfNgm7ptB+okNpavh9dz7M41BDxHpNAJlH5K5zrWEBszPY7NPQExsocA
	GBgnT+58ZPzKFZPInZm+uPWJQfNNhOUKEc9MQnbM2+bymAXVYmfpzRGsfbwfU8xlafb7fZhwe5Eea
	VNFsBvCvwnoiG/h6fcJ8kY81W8UN0l94s1tqhZgGWCRycZ7CAXbWHJBeKosmNdZsuylPoBQIylwTX
	9TU3ySTsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwdk-0003PC-Jt; Mon, 03 Dec 2018 22:24:32 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwdh-0003OC-Kw
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:24:31 +0000
Received: by mail-qk1-x742.google.com with SMTP id d19so8435820qkg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 14:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek-ca.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5Qg81U+ca65JeAAqq1YakJhxYwuFlumKDwYG7cVu3Tg=;
 b=PHgdoWRL8TZXfFZNYAig82LEES6/Czv/U+5esE0BmBow2Kocx7ZibBiCsVatbAwMaB
 Wr7w6lKYr14y+wyNRy76NuInPz9ZF5235l2w8DaPSMCoqFppQ+hXeAAXcobhHUfquPLf
 CMaxpYo/2Lxn63eianndOOecCrcqfQHognYdAqli3eRLCu+bDsNfkoAHnQtbg3A7+gYn
 WFUzGvqS89r7h4vSTbpBLPBspIm1xOQeskpxZ8U5m1ohWeoEFDmBqEuJ+qS17cJtcjPh
 oZy+mSnNL3ugAFgrxkHwfjmlpkck+Qiqazqpeh3oYzpkAbGxJjeFqu99s7KA5PRqwArK
 rihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Qg81U+ca65JeAAqq1YakJhxYwuFlumKDwYG7cVu3Tg=;
 b=KN3V3tVplUL8QUsxZFZ89ut0cX7ghfZmOZAyyHLNHsmq4ITBL9eQsW/Wob19HhvjFc
 yjsEw1L22j02e3uta4Iz8u5xvaSEk/JbM9gZZXNsXWbElkk6VlVwDpI6h1+Dx5XzvTqF
 pSLSp3SFxlLR3kumEQJ2VY7wHnrgN5akshLcutB2mYTPGvoGVKjUiZ/F1VpNrW27hMbL
 IE+MjJDQRuqD7n5UlEZJK5LP+UzD64DBmMtmYB0mCMb8eR/wbIxeUPcehpafd2eHI3nI
 4RZiLJgUU6rEAcZiwEnK951Uewns4CGPfkJwiNDpLYRfVrY1ENro2G/Pll4dQISFrfJ6
 J87A==
X-Gm-Message-State: AA+aEWbfBu0H6DG7ukj8zIzCAm4R1pUgDoYk9DIrJhZmXGgoxTCtukP1
 9Tn/QL+Ot6uorpkxNx/MEMu0lg==
X-Google-Smtp-Source: AFSGD/UpDy6lMDJrG9loWlVpLvJR7kt985EHx0qBJP1XCqaPyFmU5cnT1l4iK2rXeGuQJyDQ1yREwQ==
X-Received: by 2002:a37:cf9b:: with SMTP id v27mr16179832qkl.160.1543875858364; 
 Mon, 03 Dec 2018 14:24:18 -0800 (PST)
Received: from [192.168.0.189] (modemcable014.247-57-74.mc.videotron.ca.
 [74.57.247.14])
 by smtp.gmail.com with ESMTPSA id y2sm11441367qtb.88.2018.12.03.14.24.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 14:24:17 -0800 (PST)
Subject: Re: [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
To: Fabio Estevam <festevam@gmail.com>
References: <20181203211816.5129-1-jonathan@marek.ca>
 <20181203211816.5129-4-jonathan@marek.ca>
 <CAOMZO5B18DyZ0zvit6AgaueMifnMf2ctSo7pE_XndRpt7+bnLw@mail.gmail.com>
From: Jonathan marek <jonathan@marek.ca>
Message-ID: <3e8d1f9e-ffb4-dd6a-0a68-f59b4c1134a0@marek.ca>
Date: Mon, 3 Dec 2018 17:21:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5B18DyZ0zvit6AgaueMifnMf2ctSo7pE_XndRpt7+bnLw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_142429_689532_FE4F51AA 
X-CRM114-Status: GOOD (  23.97  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, freedreno@lists.freedesktop.org,
 Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Chris Healy <Chris.Healy@zii.aero>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP Linux Team <linux-imx@nxp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/03/2018 05:16 PM, Fabio Estevam wrote:
> Hi Jonathan,
> 
> Thanks for working on this. Really nice to see GPU support for mx51/mx53!
> 
> On Mon, Dec 3, 2018 at 7:21 PM Jonathan Marek <jonathan@marek.ca> wrote:
> 
> Please add a commit log.
> 
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> 
>> ---
>>   arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
>>   arch/arm/boot/dts/imx53.dtsi | 17 +++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
>> index 67d462715..e9a7bbce9 100644
>> --- a/arch/arm/boot/dts/imx51.dtsi
>> +++ b/arch/arm/boot/dts/imx51.dtsi
>> @@ -628,5 +628,22 @@
>>                                  clock-names = "ipg", "ahb";
>>                          };
>>                  };
>> +
>> +               gpu: gpu@30000000 {
> 
> We put the peripheral nodes in address order, so this one should go
> prior to the IPU node.
> 
>> +                       compatible = "amd,imageon-200.1", "amd,imageon";
> 
> I can't find the dt-bindings for these compatible entries. Have you
> documented them?
> 

It is the same as qcom,adreno which is documented here:

Documentation/devicetree/bindings/display/msm/gpu.txt

I guess I should add amd,imageon there.

>> +                       reg = <0x30000000 0x20000>;
>> +                       reg-names = "kgsl_3d0_reg_memory";
>> +                       interrupts = <12>;
>> +                       interrupt-names = "kgsl_3d0_irq";
>> +                       clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
>> +                       clock-names = "core_clk", "mem_iface_clk";
>> +
>> +                       qcom,gpu-pwrlevels {
>> +                               compatible = "qcom,gpu-pwrlevels";
>> +                               qcom,gpu-pwrlevel@0 {
> 
> You could drop this @0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
