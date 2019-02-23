Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83128C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:42:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C22120651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UJ3bOa9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C22120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MeXKJaSB5g0/33w3Er34nW6b3uAAnBvSwGczP8UQHhs=; b=UJ3bOa9+9WR2oC
	O+dEJYh/3BjgLyObNMX+Pd+Xa0uXKdBZtjecOqE491EqUzCJuNz0bhNo9Uiv6y4iNFhWchSUISeD1
	OniHePla/YFYEhnLm0YQlsqZZB9tXQ9FMRxT2f5QLOfeb0yGamVHXNYNo77owAaaVD6kGuD2W8L+v
	uBQ+2eqzpAiX9iTYXo0fqLt62WUP9JoBABDmnOshSMM/SmGqW6FeAyfvKJ6iAVSm9JE5IKv/Zd8Gt
	q+9soWMC995GA9dDzQsztCGs/4N+7xHIBGEKbPIUAxCXlIZGwdFYYXCJXqSP/dL7jTSf6tHk7YueJ
	1goZ9cQ/rAR3Dk4Y8jxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxLOF-0000zH-4F; Sat, 23 Feb 2019 00:42:03 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxLOC-0000yj-Aq
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 00:42:01 +0000
Received: by mail-ot1-f65.google.com with SMTP id q24so3472827otk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 16:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zjGa3LcACF7RBvIsVdRRc+fHJyiXguROSnHJ+OVHLkY=;
 b=UKTkzRDjxIa0Gc7bowAddF8bDkGIf3p+pGZqsucYQWQTTRNn5FLNiLigrEOzvQxT8i
 61IKKFbI0aEAoLGgDM12FQGUEzV5oe7Zt2/ItPkyv+2PvMo/blKH2sjOUDTlktHNxrOV
 4WzUW9Ou0MVgqXAIhAnb5kR46BIOS7tVn7BsmszUCzM2gKrnlutLPRQOF31YHa9uNvWe
 1i0nNw5AmvVN+ezThTWEpKxuMyuEGNL0ERmFWgIR/paCqAlAhNxm7kjIXAnq/6drgRB+
 GCY9Zu8YmfksFOkiTO3jKWtUW4+Cs/5ohSDRc3jjlSa87UpMAY7ZqyCuU2IS2qmSEIsO
 ikCQ==
X-Gm-Message-State: AHQUAuaZFjEr8Ilf53aecPjwb/xDaGYDZgZQ0dQQBUPOoW4x1vgYGHID
 0/ivD6YHTgq78KEXoIVUHA==
X-Google-Smtp-Source: AHgI3IYhXF9NsxxEAl7/e4LKtAIWWUDCgz7FVUIK8waWIjM5fgefMFODcSZ84lzgMSRaLeMlIK6FOA==
X-Received: by 2002:a05:6830:193:: with SMTP id
 q19mr4600655ota.278.1550882519090; 
 Fri, 22 Feb 2019 16:41:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s12sm1206973otk.0.2019.02.22.16.41.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 16:41:58 -0800 (PST)
Date: Fri, 22 Feb 2019 18:41:58 -0600
From: Rob Herring <robh@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 1/3] Input: lpc32xx-key - add clocks property and fix DT
 binding example
Message-ID: <20190223004158.GA3951@bogus>
References: <20190126142921.16041-1-vz@mleia.com>
 <20190126142921.16041-2-vz@mleia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190126142921.16041-2-vz@mleia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_164200_368435_F863CEEC 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 26 Jan 2019 16:29:19 +0200, Vladimir Zapolskiy wrote:
> The keypad controller on NXP LPC32xx requires its clock gate to be open,
> therefore add description of the requires 'clocks' property.
> 
> In addition adjust the example by adding description of required 'clocks'
> property and by fixing 'interrupts' property.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/input/lpc32xx-key.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
