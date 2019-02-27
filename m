Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C14C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:04:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8052184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="srFS/GOx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEdK3vzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8052184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2l61yBhPygwktQmZp2qZIijF9uwBMaw6XHYg7T3eZ30=; b=srFS/GOxjO0NeJ
	ki50mPR8APA+VAb2dbZbNGKFpBl0bwXQdp+qJDn6Ck11UVlBGYk7XZcN03smezqPHZIYWQkJuTTyt
	k3/RJoWcloIEzbQr701skaNFNFzEU+aSgjhHhCyFPu0b7DL6Nul9bbFZpJwZ+D3UtRBhIEvDTAUZn
	6WaPbqJ8rO+ewiiki8mc2C7xNcXPP7Jo1TExNgPbmzC2lnGG8Iz1+PLONUR+rSBOEtFdBrdrHrg2A
	c3sWWdkmHMi4C/T9GNc1VJ8CxWIzn4NRMZTwT+QWVGONJ07kWb8tn9mXwSIHeGkEDs6wVCjEMXz2R
	HDbah1m+P+uNCg4KrkZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz3Zb-0006uJ-2O; Wed, 27 Feb 2019 18:04:51 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz3ZW-0006kH-LR; Wed, 27 Feb 2019 18:04:48 +0000
Received: by mail-ed1-x544.google.com with SMTP id f19so5295779eds.12;
 Wed, 27 Feb 2019 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BdzkyGp5mYzWWO91OQstRt0k7blJSkNigDgCUBHpKIQ=;
 b=aEdK3vzgLEyVKm83by4D/w724GInWR5W7piF3kMuE6ridj17JZyvzCXif7740gBbd/
 u+R2pSW/YuS+xFZT/tGPayKCaD5rCfVZy0ED32V/IfmasESkhhlLorVAjNUGJM1TIZLJ
 fGnhgREmM5XLSY/1WHmQKQjBOssjyw3VE7mH4MCEfz9RTkZUHmyvzP4FCurcRa/edmDi
 wJR/uXj/XLEj60u3Z+vqqd1D9arScQGWiof1uZAbXXPp2qQUjFM8txFt9xR1uHBM+DU7
 7tYe72WViExlRLceey1ffRtM8pb7AUzBbM5CEbS3dBCrUb6aosKzUJ0o+PEO9wy3fIGA
 re6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BdzkyGp5mYzWWO91OQstRt0k7blJSkNigDgCUBHpKIQ=;
 b=QSwkXD1Z4WOD1pQJORtYLsboCpHEssJLF6iVYX7UUTTSVaD9QySSEIOW01vbNiD99z
 HGnM/zs9+SZnKAUpfwM6Y7iLJaW9F+iAlw8fdukh4FPxPL2PlBaXmaQc+JP1A/ZJ02xD
 A0t2qraNjj4KYRMIMdUsZaxR8YAixMbotRdofewTrQoH1JS7Pkl/eZdDmsll94WyMgFT
 VfRxReAhJHvyfUTfYZ9Xwa0xTERNvrO41zqdwbls7oY1opPJKMrM5gtHc2ePuB7PBKki
 3RxBsiozTujPGn8mPT3riGQD2ee/S8QGBwR0CAv9OvCnZKdHGC2au1VEY5BRFoWjOsSQ
 5E/Q==
X-Gm-Message-State: AHQUAuZP4ebUs6GGoBaHjkvx/vq91JTT8uSnZHVkHgtQPRAjOabjzPuc
 zQUik0cO2O8KFg35nMWhlqo=
X-Google-Smtp-Source: AHgI3IZzoFafUmskIcPxA5LS7kB3ssJdLBRN4OIjLZarBmh8jTyiKx+cEgi+8+ZaN/cfgd5VlsPOOA==
X-Received: by 2002:a17:906:90c6:: with SMTP id
 v6mr2460294ejw.241.1551290684242; 
 Wed, 27 Feb 2019 10:04:44 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id z23sm4420102edz.50.2019.02.27.10.04.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 10:04:43 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: display: rockchip: add document for rk3066
 hdmi
