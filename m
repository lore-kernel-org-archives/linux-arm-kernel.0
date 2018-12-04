Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036ABC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:04:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C954F2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hI0fSPvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C954F2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=slJogfNwz/WcUAjCa2RwKK8TgClNSoHGTSsFj2p/tQI=; b=hI0fSPvYnD9ymt
	w4q+JFC6pzE6wKVzKfZhAk2DxXLDDynUAfaPULse5aDNcEJRJERds3AlDXdpis/gTqfo8DVfwynzq
	+G+IDEYc82FEphGLdhiYmkXhogKPLQiUdatR4yLyeHuo/TNYf+DdGjSaO3jSvag+GIpPIgEih20Fi
	+DUZVGyxJCGS03+0fPkAd/vobbGhevYWXmsyf58qIgXyNUdJ5Skjix3Vh7oOoOFADgA2bqmkCjSIK
	s0XJY23pF9Za+VUBpLqMOWjGgPOfcjcq0/cMplRY4BAUvktFsz6SZZMFuvt3imvctF6+uHD3QKDP4
	moW3VA/HKsuGHy/zLRRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUJje-0001M1-Fn; Tue, 04 Dec 2018 23:04:10 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUJjb-0001L9-Qa
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 23:04:09 +0000
Received: by mail-oi1-f194.google.com with SMTP id y23so15888499oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 15:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uurCF9stpgUWLdN/+O0Avc2znMI1EjioC+IV5uSeN6w=;
 b=umY7o+dqmudAHD2xBH4kFkgU4e6/vmQ08vcD1/MPJl3JJWGP+K+Ch6AlJ6dzJQYji5
 0DbpQLr21jZ2qbfTF7oSetrExcCRNkybXA5O8I1zbAL61djemXBQQKU9/FgQ1jAQk3qk
 ZDo847wwcY4E2Cz0AWqQ6JDZhqbDM2aHVj3xOUJTB4JMqMxACHDU4PE1NRkCpCuVlVH3
 8l64x2syv/pB6D1/a9LVEH48t3ANGlCgndttwlgkYL9HmGMXJwkf0Ut054N7T1xt4nsb
 lP7QBsfd5aXYKyVldpkQS2jENFgh5WDg7zUQUaGNY1djaGFU9zEGYqolGK+ZvIXUdY5z
 SPMQ==
X-Gm-Message-State: AA+aEWYJwu9U8m16FsI2TXsY/8J1zCQw/tIYMpkYSJP6NXwkK10+DOR5
 WMcvi/J9r7SByUiA/ieC2g==
X-Google-Smtp-Source: AFSGD/XkidUmgMaieg28TxC6FZr0clsvrMO0F06X6pEJn7D2i4sik76czRBTVsvb2LiAowIS12Pt3A==
X-Received: by 2002:aca:2108:: with SMTP id 8mr14027635oiz.171.1543964635862; 
 Tue, 04 Dec 2018 15:03:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m207sm8008320oig.2.2018.12.04.15.03.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 15:03:55 -0800 (PST)
Date: Tue, 4 Dec 2018 17:03:54 -0600
From: Rob Herring <robh@kernel.org>
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: Re: [PATCH 04/14] dt-bindings: timer: Add Milbeaut M10V timer
 description
Message-ID: <20181204230354.GA26204@bogus>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_150407_863166_36AC3128 
X-CRM114-Status: GOOD (  18.48  )
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

On Mon, Nov 19, 2018 at 10:01:09AM +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut M10V timer.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
> new file mode 100644
> index 0000000..ddb1b31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
> @@ -0,0 +1,17 @@
> +Milbeaut SoCs Timer Controller
> +
> +Required properties:
> +
> +- compatible : should be "socionext,milbeaut-m10v-timer"
> +- reg : Specifies base physical address and size of the registers.

How many register ranges? Looks like 2.

> +- interrupts : The interrupt of the first timer
> +- clocks: should be "rclk"
> +
> +Example:
> +
> +timer {

timer@1e000050

> +	compatible = "socionext,milbeaut-m10v-timer";
> +	reg = <0x1e000050 0x10>, <0x1e000060 0x10>;
> +	interrupts = <0 91 4>;
> +	clocks = <&rclk>;
> +};
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
