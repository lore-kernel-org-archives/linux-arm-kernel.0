Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69516C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:52:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B105217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RK+WytZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B105217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cr26g2l4Lb5eTRM/GnNTGj6v0dWmpmgG3is66vYkFwI=; b=RK+WytZsZSpP66
	XMUz3RW2mNNBN0qPKhVGkU4Hwy2T7nqRlyW5KgWo4HmnfM/Y0rQE/nVgSNPmJCGZZR/9omIUoL9RU
	YxgOliAe8g4sWuW6KVTx0qjociC1RZqKc2XVlQH2yn3lURvIi/KKlcoh8Kw3Ox9cvVDiBHeYTWcEU
	C5K8AOaP4+5oC49I43HtH8KfTkppJZmF+6oKdu8jkbqEXsR5ZSUPL0Q0Zlr+UK+38wiWwK0Ssec6k
	x0kmWDlvmtsYNQ4UgAVsqRqM51f6q1oCFjZJ5SdrDOzTX7Tzk4/xQF95uPOgVfvJXHLwD3PrUY69n
	k30hOWe3DLPUzGmTJOgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvoyD-0003vA-CK; Mon, 18 Feb 2019 19:52:53 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvoy9-0003uf-JK
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 19:52:50 +0000
Received: by mail-ot1-f65.google.com with SMTP id b3so30289123otp.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 11:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dul4gDcTcJLKAu48vsv5MVk63uYOFdmwUVkWPuXdNcg=;
 b=MSXY6e3UaY7CXH86zOQTzNK14tIISGqp+25fR4FEZatCDldHAuCOKM3GnVTas3odUh
 bZh50wIW10ZPPJ1aehB033Jcg6g9azfzOxb4zDWfJf81ZOPCorArrvg8NkzNs7JD8hHq
 t7Tpy4/i1omAak/rFur4sxeUSqBI9YykfempnDiq95MqbcEhtFn1ITholEyTFe5Hok7Q
 OuC53E2Sm3GoDE/PuD3Vecsii05EQMaLVKs0mRvvCt0vMAgKO8oprOIT9OgombRwcnM1
 QVTSQBAZilV7/zBo8QIVgtqP8M2bTQ79iIPPPAgf5zM7YxsHbf+UBbWoW2H74YY6XL8/
 BjDQ==
X-Gm-Message-State: AHQUAuYLhMoQv6HbT8CvnD1vRIm6quh/xazxuCXe0dXy3DsWP0G0Rk/S
 O8p92i2Q3MWZ8jelY5HowA==
X-Google-Smtp-Source: AHgI3Iandc2NMqRfUvwDzmyh3cKf7Cu7hQrQU0sHviPbQ7LxyG9r0nntfq2Y67NXzIaDIBcfSCQBRg==
X-Received: by 2002:a9d:152:: with SMTP id 76mr16553146otu.259.1550519568890; 
 Mon, 18 Feb 2019 11:52:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l108sm6113513otc.23.2019.02.18.11.52.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 11:52:48 -0800 (PST)
Date: Mon, 18 Feb 2019 13:52:47 -0600
From: Rob Herring <robh@kernel.org>
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v2 03/15] dt-bindings: Add documentation for Milbeaut SoCs
Message-ID: <20190218195247.GA9690@bogus>
References: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_115249_638664_2912DDE5 
X-CRM114-Status: GOOD (  17.17  )
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
 linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 08, 2019 at 09:26:04PM +0900, Sugaya Taichi wrote:
> This adds a DT binding documentation for the M10V and its evaluation
> board.

Most boards/soc bindings are using DT schema (yaml) now. We're not 
requiring that just yet, but I'd like to not add more. So can you 
convert this to schema. 

Rob

> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  Documentation/devicetree/bindings/arm/milbeaut.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/milbeaut.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/milbeaut.txt b/Documentation/devicetree/bindings/arm/milbeaut.txt
> new file mode 100644
> index 0000000..9fd053a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/milbeaut.txt
> @@ -0,0 +1,6 @@
> +Milbeaut platforms device tree bindings
> +---------------------------------------
> +
> +- Milbeaut M10V Evaluation Board
> +    Required root node properties:
> +      - compatible = "socionext,milbeaut-m10v-evb", "socionext,sc2000a";
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