To: Rob Herring <robh@kernel.org>
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20190201123235.1693-1-jbx6244@gmail.com> <20190225165923.GA2578@bogus>
From: Johan Jonker <jbx6244@gmail.com>
Message-ID: <b183d099-dcb3-9c3f-7031-2bd54d7fe5bb@gmail.com>
Date: Wed, 27 Feb 2019 19:04:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225165923.GA2578@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_100446_709193_97933E30 
X-CRM114-Status: GOOD (  23.68  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, heiko@sntech.de,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks for your advice.

On 2/25/19 5:59 PM, Rob Herring wrote:> On Fri, Feb 01, 2019 at
01:32:35PM +0100, Johan Jonker wrote:
>> This patch adds a binding that describes the HDMI controller for
>> rk3066.
>
> This is not using the DW block like other Rockchip SoCs (IIRC)?

As outsider it's a little bit difficult to comment on that.
Maybe an insider can give a better answer.
The rk3066 is there early model.
Reusing blocks like in the later improved models wasn't in the fashion
yet I think.
Also comparing the rk3066-hdmi driver to the inno driver gives too many
differences in registers, sound support and irqs.
If it was similar they would have combined it in there own kernel.
Given the age there won't come any other support for it.
This is what we have...

>
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  .../display/rockchip/rk3066_hdmi-rockchip.txt      | 60
++++++++++++++++++++++
>
> Using the compatible string plus '.txt' is the preferred naming.

Will change that in V2.
rk3066-hdmi      -> rk3066-hdmi-rockchip.txt

How about the other documents?
rk3036-inno-hdmi -> inno_hdmi-rockchip.txt
rk3288-dw-hdmi   -> dw_hdmi-rockchip.txt
rk3288-dp        -> analogix_dp-rockchip.txt
etc.

>
>>  1 file changed, 60 insertions(+)
>>  create mode 100644
Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
>>
>> diff --git
a/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
>> new file mode 100644
>> index 000000000..6a8f3754f
>> --- /dev/null
>> +++
b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
>> @@ -0,0 +1,60 @@
>> +Rockchip specific extensions for rk3066 HDMI
>> +============================================
>> +
>> +Required properties:
>> +- compatible:
>> +	"rockchip,rk3066-hdmi";
>> +- reg:
>> +	Physical base address and length of the controller's registers.
>> +- clocks, clock-names:
>> +	Phandle to HDMI controller clock, name should be "hclk".
>> +- interrupts:
>> +	HDMI interrupt number.
>> +- power-domains:
>> +	Phandle to the RK3066_PD_VIO power domain.
>> +- rockchip,grf:
>> +	This soc uses GRF regs to switch the HDMI TX input between vop0 and
vop1.
>> +- ports:

Should "ports" be replaced by: "hdmi_in: port"?
What is preferred?

There are two different methods in use:
-1
		hdmi_in: port {

-2
		ports {
			hdmi_in: port {

>> +	Contains one port node with two endpoints, numbered 0 and 1,
>> +	connected respectively to vop0 and vop1.
>
> You should have an output port to an hdmi-connector node (or bridge) as
> well.

Which hdmi-connector node?
Could you explane with an example?
The Rockchip hdmi nodes I'm aware off only use the port nodes as a way
to switch the hdmi input between the vop's.
The vop nodes can have multiple outputs.

>
>> +- pinctrl-0, pinctrl-name:
>> +	Switch the iomux for the HPD/I2C pins to HDMI function.
>> +
>> +Example:
>> +	hdmi: hdmi@10116000 {
>> +		compatible = "rockchip,rk3066-hdmi";
>> +		reg = <0x10116000 0x2000>;
>> +		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru HCLK_HDMI>;
>> +		clock-names = "hclk";
>> +		power-domains = <&power RK3066_PD_VIO>;
>> +		rockchip,grf = <&grf>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
>> +		status = "disabled";
>
> Don't show status in examples.

Will change that in V2.

>
>> +
>> +		hdmi_in: port {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			hdmi_in_vop0: endpoint@0 {
>> +				reg = <0>;
>> +				remote-endpoint = <&vop0_out_hdmi>;
>> +			};
>> +			hdmi_in_vop1: endpoint@1 {
>> +				reg = <1>;
>> +				remote-endpoint = <&vop1_out_hdmi>;
>> +			};
>> +		};
>> +	};
>> +
>> +&pinctrl {
>> +		hdmi {
>> +			hdmi_hpd: hdmi-hpd {
>> +				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
>> +			};
>> +			hdmii2c_xfer: hdmii2c-xfer {
>> +				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
>> +						<0 RK_PA2 1 &pcfg_pull_none>;
>> +			};
>> +		};
>> +};
>> --
>> 2.11.0
>>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
