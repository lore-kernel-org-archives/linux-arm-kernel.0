Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C514C6783C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674B92086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HUPNpdLL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mihBuv1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674B92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GH4Okwos/4/EapiDo0Y3fh4dzKuAlRArAhyT2OVKCrA=; b=HUPNpdLLQZDF9S
	Yp7lk7HJd1R1ReMP8vi7UNE1gBLeLcSKLLLZG0XFqCyVH0d/5h4qDWrK9SnQTaxt5Hjd/fTM8WQTV
	w4TyUpMoTVRVxo986RIAn1fHSBPUJgD++W4SCtXxs2LCg88p8mEMPrnwNAYkmEf1qbIdDJBaEMf5M
	LKN6k00dmolt+A38mt1tn/EaIVB4RwiyIVsM5ydERn/0agGZGKKiOAERd90ySZEZOohstc1CeW9Dc
	RFxHp3CEWSN+k5vXboofBUVakJnKbV+IMrKsWL/dREA0iC6emutxi1u3aVeiup0zcLWp1D3umCD0k
	safHI6r5s6zqS/NIJRLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWqJl-00049b-NR; Tue, 11 Dec 2018 22:15:53 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWqJh-00047y-SO
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 22:15:51 +0000
Received: by mail-wm1-x342.google.com with SMTP id m22so3926559wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 14:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=D6xoD625oZNi4kT/b12vQt1b3p5+/KEL218mj96sS9w=;
 b=mihBuv1zNj9n9r+fyXxH/1F8DQq+Ejmk8vh++xY+HOGJ3Q3sqEelfN5bFooyTJVcCu
 QY7JGQgZP7ZE0WetWjD/GSFyYVJ/UCQ/w0lzirh0r/JTkGJ2aDZBQTXqnKjbJWtyoFMv
 7Bq8XH+rNQEvix5DC5+Nojgu02rIkj+RMCSA5FsAN3cAEx+IwNGsraXlWGApMSBpyul1
 ljdB4O/juIH/hCLRdez5gq3Wffp9GMN27z55ZN7qY6Yw5DrOJm9RTZJC+aUw9rO4/5tX
 hydSfXSyBPaUBhUubjCxr+Y2PemlsvAdKRfN2ncD2pWKYXn8vOxOanTIB3ExiICdPWD2
 DSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=D6xoD625oZNi4kT/b12vQt1b3p5+/KEL218mj96sS9w=;
 b=muzaBnTexRNaulqfU1FXSC0FsW7GP6QSc4lHbtSpQ38lvYY0cildwFtPCXbgJ+Y6Sq
 ouGwbdtWeLWzQwK6UzwRlAgEPpFz17ABD46zSh3HjFow3Hmhj9/DC/ODrCMghRD7spqt
 p3jIMHh0U5UUQ2DTgdfZRI1Xi7QrehM2EYYnXI9VxWq9E7M9DXpJGqHjaVcXYWK0nUE8
 P6cdrHaN+8LQC7zbhjEhp+q5Vz/RPs5P0dnqtyxi9XpaUq7uhHVH+OzH5fzCb9kELf5e
 V0J7SYTdF1rFhw1mSmD/TJhMuigS3Hrf5AbhmHQv3nqxTdxNONE2jw10O+furB+H+CB+
 eCVw==
X-Gm-Message-State: AA+aEWYViiKaCV6M+9/xddATfAeHtqM5u09f2zp1HBdoRXxA9TumR8oc
 f+SHEMg7SUBs96f3V9JhVG0=
X-Google-Smtp-Source: AFSGD/W99q4hL3XgXGWh7Ii1ngZDqHUJdj6vzGZjVkSqVHM4tHIHAa6katv/P8BByxPdcZAGn+k1+w==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr3879047wmd.89.1544566537713; 
 Tue, 11 Dec 2018 14:15:37 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id x20sm1937176wme.6.2018.12.11.14.15.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 14:15:37 -0800 (PST)
Date: Tue, 11 Dec 2018 15:15:35 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: next-20181211 build: 1 failures 32 warnings (next-20181211)
Message-ID: <20181211221535.GA20165@flashbox>
References: <E1gWnrV-00086U-3m@optimist> <20181211220620.GS6686@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211220620.GS6686@sirena.org.uk>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_141549_974423_F3194E70 
X-CRM114-Status: GOOD (  14.02  )
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
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org,
 Russell King <linux@armlinux.org.uk>, linux-next@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Daniel Scheller <d.scheller@gmx.net>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 10:06:20PM +0000, Mark Brown wrote:
> On Tue, Dec 11, 2018 at 07:38:33PM +0000, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an arm allmodconfig due to:
> 
> > 	arm-allmodconfig
> > ../arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> > ../arch/arm/include/asm/irq.h:36:9: error: unknown type name 'bool'
> > ../arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> > ../arch/arm/include/asm/irq.h:36:9: error: unknown type name 'bool'
> > ../arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> > ../arch/arm/include/asm/irq.h:36:9: error: unknown type name 'bool'
> > ../arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> > ../arch/arm/include/asm/irq.h:36:9: error: unknown type name 'bool'
> 
> in ddbridge-ci.c and some other media files.  This is because
> ddbridge.h includes asm/irq.h but that does not directly include headers
> which define the above types and it appears some header changes have
> removed an implicit inclusion of those.  Moving the asm includes after
> the linux ones in ddbridge.h fixes this though this appears to be
> against the coding style for media.

Hi Mark,

I sent a patch for this yesterday, I think moving the asm includes after
the linux ones is the correct fix according to the rest of the kernel:
https://lore.kernel.org/linux-media/20181210233514.3069-1-natechancellor@gmail.com/

Hopefully it can be picked up quickly.

Thanks,
Nathan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
