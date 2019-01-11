Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FCAC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB9A20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CURkEeC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB9A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TL8IjN3dw5mPLF51ffWB8psAE9ln67psGGwV2O8I3R4=; b=CURkEeC+tAYc1I
	l1/pOSKSoXMdcGXWxi6/8h57LpvyjSm/tl+mVRU6MFRGfNBNesmHffbLlLMSN6nBpU0toYHxortHl
	XIjkEMXrDK+nJG/GSAhxGa3EH27FP3JiIn52PEpF8Yhy3//4vRFXyBBLcoyXnZngh1QJefWTxRqxh
	Lmwc6XdvXGUi0Xtm/SGD/xvpgK5/WGtnFjqtx4F1IdToKKrgIjgLoIFjto9E0BwTjiHcyddX5iXo8
	Mqjlmroic0zBCEg8wlKCpHB27mpXdyNF0g/QMASaxvc5EIXeizFxaZ8wGojUlEmaa5+un7a63G1E+
	sb3UvoN9pZLyLpNS7l1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyEr-0002w2-Pm; Fri, 11 Jan 2019 14:56:49 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyEl-0002s4-UM; Fri, 11 Jan 2019 14:56:46 +0000
Received: by mail-oi1-f195.google.com with SMTP id y23so12401720oia.4;
 Fri, 11 Jan 2019 06:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dOZ7ydKjrFInmblb4snE5E2ZFfXlu7+y0nbTinIkDn0=;
 b=RHrXS5DJhUil/G1yHitnXton2T6Mw91Gx96hNe9AEj5Nq0zMe1r2QWQxjfus1St2sb
 Gl4AcVnKZnmRcgwUs9IbkZ/BcDIgfYeqwtvSfSaUu9/HJfTUME93MnQ/S7chymaymCKi
 k5kdbY4euIK/n/qjFDSlYB3dfjP4D1e3D9S8WOSSawohlbVpDg/qqmEVlXN/75JhkIM6
 HxZUUAT2XDhgkvLmhEvz4mfLXOabdoKlBnCMwNpZ9XZjQuQfVAHp6vmRKBGkEY3TwS1M
 SGSKKx3MTeLTVuEcEmjDhAFkjGlvI20GDS5szm5HkG/FPfuOLTgb4QIx88VF6/oY6jFB
 p2Eg==
X-Gm-Message-State: AJcUukeYCisOnhSFrhbmPdACObl4Hq4nzCPIz2Q/wzRMXVZr+WP5r1/Z
 gb2fgfKMb8bi8gvTYKW/Jg==
X-Google-Smtp-Source: ALg8bN6MHh/sH867VMmlp3MFoU+z+L15kBA8wRT0Ao/QgxP+nngTy5tg2TecIHSSwviwWTPgrZzHNQ==
X-Received: by 2002:aca:bc42:: with SMTP id m63mr8971423oif.323.1547218603102; 
 Fri, 11 Jan 2019 06:56:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id k13sm59192406otj.19.2019.01.11.06.56.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 06:56:42 -0800 (PST)
Date: Fri, 11 Jan 2019 08:56:42 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 2/6] dt-bindings: clock: Add DT bindings for Actions Semi
 S500 CMU
Message-ID: <20190111145642.GA25726@bogus>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <20181231185517.18517-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181231185517.18517-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_065644_307506_D49E09A5 
X-CRM114-Status: GOOD (  14.15  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
 afaerber@suse.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 01, 2019 at 12:25:13AM +0530, Manivannan Sadhasivam wrote:
> From: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> 
> Add devicetree bindings for Actions Semi S500 Clock Management Unit.
> 
> Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> [Mani: Documented S500 CMU compatible]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Rob, I have removed your Reviewed-by tag for this patch since the
> earlier revision contained only bindings constants and lacked the
> compatible documentation, which is added now.
> 
>  .../bindings/clock/actions,owl-cmu.txt        |  7 +-
>  include/dt-bindings/clock/actions,s500-cmu.h  | 78 +++++++++++++++++++
>  2 files changed, 82 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> index 2ef86ae96df8..86183f559022 100644
> --- a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> +++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> @@ -2,13 +2,14 @@
>  
>  The Actions Semi Owl Clock Management Unit generates and supplies clock
>  to various controllers within the SoC. The clock binding described here is
> -applicable to S900 and S700 SoC's.
> +applicable to S900,S700 and S500 SoC's.

space needed after the ','.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
