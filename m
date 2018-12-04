Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B2FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:11:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9EE20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pVwU+xOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9EE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5ID1iSKJ18V0K15uF15yVBlY1E2BK1Gv/AhZUKGkxvQ=; b=pVwU+xOm23gsng
	ndtPdVj1CcpDBodl35PlS6M/ZOhYhR/kyPDpassg/X/Wpa94k4OBri09s5SXJx7gtAQQVFUGxYEjR
	6Yc8kPO+j8i9DtjK4Ux2Is9zT1rIAoi3qnZ7s+LIUPx9cmqd8ckpIWSXzqzEtU8lDVsi9ou+0e5rW
	Onw3Q1gnFHKzLexDa4U2FKAz3w3Q85lhbHVBrZQKyWoC9L4oTHsZNGXJjRN0G4YP8SB6XVYgLbhkI
	T4bt8x7NUsVz7gj0NjDNIkCwijP0/BUIcRsIdzYhwgIl1sbjPrk7yDQyEMPYtiJnKeNzyfsfwnfrn
	0ZH+pyax14aUISgUIGbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUJr1-0004cd-DN; Tue, 04 Dec 2018 23:11:47 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUJqx-0004bk-NB
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 23:11:45 +0000
Received: by mail-oi1-f194.google.com with SMTP id u18so15867385oie.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 15:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qJA/lf2BQ+t4mD/2hPPscyxkybJ+i2gt51zx4tVD/Vw=;
 b=fiHrkjKSlrnFcX2ONiZuENHrI2e9YbfyEb0kmVXGG1SsxAbfddPFfQKDF/zAwcc6bo
 DQZEIwk/jaSPmXoyBMA9Dq4e7JxpsyGv5GthGps8Qwwa/REHyF6QhbwZYS6nO/UtBfqn
 lIMKCjHxQoXn8gx2/54yJKdhLgOTda6Eze8X11hEoaUtYGErSZOqtqeJ+22FIQcpFMB9
 edoXCLtMeKbHK4vuhKTeYDlMFDUnCSh9J+aEmNrjS5ErNyXbTL0Z/RKiK/DtpNrdbll/
 4mgq2W/JfbzVz9tS2vAWrVKUVTt94VCFrfYEVqtLelgwvdbCgnUDM6xLDl6jA87rdWY7
 AkXA==
X-Gm-Message-State: AA+aEWZmr+/kYSJkJJ5hwSTpdtcXPT1gxYp/e+vBK7lHx+wLZzqpn7Mk
 G/XIACteMzst9o66BdI/zg==
X-Google-Smtp-Source: AFSGD/VDNr5BlwFMNeTRMQ3ls+9GmY4a9vNS1NDB5ZlOmoIfWPH3Xvso6OmYIKMKn6Du50LqTKQ6eA==
X-Received: by 2002:aca:d509:: with SMTP id m9mr13147961oig.82.1543965092967; 
 Tue, 04 Dec 2018 15:11:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id k207sm15083390oih.58.2018.12.04.15.11.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 15:11:32 -0800 (PST)
Date: Tue, 4 Dec 2018 17:11:31 -0600
From: Rob Herring <robh@kernel.org>
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: Re: [PATCH 10/14] dt-bindings: pinctrl: milbeaut: Add Milbeaut M10V
 pinctrl description
Message-ID: <20181204231131.GA7366@bogus>
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_151143_752694_8592D99A 
X-CRM114-Status: GOOD (  19.64  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 19, 2018 at 10:02:12AM +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut M10V pinctrl.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../pinctrl/socionext,milbeaut-pinctrl.txt         | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
> new file mode 100644
> index 0000000..7469189
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
> @@ -0,0 +1,33 @@
> +Milbeaut SoCs pin controller
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "socionext,milbeaut-m10v-pinctrl"  - for m10v SoC
> +- reg: offset and length of the register set.
> +- reg-names: should be "pinctrl", "exiu".
> +- gpio-cells; should be 2.

#gpio-cells

gpio-controller?

> +- interrupt-cells: should be 2.

#interrupt-cells

interrupt-controller?

> +- clocks: phandle to the input clock.
> +- interrupts: three interrupts specifer.
> +- interrupt-names: corresponds "interrupts" factor.
> +
> +Example:
> +	pinctrl: pinctrl@1d022000 {
> +		compatible = "socionext,milbeaut-m10v-pinctrl";
> +		reg = <0x1d022000 0x1000>,
> +			<0x1c26f000 0x1000>;
> +		reg-names = "pinctrl", "exiu";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		clocks = <&dummy_clk>;
> +		interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
> +				<0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
> +				<0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
> +				<0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
> +		interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
> +				"pin-52", "pin-53", "pin-54", "pin-55",
> +				"pin-56", "pin-57", "pin-58", "pin-59",
> +				"pin-60", "pin-61", "pin-62", "pin-63";
> +	}
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
