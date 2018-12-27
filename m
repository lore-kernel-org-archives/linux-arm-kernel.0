Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58618C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:09:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2703520811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ezoz00H9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2703520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2hzWWc18wz2ys0ArlRj8e80pTGESGr+aZnC4H/055Tk=; b=Ezoz00H9svIYnN
	3ZXv9dLZi7AoBSpMoZd2nVlUNjrh9rB35pAlpHZfiTON9n60igBNBeHgM8/z74HwgzavWjDx7dm1n
	Ufp/YTUTg1N7lfpIMxojzS2u/d0NDyegGSPwRlt9Z8Fn2X0t4NKlEKUym+TTcJG7KpJvzuWSX5n4o
	aYkeeYLEnJtYuz4E/bSr9dVweWVWOpZLVQHp0MEBA/wSBMV3oZGwbFsE7ECcxclmX5BdM3Vt/O7PZ
	VB/v+IX5x3SsHcywyt6G96qi6GyluoIi82d0om3t4292VInOp6VvtJKlXDKgI22f9mV6LF24afWcd
	nmpteGYgws906TIMM75Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcdqH-0000AT-K2; Thu, 27 Dec 2018 22:09:25 +0000
Received: from mail-it1-f193.google.com ([209.85.166.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcdqD-00006I-Kq
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 22:09:23 +0000
Received: by mail-it1-f193.google.com with SMTP id z7so26246651iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 14:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Z2ZjfZha2uDoYBpSDCAZu8yTreOdNaRPpM3WOoiacdw=;
 b=ARRftbcpB9/HHIQnUSN9ylktSV1+g13wziCCEpT+FgfWwmJ4Y6uYgfRyCYYHnoZ2ZJ
 8gOxxMK3dMkqny1+xnu/XXmnlnO6Ir/uL34w6zVUndqZI7x7ngFYzSPuMb62rPLNMkND
 t8CViGGuVExaMgFjFOZ0rnxHmdJFNpLuez6Ow4MI3slff0K/HRG99Jga2ckdKWIveaFD
 6XKWTKekScXX1KDqKKRaPGZANq6iPEWI2mM+OtysObiMAWxOxUu6NQ9QubZYLTiasUK8
 Tc+Y8FJItUSaYMBrw57fHppKrvaaua7oVxwi9zPpkCWNLyGrJMR8lxuNNfH/Xhf6sfrx
 IcsQ==
X-Gm-Message-State: AA+aEWbZmzM7kcMrapUqhc3JZLPIo81pF7GtF74F+hOdC3FKguch+hD6
 v0hlKZpZsrCynmusp2zvMA==
X-Google-Smtp-Source: AFSGD/WKyXgNIL/5HZwFM6AqatrUjH1FRad+dRfOLMCaelaT95BP9DbsEO9dL393oo8xCsPHyIRQfw==
X-Received: by 2002:a02:b70c:: with SMTP id g12mr16228757jam.60.1545948548150; 
 Thu, 27 Dec 2018 14:09:08 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id w3sm349102ior.28.2018.12.27.14.09.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Dec 2018 14:09:07 -0800 (PST)
Date: Thu, 27 Dec 2018 16:09:06 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Schaeckeler <schaecsn@gmx.net>
Subject: Re: [PATCH 2/2] dt-bindings: edac: Aspeed AST2500
Message-ID: <20181227220906.GA14320@bogus>
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-3-git-send-email-schaecsn@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545026517-64069-3-git-send-email-schaecsn@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_140921_685885_B3790003 
X-CRM114-Status: GOOD (  24.15  )
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
 linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Joel Stanley <joel@jms.id.au>, Stefan M Schaeckeler <sschaeck@cisco.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 16, 2018 at 10:01:57PM -0800, Stefan Schaeckeler wrote:
> From: Stefan M Schaeckeler <sschaeck@cisco.com>
> 
> Add support for the Aspeed AST2500 SoC EDAC driver.
> 
> Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
> ---
>  .../bindings/edac/aspeed-sdram-edac.txt       | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> new file mode 100644
> index 000000000000..57ba852883c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> @@ -0,0 +1,34 @@
> +Aspeed AST2500 SoC EDAC device driver

Bindings are for h/w, not drivers

> +
> +The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
> +correction check).
> +
> +The memory controller supports SECDED (single bit error correction, double bit
> +error detection) and single bit error auto scrubbing by reserving 8 bits for
> +every 64 bit word (effectively reducing available memory to 8/9).
> +
> +First, ECC must be configured in u-boot. Then, this driver will expose error
> +counters via the edac kernel framework.

Please reword this to not be u-boot or kernel specific.

Maybe this node is enabled in the bootloader or the OS can just read the 
registers to see if ECC is enabled. The latter is more future proof if 
you need to access the DDR ctrl registers for other reasons.

> +
> +A note on memory organization in ECC mode: every 512 bytes are followed by 64
> +bytes of ECC codes. 

That sounds strange. Normally, the memory would be 72-bits wide to hold 
the ECC byte for each 64-bit chunk. It would be inefficient to access 
the ECC byte in a discontiguous location. In any case, none of this is 
really important for the binding.

> The address remapping is done in hardware and is fully
> +transparent to firmware and software. Because of this, ECC mode must be
> +configured in u-boot as part of the memory initialization as one can not switch
> +from one mode to another when executing in memory.
> +
> +
> +
> +Required properties:
> +- compatible: should be "aspeed,ast2500-sdram-edac"
> +- reg:        sdram controller register set should be <0x1e6e0000 0x174>
> +- interrupts: should be AVIC interrupt #0
> +
> +
> +Example:
> +
> +	edac: sdram@1e6e0000 {
> +		compatible = "aspeed,ast2500-sdram-edac";
> +		reg = <0x1e6e0000 0x174>;
> +		interrupts = <0>;
> +		status = "okay";

Don't show status in examples.

> +	};
> -- 
> 2.19.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
