Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ACAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:24:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D16021925
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DXZSuHnp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blybIFt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D16021925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=66Ed7T46raNcWfrvCA3YOkVcLW7yClNZSSgS/bFGdmE=; b=DXZSuHnpozazX1
	+4sYST9M3v9MLJdqwp4A7HlrzQrRunkgPVMs9ES751SBltoe13G3tr1wMMOYIjqhl9/oU4M84LHms
	VG2w1ixK6/9pFBabUnwZ+U90TGLGLkbqcgyNEARebjYQ9TysPZ2Xn3Hsd7CA/GkiIyl3gu1zuBOw0
	smMhAqxV9XIWgrGngKcIz7Bop5ZeuqJtBTUZq6QQC9yX0ISaNS0HFEUlQT9T9KaMUUkWl5JtWTw5f
	pjSeows9WiNmne3JLI6LKyopkMP75C90tUO5pDIqiumRg8odQpUTDDHZr5oYuVIkVw0oHVctTLDbo
	d6vaxfDThPZbQdMJWdwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guXr0-0007zl-PC; Fri, 15 Feb 2019 07:24:10 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guXqx-0007yq-NM; Fri, 15 Feb 2019 07:24:09 +0000
Received: by mail-ed1-x541.google.com with SMTP id b14so7124893edt.6;
 Thu, 14 Feb 2019 23:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RFbQfwT9/wI/RORTUjQ3U5Yg8CJ+8DH8wJ1ahrulbsk=;
 b=blybIFt5OTKxp1WUoiro1xJDcfgPKy9/3NJH9+Y8BpSlL/43pnfgASi+YmKW8qZdyt
 5a6OiGtixLknLzCA8e9U61SLDOVt0kLBbu8dAMpTZVo/H9NUw7hIuEm0fgkrjEWAIMBW
 fk6iUhfEEoy1A5ELuAO0KGYKqSxCdkmKf+mSgbfN5mgJj0hyw20Ni0ZKaNkX4WRPkpuU
 LVuuMsXokLEz8orXgquv+gPY9+jTmYhuwNoQfJBt1uPndj3KKlIagjqty0hmdtEuk5+C
 5cGnpjwYYXm/GeHyHXdZYzTOdLjAzD1Aj4m1suCJmNvLxwAXeuJvF8NC7z5iTndhwWMs
 hybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RFbQfwT9/wI/RORTUjQ3U5Yg8CJ+8DH8wJ1ahrulbsk=;
 b=tIJtSCwQEL/EqK3fqRYy9B6V+BY1G2QDmFmdRPgyaSJBmFAmtmSGDe8ix7GB/ZaOaB
 GJkB1iP6BwHM9XhgI2rVdGy8xXHT33s11J8Z1etO82gEk85vupWXFrsVZDgmJ7w9x+nB
 O3XrLOkAUR+BmiQl3k169rrJQ8A5x1R+PQae2rFNKIjU/wo0X2800OMreuSr6ko6/aoT
 rGnsIfaitJBBg4yyUHXBanBymG1E4dC5+YcvYbYePiAfvIfh/LwIwvKws23lm7g+tPDC
 9STaPodHrMFouDt7CdL4I1CSBX1ffMExhLJr9YhLkQIMhdUy7l1wCuP2PZCqHqAyYATk
 V8PA==
X-Gm-Message-State: AHQUAubjg/qhLwdcYELQ1Oyv1V1oxgWcr8w4mRaHmaz/CwkVWAA1u+nP
 y2847EDzvLi+sW1WC+YzWhQ=
X-Google-Smtp-Source: AHgI3IaRcvNDZ6LrhNsdE+1h3x/aLnoScqSN/glGCsbecY0yiEJlkmZwYgYgQazCUTWS4FPBFufJgw==
X-Received: by 2002:a50:a982:: with SMTP id n2mr6293614edc.236.1550215442691; 
 Thu, 14 Feb 2019 23:24:02 -0800 (PST)
Received: from linux-gy6r.site ([93.176.151.17])
 by smtp.gmail.com with ESMTPSA id z19sm1039676ejm.47.2019.02.14.23.24.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 23:24:01 -0800 (PST)
Subject: Re: [PATCH v7 1/6] dt-bindings: mtk-sysirq: Add compatible for
 Mediatek MT8183
To: Erin Lo <erin.lo@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Boyd <sboyd@codeaurora.org>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-2-git-send-email-erin.lo@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <fe86572e-690b-0e11-cb00-4cfe3a33c5fa@gmail.com>
Date: Fri, 15 Feb 2019 08:21:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550210558-30516-2-git-send-email-erin.lo@mediatek.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_232407_763532_042FA718 
X-CRM114-Status: GOOD (  16.09  )
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
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>,
 mars.cheng@mediatek.com, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/15/19 7:02 AM, Erin Lo wrote:
> This adds dt-binding documentation of SYSIRQ for Mediatek MT8183 SoC
> Platform.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Marc you want me to take it through my tree?

>  .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> index 33a98eb..91aa9ab 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> @@ -5,6 +5,7 @@ interrupt.
>  
>  Required properties:
>  - compatible: should be
> +	"mediatek,mt8183-sysirq", "mediatek,mt6577-sysirq": for MT8183
>  	"mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq": for MT8173
>  	"mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq": for MT8135
>  	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
