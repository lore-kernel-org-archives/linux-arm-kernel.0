Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D9FC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:57:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA242081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oGR0bt2J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7Av88g1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA242081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y5a/8lfGsYRVn5YPr2jYETr9dquT5BNvpQFAV4xdEOQ=; b=oGR0bt2J+k+0d/
	9tVmSYnEY4+KS5OXvZskJ1Kkiziv/v0rcvKittwZn1hVCUr9yL21DShyF+jue2Eo4/Tb/HQs5en1N
	IxDyPDspW33Pxwy58B5FQtwglzo4YNurgKTPhhlRA36/KL1ZKWVUKhwZR5ChszFospzx6A0JuSr2A
	GYqp2cFlKBjBCTHNE6YRzhHEt/rXTIwRUhC4iKmcVV2A0FAiI11nnWpMdu4CO7cDLUQ1gHxAxOnc/
	k8SHD07lo4p7D/78vdAVf05/8Xy8sNmvH9uqDkinAlDkjdC72bnb1GbXroX2Wv1w/zdCQj8edY2yo
	l02o3V9KWs5PCf5ybWdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIJQ-0006J0-6L; Mon, 10 Dec 2018 09:57:16 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIJN-0006IJ-4b
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:57:14 +0000
Received: by mail-pl1-x642.google.com with SMTP id w4so5024701plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 01:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=aSomdyy3EaiujdjdjsH4y6F6EHOmtCoGU51caHsh8d4=;
 b=N7Av88g1UvjcPjim8avN81M3OjXNaLJ0Fm1sxgdz8Eq2ngWZs03oDbbCo5PfdQOuM1
 N5krfWb0w3XswkGmbz8whbg3mIVJOHP7F5+yrejxk9KbX/zR0+EJdW9Xqt0KFeA0qMoA
 btF+ZZI3CI0IOr+26iGEKtVLbuR8/JrKqTqGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=aSomdyy3EaiujdjdjsH4y6F6EHOmtCoGU51caHsh8d4=;
 b=tfh/VNLdzID/T4kdpWB17lKBn7rCNxvRJt8szu3mDMqlNvW7Z0/MOfb8sPPV8Y2UEa
 u+3mkfzVykSW/7tXCLqhvlnW3XAbanxvoBH6l6PuBop+z1lhOLYV2Wwrxp6ymqBQupFv
 I6Pp1SWGBkxmauiWaJsRHH4kgLj6b2jASuivaAiC3CIXM3+ypXkz9CwrhKJZTDbJEXq+
 gM1UCm2a0r6wK6IrT/675J1DFbnQ3QbImc3rAIsk1IYKJj9Luipb93oOu214JKkUpE7W
 3OCiddJe++Jt5CmzyOzIN7sKYcJEa/Sk4BYKiB+UZIVZzxZnrPMSkmOJcuZk/kOW3Iro
 x4cg==
X-Gm-Message-State: AA+aEWYEMkkt9QdbLHt0KQQl/hPcHvqIr1cbGfpaitLM+q5q8I36p9Pe
 Cl69gWfZuYnCzBEciUbKrIS+
X-Google-Smtp-Source: AFSGD/X/T5V1y6iWHcpu64JIzsF7hljVycLkNOjZ1OkL1i4+ZYIL4AzPPYkLsfXETBRrk2ym/Vq8Qg==
X-Received: by 2002:a17:902:d911:: with SMTP id
 c17mr7354836plz.151.1544435821756; 
 Mon, 10 Dec 2018 01:57:01 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id p7sm26710697pfj.72.2018.12.10.01.56.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 01:57:01 -0800 (PST)
Date: Mon, 10 Dec 2018 15:26:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 08/15] irqchip: Add RDA8810PL interrupt driver
Message-ID: <20181210095650.GA12397@Mani-XPS-13-9360>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-9-manivannan.sadhasivam@linaro.org>
 <9debdd34-0c4a-a0a3-a284-b6372c2f7fd5@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9debdd34-0c4a-a0a3-a284-b6372c2f7fd5@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_015713_201186_2A4ECCC0 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: devicetree@vger.kernel.org, jason@lakedaemon.net, arnd@arndb.de,
 gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, robh+dt@kernel.org, linux-serial@vger.kernel.org,
 jslaby@suse.com, olof@lixom.net, tglx@linutronix.de, overseas.sales@unisoc.com,
 afaerber@suse.de, linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On Mon, Dec 10, 2018 at 09:39:13AM +0000, Marc Zyngier wrote:
> On 28/11/2018 13:50, Manivannan Sadhasivam wrote:
> > Add interrupt driver for RDA Micro RDA8810PL SoC.
> > =

> > Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> =

> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> =

> Given the dependency on the platform Kconfig entry, how do you want this
> to be merged?
> =


Hmmm, I think I can just move the platform Kconfig change to SoC changes
in next revision so that you can apply the driver independently.

Regards,
Mani

> Thanks,
> =

> 	M.
> -- =

> Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
