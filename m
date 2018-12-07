Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088DFC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:29:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C335420837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I+2hwuzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C335420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0OCJk5XlXTS4W06un9xwkMinxa8si9XNsf+VU+jx454=; b=I+2hwuzKmmuAWt
	KrCCVt1q30/IEi3KEwhoS5DuYuu0ST60gjARI4M6BSieTCG3CQ06E/vsYY1oXgwWOlmuLW7TJvs2x
	f+NVCccEaVZR5hfzwUZ8SJ+p62eQOieKJMaQxp3XR/eYm0J0bKhqh+TzfW8UzgBbUlFdpgBjP5nhB
	SRs3r4Na0ihjcCtiqi3h0r4hFYzMFBbO4LljJjSXAAzub+PSOxIMgxKfd4AixClnqmUY9ueFMuTNr
	oPL1CERt7XvNNiRBOynieQ0Przw1Yvfd2wvdrN2psw3GQHA1PqlE/DFLS0Oj60z3z40MK8T9PMG44
	66F8SKf3f6YM6YNzSl3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPZ8-00083C-3k; Fri, 07 Dec 2018 23:29:50 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPZ4-00082Q-Lr
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 23:29:48 +0000
Received: by mail-ot1-f66.google.com with SMTP id t5so5407274otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 15:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IOMCtzCHH/8bAidk48htasyfLtH4dFYPPTgxZpEhtQo=;
 b=AuZSyv2qtaCTp3z7tgYfGhtnMlymbG0iyjiOwCDbaQ0aGpm0APk8IAKgWWBuAdN8I/
 CcyeQR5ZWAwwy1PD0MG80LCi0xKBZwtZkhyCtLdxcWY/oWaXMEkuNG6snR4gYIjuGDXO
 1x+EdtjgvEK2bOuIZrZ81grlUSesrE8Sy8+SsVBm719MUTPf4FN0Ounz+S5j4eVekabb
 aStOAXtQqBuUikPMk6KQHNBrYpwdhaGLDD+DWaGneiAmZwN6uox5DFCo7HpAFhDHFBCc
 Dit9+3MA0CXsfl+pN4FX1MraTzApS75hJGHNSzhE7nC6iFCSGx3e3kBxZTDW7J9l/wp2
 AK/A==
X-Gm-Message-State: AA+aEWYgFIyY+mnYoVIOHCNaNKcYbdu2oNGJrRbWtB4ihr4xXVh8PNhQ
 myEbINE0DXoVlAFeHZg3PQ==
X-Google-Smtp-Source: AFSGD/XutWZjAnKe0+Mnic6LMqJqqiXswhQxr9nwJpdbAFIyLKnY/cqZJ418LvQ9uTAGWowjAoHOcw==
X-Received: by 2002:a9d:5249:: with SMTP id q9mr2718240otg.160.1544225375950; 
 Fri, 07 Dec 2018 15:29:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id p203sm5250409oic.49.2018.12.07.15.29.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 15:29:35 -0800 (PST)
Date: Fri, 7 Dec 2018 17:29:34 -0600
From: Rob Herring <robh@kernel.org>
To: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v3 1/4] dt-bindings: interrupt-controller: Actions
 external interrupt controller
Message-ID: <20181207232934.GA28201@bogus>
References: <20181126100356.2840578-1-pn@denx.de>
 <20181126100356.2840578-2-pn@denx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181126100356.2840578-2-pn@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_152946_715298_B208D142 
X-CRM114-Status: GOOD (  19.78  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@cubietech.com,
 jason@lakedaemon.net, marc.zyngier@arm.com, catalin.marinas@arm.com,
 laisa.costa@lsitec.org.br, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 thomas.liau@actions-semi.com, edgar.righi@lsitec.org.br,
 guilherme.simoes@lsitec.org.br, mp-cs@actions-semi.com,
 manivannan.sadhasivam@linaro.org, tglx@linutronix.de, mkzuffo@lsi.usp.br,
 afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
 Saravanan Sekar <sravanhome@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 26, 2018 at 11:03:53AM +0100, Parthiban Nallathambi wrote:
> Actions Semi OWL family SoC's provides support for external interrupt
> controller to be connected and controlled using SIRQ pins. S500, S700
> and S900 provides 3 SIRQ lines and works independently for 3 external
> interrupt controllers.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../interrupt-controller/actions,owl-sirq.txt | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> new file mode 100644
> index 000000000000..b3adc4bddf40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> @@ -0,0 +1,57 @@
> +Actions Semi Owl SoCs SIRQ interrupt controller
> +
> +S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,

Listing SoCs here means you have to update this line for every new SoC.

> +in which external interrupt controller can be connected. 3 SPI's
> +45, 46, 47 from GIC are directly exposed as SIRQ. It has
> +the following properties:
> +
> +- inputs three interrupt signal from external interrupt controller
> +
> +Required properties:
> +
> +- compatible: should be "actions,owl-sirq"

SoC specific compatibles needed.

> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> +  source, should be 2.
> +- actions,sirq-shared-reg: Applicable for S500 and S700 where SIRQ register
> +  details are maintained at same offset/register.
> +- actions,sirq-reg-offset: register offset for SIRQ interrupts. When registers are
> +  shared, all the three offsets will be same (S500 and S700).

These properties should be implied by the compatible string.

> +- actions,ext-irq-range: Identifies external irq number range in different SoCs.

Why is this needed? It appears to always be the same.

> +
> +Example for S900:
> +
> +sirq: interrupt-controller@e01b0000 {
> +	compatible = "actions,owl-sirq";
> +	reg = <0x0 0xe01b0000 0x0 0x1000>;
> +	interrupt-controller;
> +	#interrupt-cells = <3>;
> +	actions,sirq-offset = <0x200 0x528 0x52c>;
> +	actions,ext-irq-range = <13 15>;
> +};
> +
> +Example for S700:

Examples are examples, not an enumeration of all possible dts entries. 
So 1 should be sufficient.

> +
> +sirq: interrupt-controller@e01b0000 {
> +	compatible = "actions,owl-sirq";
> +	reg = <0x0 0xe01b0000 0x0 0x1000>;
> +	interrupt-controller;
> +	#interrupt-cells = <3>;
> +	actions,sirq-shared-reg;
> +	actions,sirq-reg-offset = <0x200 0x200 0x200>;
> +	actions,ext-irq-range = <13 15>;
> +};
> +
> +Example for S500:
> +
> +sirq: interrupt-controller@b01b0000 {
> +	compatible = "actions,owl-sirq";
> +	reg = <0x0 0xb01b0000 0x0 0x1000>;
> +	interrupt-controller;
> +	#interrupt-cells = <3>;
> +	actions,sirq-shared-reg;
> +	actions,sirq-offset = <0x200 0x200 0x200>;
> +	actions,ext-irq-range = <13 15>;
> +};
> -- 
> 2.17.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
