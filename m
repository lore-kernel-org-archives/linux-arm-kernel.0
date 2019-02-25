Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35EAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:53:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8AA20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="br23V3Iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8AA20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ye/wZlI5VTPpQvlR0J+psfhcXLg8H562Ee6q7UyoYZ4=; b=br23V3IzzOsBQ/
	40LHUQJbhiZ+5pGZ8LcurSOqOGmA3FVrZKTABQOJ3TQeXKvgqiRLTgr1qugFOSw8Vcebp3EqMtxtx
	1nbksz2/LKSEDiKCnKUfXNE3Zt73ldoJtwl03gAG9HhftaOMsAJj9tVacAA/YdVUrgMcbVcON0rNJ
	51AuZ3NSJVp3yWgzE01DQWfGjsHSfzIDlmzXgxt/OptHc7IelFHYDL9mpS9eYNYUvpf6YzDx5oXrz
	MiACNodvoodNo85F8qqPahrmT6a0ix5AxF3M8yct00cJARb4swfKxRxj+2pu+Yb+SWqeZolZjuvZz
	tlEFgJuWvwcL3FxKGCDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJVC-0003qS-4B; Mon, 25 Feb 2019 16:53:14 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJV9-0003ps-49
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 16:53:12 +0000
Received: by mail-ot1-f67.google.com with SMTP id t7so8404626otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 08:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8CIZ6kZBu1TZgHpB6AGWCKL+TVXxUEmUGJjZB7ZF4Sw=;
 b=SFFk4LEwbDRgaQCKvrILY7ZFM88uvq+s5ijGPH96ibDZkIjqzhU+KTM7UwlyVsXppY
 x3mKdiLdncDdxah/GWJvbdxQbzt2+U5nMDHKIqn14aMndsIu8NfNGIB4OeIK8HT9OluP
 Td3uauiAyuz7WhTLfp2DTfK2hBex2v7nLqBHXILa7ScHWAvNjHU+NRW33Tqh2h6zlmxK
 yi1vhaIhbsjpIwEkysVVljrLl6RD0atgVJSQl1OA7KpS4sRehBrhI8OrvoUeaED2YDiA
 Im4133bxQ8RYJACLzsTDYvjSDNa3r+1eoBpozsCmBrBSqHv3sG3CqJt0C7cxFDrhAZ+Q
 Qv+A==
X-Gm-Message-State: AHQUAuZuL0XUVRwTSuuqrFNzmDensmT/y6CmK7EBkDHGEcnNDGBvY7La
 gR5O5ZSyXzcdHlgcCcTHtA==
X-Google-Smtp-Source: AHgI3IaeSSxCMa9nMXe3qaDYnwDKmYUw1l5TNoVBh3WHVzVCS5vaJFU040tFbrpHbTUG+vGt+abUsw==
X-Received: by 2002:a9d:3f7:: with SMTP id f110mr10226971otf.174.1551113588926; 
 Mon, 25 Feb 2019 08:53:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d10sm4187293otl.69.2019.02.25.08.53.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 08:53:08 -0800 (PST)
Date: Mon, 25 Feb 2019 10:53:07 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: Add STM32 factory-programmed romem
Message-ID: <20190225165307.GA26260@bogus>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
 <1548866336-14765-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548866336-14765-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_085311_164471_888A4277 
X-CRM114-Status: GOOD (  19.10  )
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
Cc: mark.rutland@arm.com, lionel.debieve@st.com, alexandre.torgue@st.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 srinivas.kandagatla@linaro.org, mcoquelin.stm32@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 05:38:53PM +0100, Fabrice Gasnier wrote:
> Add documentation for STMicroelectronics STM32 Factory-programmed
> read only memory area.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> new file mode 100644
> index 0000000..fbff52e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> @@ -0,0 +1,31 @@
> +STMicroelectronics STM32 Factory-programmed data device tree bindings
> +
> +This represents STM32 Factory-programmed read only non-volatile area: locked
> +flash, OTP, read-only HW regs... This contains various information such as:

Several distinct types here. Does s/w need to know the difference 
rather than just one generic-ish compatible? Access size restrictions 
maybe? Ability to unlock and program?

If not, then why even make this stm32 specific?

> +analog calibration data for temperature sensor (e.g. TS_CAL1, TS_CAL2),
> +internal vref (VREFIN_CAL), unique device ID...
> +
> +Required properties:
> +- compatible:		Should be one of:
> +			"st,stm32-romem"
> +			"st,stm32mp15-bsec"
> +- reg:			Offset and length of factory-programmed area.
> +- #address-cells:	Should be '<1>'.
> +- #size-cells:		Should be '<1>'.
> +
> +Optional Data cells:
> +- Must be child nodes as described in nvmem.txt.
> +
> +Example on stm32f4:
> +	romem: nvmem@1fff7800 {
> +		compatible = "st,stm32-romem";
> +		reg = <0x1fff7800 0x400>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		/* Data cells: ts_cal1 at 0x1fff7a2c */
> +		ts_cal1: calib@22c {
> +			reg = <0x22c 0x2>;
> +		};
> +		...
> +	};
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
