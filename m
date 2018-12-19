Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E658CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:22:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9854B2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ejggb+Qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9854B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t5suKlikrW9dLWIFQ+XJTYKTVeFaFgYMoYjlHUAHvaY=; b=ejggb+Qe0XLo4O
	2B2MrhtxJMVWWMK1d78JAGTfhNKOVbLSHc6z/+g+wlGp0B/qNVNNVPNditXcmzFeEPLnatiVWSmWB
	qL8EMP/PEwj+6049kmddqF4KhGwgJL3oSMoShL+ravB346LVCD5kmSOW3SqykLLk05vTI6VvSr4ks
	NpVt/fE/M+VEpgmmd5zOwmOWHQmRzN5sN9jVw/A54ovwBO88AqaDY0dN8S1xcIprqWLUptXJOh/XZ
	72J5PvkYqQT2akI702DHttlvyOIJciMjAQM47N7rGPMpK3tXYdIpgJykhSjSSdV8d2vPpew7CgwfT
	KwXOz+jeSRxSTrIgyUWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZcjp-0006KX-MA; Wed, 19 Dec 2018 14:22:17 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZcjk-0006IG-5d; Wed, 19 Dec 2018 14:22:13 +0000
Received: by mail-ot1-f66.google.com with SMTP id 81so19231835otj.2;
 Wed, 19 Dec 2018 06:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ASkGQXhK5UigqgkVZTikfy6yutOp5zh9GOy6IF50t1U=;
 b=P5UbIjPxo6MXxNueYqDpqNBY+isBJbbb1LmlQuyH565dRnNJ4J5pe2cHDvtDDRt0kz
 kudM3lCKc2QXVIchodf/uapzXiGzkLU8cKvQr7Wr6fwFSQf7YVO18SU9SeLhPcSzSW9i
 +8kngoUxQOstzp51dGni3xvxqxoU0BhrCWgNbWZyNNbyU8itZlkBAb0GDgkVZjxg0g5t
 6W29nq/uhr+LLlUcjSjsR9U8TY9SIugviO6dnPbhE9OKuDV53h9eARwlIbBJir19hM3g
 YxaLFSruAoFNHEI3w1ROlj5lONwjPL4PEfDwFcGJQWe9mInGNiMtg9T7g9D+2GL74r40
 lZRA==
X-Gm-Message-State: AA+aEWbzdXxowLKqHZVZ5UhWLRaDYSM/vO8GI9t37q6Bb3udxikDVBmu
 vpMo7xkIrzZHprYWSwmQAS1qNm0=
X-Google-Smtp-Source: AFSGD/VjQ85kDeN76ltR7pXDaMXLvYQ39GmIrpHX4jbf434rawhxuKzSU6Bl8nUA+TTa58Pb6T/TvQ==
X-Received: by 2002:a9d:7a8c:: with SMTP id l12mr13485073otn.335.1545229320912; 
 Wed, 19 Dec 2018 06:22:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m207sm9106325oig.2.2018.12.19.06.22.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 06:22:00 -0800 (PST)
Date: Wed, 19 Dec 2018 08:21:59 -0600
From: Rob Herring <robh@kernel.org>
To: Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: New binding for
 Meson-G12A SoC
Message-ID: <20181219142159.GA3700@bogus>
References: <20181203061324.36248-1-xingyu.chen@amlogic.com>
 <20181203061324.36248-2-xingyu.chen@amlogic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203061324.36248-2-xingyu.chen@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_062212_457005_4D35BDC8 
X-CRM114-Status: GOOD (  11.42  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Jianxin Pan <jianxin.pan@amlogic.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Heiner Kallweit <hkallweit1@gmail.com>, Xingyu Chen <xingyu.chen@amlogic.com>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 3 Dec 2018 14:13:23 +0800, Xingyu Chen wrote:
> Update the dt-binding document to support new compatible string for the
> GPIO interrupt controller which found in Amlogic's Meson-G12A SoC.
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt    | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
