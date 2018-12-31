Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096E0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:35:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFAD21720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F7PYKBHF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="wCM1TfAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFAD21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TF3aJzygnIn+f0fOSuCY6aUThqXkTRpOfz9kRrzkLPA=; b=F7PYKBHFiDm+Pc
	YKgJkuWZq4mcDOJAL6c6ZriAHevErrlTtfvumFh6Mav4lrYt23GX8Ujjp473WFTHwGnSkfe/RSCA6
	T8W9ND4VjKh5msqjmIqqM0KmOE453Pd8zdzuloSl1BdduxR1WlQrYS+SlDOIGnUbwoWULHl0uliu/
	WYyZlIFJHVs9Y5Aidd51Rd9aEEZKsbCxTmN9W8ohLaBycrJb60SLfZ1hRdyy3jyVff585saGy6kRJ
	LtfVc+XBE2+X3Nw+79IUC57FDAR3r4h3Hap0LWhrXj4N7+0624PzzVSw79bZgdQ6mZ3SM4Ys6t9MB
	vLZZSJs/kwwra/Qj1fdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge5DG-0005xo-QD; Mon, 31 Dec 2018 21:35:06 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge5Cz-0005l0-KW
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 21:34:51 +0000
Received: by mail-lf1-x144.google.com with SMTP id e26so18864852lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=I2/qCgYLXayyRSHBQROXp/5HG/DXr2r6/XD1qd/3LX0=;
 b=wCM1TfAbirfuY+HNX0sczBbEDaKkyYfMY4aFPDB5DAoAv/KD1To/hkOfJ+5zoTmNZs
 0zB7ARIJ0d5SCfGT+hP73NYz6RJfuFx1+ohkURWtFdMm1JOPy6J16mElzputHApHGJJZ
 Pz1LFnOox+p1Akb4+lQG0DwDyFQXDC2qDrnREYcL3n3S62MpUlXTuUzjVTk7bkyylP1n
 3qkH/dipvB5AHfmH+SwcGnAvXkfrLhpTPnNb/+s18LP5wp4YiSJbivEJ06QouGBrcJWG
 d80yDCEBTyplBva+o5T21fDj9fy7hchEkdRhkvZHfnPk9yiUuwQ+99s4eKHI/SQfyutR
 TAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=I2/qCgYLXayyRSHBQROXp/5HG/DXr2r6/XD1qd/3LX0=;
 b=dfUmhyNHY430WxYTmmCmIpfaEuyuw19uVzXGxoDCZ/gyixRWF0KGDvIYieAZ5qCqNN
 uYMHPkDw/TlR/3NPaBDWCMcm/JkAC57+8yCfg8ivkJG/l8sTqh89pQcXvclrc7p47uAv
 Q3qxA7CqM1hnkHnb6amxpaz9wRi/VpwlpOs7WdQzGgpoy62qr6y6ITPMem7kvZuOFtiF
 LX98SV7nIb8llI0BmEolWRczwmfajljK4yu27ASo0VhLKXcSq0gLiTwoRYmEWt7RAYmV
 FGX2KWsQl+mXcGObg6FBCni233qsfXQSMDj93hniX7DvhRhA2g4+uhh+GqHHVnFV27o6
 AZgA==
X-Gm-Message-State: AA+aEWZcXZtaxgWAWxPBzOyrOEpf+IRUA6LJsuriwQ8rSI1RomqeVcrf
 0SkU9yP12Dul6gGcdlJI/He2pw==
X-Google-Smtp-Source: AFSGD/XAYAQUQPyaH6uiZxmNj7KrkY4Q+vAtPh5vdB7AJWLInSoWk7oAVBBZ696X3bye+yFLeHpurg==
X-Received: by 2002:a19:574d:: with SMTP id l74mr18863752lfb.5.1546292083919; 
 Mon, 31 Dec 2018 13:34:43 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id 11sm9511314lfq.89.2018.12.31.13.34.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 31 Dec 2018 13:34:42 -0800 (PST)
Date: Mon, 31 Dec 2018 13:06:41 -0800
From: Olof Johansson <olof@lixom.net>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [GIT PULL] tee subsys for v4.21
Message-ID: <20181231210641.zzamntcmvc542avg@localhost>
References: <20181212123121.GB29450@jax.ideon.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212123121.GB29450@jax.ideon.se>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_133449_723960_D70DBEF2 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 01:31:21PM +0100, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull this small OP-TEE driver enhancement. A friendly log message
> is added to inform that dynamic shared memory is used when initiazing
> the OP-TEE driver.
> 
> Thanks,
> Jens
> 
> The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:
> 
>   Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-optee-for-4.21
> 
> for you to fetch changes up to 3c15ddb97c77f34ba009910becd5921f169770a2:
> 
>   tee: optee: log message if dynamic shm is enabled (2018-12-11 14:38:40 +0100)

Same as the other branch, queued this in next/late for now. Will send at end of
week.


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
