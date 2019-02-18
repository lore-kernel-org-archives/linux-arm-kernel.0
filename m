Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967ADC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:00:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA7A217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ltuDNKuO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vcgO/325"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA7A217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iteJPmUXk7EPzjdwbM1SqUBzDYvkJaMCKVzA2D6xOV4=; b=ltuDNKuOi4EV67
	CLyL/vG5ZQiKvNmJcXd7BS1Nh3El3pZw14JEuB4IfLNLs33X1sDWK9xEHSzgvqXamt1pBS9xr1tiO
	tBLmnv6iovdtn4jtEO3Yu/HbAmyPYfv+hqO4rVVINMPe/A8O1nOadKkUiO/P/3hPQ57z4ZpJZVDPU
	iMvAVsL6ZNJ7/KfNTodBwUPyeSw799hSoXAhAZ9bOR6iUlTt3cv7QXrklDBBkiliDgquN1zOs7q1H
	jG2uFEwZ9Fi5CyfbVBkniK7E/4LCTgKtVBXj6rwSi6x48p4BDsJDN6IJRFRa8wNCtE5GdJ9kfcPKr
	ysNmfHtZOSgT0LLMp75w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvp5X-0004u1-2c; Mon, 18 Feb 2019 20:00:27 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvp2Y-0000i8-Ko
 for linux-arm-kernel@bombadil.infradead.org; Mon, 18 Feb 2019 19:57:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VuL8M/buYU86p5J9UP9rJFLjnhT7S5iFxpf0dcOOp04=; b=vcgO/325AV60LDwBNDKRVhEyH
 cY6TXc1BUdiGOLWqfJIyD+hBkJIzDAUpAF92QI65YtNa8tkwm9695/jE/biVJAUz8vUAcYYOSG6VR
 mQ+0Raow0/ZlrI32vkeX6L4eXQ22IGqbRlZT8p0FMs13vDH+R/BcFSVGJTYruCR+vbCQu4r4BioOR
 pPDga3cIA/aRqx0OEHSRpC2IN8ag55TEqreNO/Y5y6E5gg3oSAwi8Siy3Ym7K7H1xT3fK9ueaM+bl
 zkZpgUcZ6rBKAEmFuzYdJsgdFFysbnXdxFw11Z3Iu71clSUIZjr6F1NmN/v5M/nd2r3YcGaboOnrn
 6qdGduT0Q==;
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvp2V-0003xH-Cq
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:57:20 +0000
Received: by mail-ot1-f65.google.com with SMTP id s5so30300046oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 11:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VuL8M/buYU86p5J9UP9rJFLjnhT7S5iFxpf0dcOOp04=;
 b=dbWX7qiO03tF6owCxiLSt7CH6+zpBPYGJQtmvDLEDQFAQpKvGrCa9oEl93KgxlRbAe
 dY5H7xY9TPy3/Y4WHgQfeHPPG8Q1rZhlOaU92a1w7Z08miAN3SBzt3mtHxToM9998RLt
 saGR/b8BHc6jdCXl122+W5tlyZToTvU1HsVN0S/iV3YtJKOK844TqgBMPx0cC6y1Oiil
 3R1Q7c5jvAHEyiMFHl6KghX9J9wD8gvvko63iE5GujUkbcxhdgApdmi2UC+o7z7AU7MO
 rops8Za7K/Pg2+X53fS/Rw4HOHIZIAe2Id8vK6wOJFAjMcHwODtxGqrYsUaXSoNS3Ldu
 GY2g==
X-Gm-Message-State: AHQUAubsz/0388TwnzIxvVUwmxyYxS6v8DA5+T1qMKMAbS1FXjybtaMl
 XfG7+Q4T09d+I5wV2LqfWPcj5qE=
X-Google-Smtp-Source: AHgI3Iac3+nO3BWxXRLG68RaLv+2bzPmd2cppsflZs6ky7GttF4E0zcVaOBbIKnVfXfigURaAPNgng==
X-Received: by 2002:aca:ed06:: with SMTP id l6mr321892oih.7.1550519834438;
 Mon, 18 Feb 2019 11:57:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id p129sm6421789oif.17.2019.02.18.11.57.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 11:57:13 -0800 (PST)
Date: Mon, 18 Feb 2019 13:57:13 -0600
From: Rob Herring <robh@kernel.org>
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v2 09/15] dt-bindings: serial: Add Milbeaut serial driver
 description
Message-ID: <20190218195713.GA18625@bogus>
References: <1549628849-31726-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549628849-31726-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_145719_456863_20B2488D 
X-CRM114-Status: GOOD (  19.13  )
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
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Jassi Brar <jaswinder.singh@linaro.org>, linux-serial@vger.kernel.org,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 08, 2019 at 09:27:29PM +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut serial driver.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/milbeaut-uart.txt b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> new file mode 100644
> index 0000000..8f61c38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> @@ -0,0 +1,21 @@
> +Socionext Milbeaut UART controller
> +
> +Required properties:
> +- compatible: should be "socionext,milbeaut-usio-uart".
> +- reg: offset and length of the register set for the device.
> +- interrupts: two interrupts specifier.
> +- clocks: phandle to the input clock.
> +- interrupt-names: should be "rx", "tx".

Put this next to 'interrupts'

> +
> +Optional properties:
> +- uart-flow-enable: flow control enable.

We already have a standard property for this: auto-flow-control

> +
> +Example:
> +	usio1: usio_uart@1e700010 {

serial@...

> +		compatible = "socionext,milbeaut-usio-uart";
> +		reg = <0x1e700010 0x10>;
> +		interrupts = <0 141 0x4>, <0 149 0x4>;
> +		interrupt-names = "rx", "tx";
> +		clocks = <&clk 2>;
> +		uart-flow-enable;
> +	};
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
