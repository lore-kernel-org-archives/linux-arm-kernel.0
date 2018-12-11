Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82703C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:13:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B012084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E8htaZ4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B012084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4zzvHpModD6i04KA+Mu9jXjPSMG90vKwhcR0Ev5GWtQ=; b=E8htaZ4xcutQOO
	X6Xti/qnkZk96Bo3H6dStFM4ePelzKV5uht0SLWFQEnih0TqBhrYizVMtK3YcdXscch2hKvzEG4mZ
	wGbBJ2XteOQmdK+gQzhDspQ1PMk8U7GjP7zntnj1AuZU+8mE1DoG5+6d7Uep5k4GaQ8+wjYjz36pg
	JR2ks7W39r4kk8M3sJzXbFqgHddyYA3ff5xxrSPVVrhPk88ncyWTW0qmfssVqMPOP5wd9yA4p5V/M
	L02I69dQcHToak8zzf8GLdcwzPr10blY4iVEs8Hg1GOqy+oXcOovV3qx1IuNPliDT893OZEcRqdJu
	6LRcvLRnIG+6G/n5NhcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWqHb-00023E-KS; Tue, 11 Dec 2018 22:13:39 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWqHY-000221-7k
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 22:13:37 +0000
Received: by mail-ot1-f67.google.com with SMTP id e12so15691481otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 14:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nN8yAZDGpxllb26d975f2FW9kE9LRcPqvm+QF7joPOc=;
 b=k24a7MZc0fF3vgRNedwfI4Gku+zqghVg6w1Tn3RkFbNS6q5+4tkB42fNKYrZDFx6wV
 CpVARndXhsNWGY9OrKof8MYECzOXh5pfCpijLON6o85I3rkA1kZFsH1O9bpMAnl7kibo
 0AkjBfAh5QaS0safhhW8UbkVOqDsZ//arO6gMpg4g+zZA5QJaBIZUC/BpKhTwi8iT2O5
 YyeUjb4X1YAET4tEIeHW5GmZZZKrOaKxaKHDsKCnnsaIhk53J84u8zHR1ZqwuVBQFnUq
 vxKPr5c2Ze9Az0PhgUIY16cfLqeEaPkCRvUD+eVQY+QH4y7jukG1DnIWk4DFRRwcOEzn
 E9xg==
X-Gm-Message-State: AA+aEWbPWKr1I3g+E9zjx78Nn6yJUtH9eAYIcqOvNuIF1YlTAXp/uDTz
 tasln4x+/Pc5VXprhA87eVaTe9A=
X-Google-Smtp-Source: AFSGD/Uv8C1JmR/imkDYZ5WwaLCg9OTvdh3dGeiuFtsrdtHqo5GwjvmavM3BDdH0p8VZ3WngYxzc6w==
X-Received: by 2002:a9d:7653:: with SMTP id o19mr12342142otl.12.1544566405284; 
 Tue, 11 Dec 2018 14:13:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id q203sm10091438oif.33.2018.12.11.14.13.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 14:13:24 -0800 (PST)
Date: Tue, 11 Dec 2018 16:13:24 -0600
From: Rob Herring <robh@kernel.org>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 5/5] regulator: add documentation for regulator modes
 and suspend states
Message-ID: <20181211221324.GA14658@bogus>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
 <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543319801-19100-6-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_141336_270625_0B7FF8C0 
X-CRM114-Status: GOOD (  17.75  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 11:57:25AM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add documentation for regulator modes and suspend states.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../bindings/regulator/act8945a-regulator.txt      | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> index ac955dea00d1..4017527619ab 100644
> --- a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
> @@ -15,11 +15,17 @@ Optional input supply properties:
>    - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
>  
>  Any standard regulator properties can be used to configure the single regulator.
> +regulator-initial-mode, regulator-allowed-modes and regulator-mode could be
> +specified using mode values from dt-bindings/regulator/active-semi,8945a-regulator.h
> +file.
>  
>  The valid names for regulators are:
>  	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3, REG_LDO4.
>  
>  Example:
> +
> +#include <dt-bindings/regulator/active-semi,8945a-regulator.h>

This file belongs in this patch.

> +
>  	pmic@5b {
>  		compatible = "active-semi,act8945a";
>  		reg = <0x5b>;
> @@ -32,6 +38,18 @@ Example:
>  				regulator-min-microvolt = <1350000>;
>  				regulator-max-microvolt = <1350000>;
>  				regulator-always-on;
> +
> +				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
> +							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
> +				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-min-microvolt=<1400000>;
> +					regulator-suspend-max-microvolt=<1400000>;
> +					regulator-changeable-in-suspend;
> +					regulator-mode=<ACT8945A_REGULATOR_MODE_LOWPOWER>;
> +				};
>  			};
>  
>  			vdd_1v2_reg: REG_DCDC2 {
> @@ -39,6 +57,14 @@ Example:
>  				regulator-min-microvolt = <1100000>;
>  				regulator-max-microvolt = <1300000>;
>  				regulator-always-on;
> +
> +				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_FIXED>,
> +							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
> +				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_FIXED>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
>  			};
>  
>  			vdd_3v3_reg: REG_DCDC3 {
> @@ -53,6 +79,14 @@ Example:
>  				regulator-min-microvolt = <2500000>;
>  				regulator-max-microvolt = <2500000>;
>  				regulator-always-on;
> +
> +				regulator-allowed-modes = <ACT8945A_REGULATOR_MODE_NORMAL>,
> +							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
> +				regulator-initial-mode = <ACT8945A_REGULATOR_MODE_NORMAL>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
>  			};
>  
>  			vdd_3v3_lp_reg: REG_LDO2 {
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
