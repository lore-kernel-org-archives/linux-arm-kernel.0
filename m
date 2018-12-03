Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8084C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:26:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DFD206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N5gBeN+z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="qgGfcu39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DFD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3c41A3CFYGTCq3EPpLmgW2zJ0oGYVuxMoUATq5skOVM=; b=N5gBeN+z2Yn5Pmf5mwrFle57y
	8mFIw1/FgVLnpUrMcBd706VgYe5GaPhwv9Hk09h3etOd5Awe5JhLt23Hg3hnMdBeXy4U29TwF0lue
	W0K99znBStU7GptxOuUD1+jVsuzwjJInCs1+ecQPoWXCqeehF0LfAWY1Jh+Ew74x6886DMZWWQfvr
	CepSaFJf+TvzhfHcyS2NC8HfxwcT4PcAnHijOg7P0YxHK71etDoH6+q6oH9XHOp7gVz2XUC9SJqxD
	1+dcpc3+VqWJMq4jSsH0LHgDOQENjbpgQ1xjnSvbNNNRX+bQFGLBq4ACc0IbP4zeMkUsw0R9L10ph
	4eVpIuNFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwfB-0005KE-Ki; Mon, 03 Dec 2018 22:26:01 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwf8-0005EZ-M0
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:26:00 +0000
Received: by mail-qk1-x743.google.com with SMTP id a132so8444108qkg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 14:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek-ca.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=M9ELRpNt54s+D99mnW5t3T2yNzxglg6NH/jjT3CHMq4=;
 b=qgGfcu39+FXSeAWqr3bCY1gtFAie35JyU6Lr3Ru+m2avZeVOmUvCkH6TzkqIuzXZqv
 edCH9LjmLBr1iub2KeTYTUgIVs9nSpYngrQmBSCUzNHCSNDhyORWFXQeb/MM+XEyH18t
 Tg7mi89ADDsvufSwH1lliXcLlnQQ+gqB3G64hDFd2hcPdw0jOOQETF4GE5pvenO75CVi
 1ekguNimAaIQGM8SEe925X6TXkAIx8RLPrXzHJ4TeztbmTKjdt1OVDQiquGvRb/FGTMQ
 hxNnxYbR4qVumQdlQat1HP5gAgpZq45P3Hh0BsM2TbTi3iEhOK+MQseSV18Rm86m/83E
 IcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M9ELRpNt54s+D99mnW5t3T2yNzxglg6NH/jjT3CHMq4=;
 b=nOOYyk4iPqmgKbwnUUB61ZfIgXeMH79cJ9XynUvxo4A5FkA2FZmoBcBqcGXWMgahtM
 78n3Uc6zS9AIiD9pCpunr4fTDOlIizH4beKfSPCU10fGJv62nDcYgsz19Quyrzg99iS7
 e3wDQNsi5XEXBB6iz2rQ+KuGbm9RMrHgxZsQndTDqxh5hgAiM0H5PoKH+k62DYgytz6q
 +MDGPSdFYZUkycDDGUqS2dDCb9gBn22sLKZK3WH1r6bxDXtoUDwxBK0jI6BABkoWrb71
 B1PyUhGtRAcrWN2LH21u7LCm1vDgd4+LtRjSlxna5Ujd9SAjmT+IXfjv9L4+Utq8VDZs
 Q0cA==
X-Gm-Message-State: AA+aEWYZkliTqxr/EUbjLi2RtB3EPeXLvgPiP4tG+6ekDL5EK4o1ZbIt
 OA9uZh3WeZ1tCSwzPNkQvBtWYQ==
X-Google-Smtp-Source: AFSGD/VWDdkrYowtduhvgFiEshny3EIsPCsjbhzbDWrje90r13tv4sOMm5KYf2TkXgqhxYYgMAz0PQ==
X-Received: by 2002:a37:d91:: with SMTP id 139mr17009575qkn.26.1543875947561; 
 Mon, 03 Dec 2018 14:25:47 -0800 (PST)
Received: from [192.168.0.189] (modemcable014.247-57-74.mc.videotron.ca.
 [74.57.247.14])
 by smtp.gmail.com with ESMTPSA id 24sm12916968qkp.65.2018.12.03.14.25.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 14:25:47 -0800 (PST)
Subject: Re: [Freedreno] [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
To: freedreno@lists.freedesktop.org, Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, festevam@gmail.com,
 Sascha Hauer <s.hauer@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Chris.Healy@zii.aero, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP Linux Team <linux-imx@nxp.com>
References: <20181203211816.5129-1-jonathan@marek.ca>
 <20181203211816.5129-4-jonathan@marek.ca>
 <20181203221032.GA20602@jcrouse-lnx.qualcomm.com>
From: Jonathan marek <jonathan@marek.ca>
Message-ID: <caaa2cfb-6b16-60a6-d679-d8b7437c0d99@marek.ca>
Date: Mon, 3 Dec 2018 17:23:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181203221032.GA20602@jcrouse-lnx.qualcomm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_142558_762527_28C602F5 
X-CRM114-Status: GOOD (  18.99  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/03/2018 05:10 PM, Jordan Crouse wrote:
> On Mon, Dec 03, 2018 at 04:18:16PM -0500, Jonathan Marek wrote:
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
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
>>   				clock-names = "ipg", "ahb";
>>   			};
>>   		};
>> +
>> +		gpu: gpu@30000000 {
>> +			compatible = "amd,imageon-200.1", "amd,imageon";
>> +			reg = <0x30000000 0x20000>;
>> +			reg-names = "kgsl_3d0_reg_memory";
>> +			interrupts = <12>;
>> +			interrupt-names = "kgsl_3d0_irq";
>> +			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
>> +			clock-names = "core_clk", "mem_iface_clk";
>> +
>> +			qcom,gpu-pwrlevels {
>> +				compatible = "qcom,gpu-pwrlevels";
>> +				qcom,gpu-pwrlevel@0 {
>> +					qcom,gpu-freq = <166250000>;
>> +				};
>> +			};
> 
> There shouldn't be any incremental cost in the source code to use OPP; it should
> just work. And then this won't give us a further reason to keep the legacy
> code around when we decide to dump any pretense of downstream "compatibility".
> 

I will switch to OPP.

>> +		};
>>   	};
>>   };
>> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
>> index 207eb557c..586d45586 100644
>> --- a/arch/arm/boot/dts/imx53.dtsi
>> +++ b/arch/arm/boot/dts/imx53.dtsi
>> @@ -838,5 +838,22 @@
>>   			reg = <0xf8000000 0x20000>;
>>   			clocks = <&clks IMX5_CLK_OCRAM>;
>>   		};
>> +
>> +		gpu: gpu@30000000 {
>> +			compatible = "amd,imageon-200.0", "amd,imageon";
>> +			reg = <0x30000000 0x20000>;
>> +			reg-names = "kgsl_3d0_reg_memory";
>> +			interrupts = <12>;
>> +			interrupt-names = "kgsl_3d0_irq";
>> +			clocks = <&clks IMX5_CLK_GPU3D_GATE>, <&clks IMX5_CLK_GARB_GATE>;
>> +			clock-names = "core_clk", "mem_iface_clk";
>> +
>> +			qcom,gpu-pwrlevels {
>> +				compatible = "qcom,gpu-pwrlevels";
>> +				qcom,gpu-pwrlevel@0 {
>> +					qcom,gpu-freq = <200000000>;
>> +				};
> 
> Same.
> 
>> +			};
> 
>> +		};
>>   	};
>>   };
>> -- 
>> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
