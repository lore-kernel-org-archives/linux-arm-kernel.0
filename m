Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1881C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7F12084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hsjInG7I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="2R1253L0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7F12084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3nv1NXCfAP9bpFQLSG5JqQX/wKJHfIydgGY0NlIVbV8=; b=hsjInG7IR9+wgc
	k5uG0wynXFsJ6SMI10lbqRNxkSRt4tb2I7raI9RP5VOOU6Khp+btSf2NHZj7fJ5Dx5bqwUR/nY3JI
	csU1AwC3kVt3zivMv/xjYYVhw/aHwxEGr1Ji4WqVqtUHiLEtvYdvuj/G1tRZ9LyMvp3ffOM9LLT2Z
	6wR5/HSNrT2KJ1JP/5fiozJU/z6AhR9liwb2u+ZYgTKkTP7nCvMwnFQVqJlgIo2JagEIQamMziw8x
	JG8R6v0BbV0mz7bQQORP7VSBqN8+FJuW8jtD3byb+iS82+U6KOXKy7DIhj5x3jXQ6XKlSxoHIvI8L
	nmichQwe6uH7S4Mh3wSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCpS-0008OF-9h; Wed, 12 Dec 2018 22:18:06 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCne-0006Ny-Ug
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:16:52 +0000
Received: by mail-lf1-x132.google.com with SMTP id v5so14787929lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=oHBZzLgfxDGmIxVjOCMkhER4QZkXr1ho5yGIFdssy9g=;
 b=2R1253L0QW2jzxWqYlOCIYOdflq5CFjyBBB9/K9r6eaB42S2mNjqiy4rkpVrSl6B6x
 9MUIhgeHyAgtMwiG9Q+cBs2LcKhmbA4jxP9RZ7Uo1hlboQe4SoomYV3gdxIA0ZmEaaHw
 OyPU3B6y4Qup2Bs4TBGwdFWK8AXBsdKEt7aHQEDiEy42sF6r+VUIxGA84aa1K+pE4ep+
 t3BjVGLXjdMiXbQsOoHtzd0U2RcRq6Ko0kQqtZVXPbnLeg6FTH8rp8kqAXhhWHjbnnlb
 XXEN0tU6SBA2HVqBYgsJxHfl8XCjLYOkcR17Z72Jk9dvXRzY18Ux2G7fkqIWnC4LPu5A
 lMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oHBZzLgfxDGmIxVjOCMkhER4QZkXr1ho5yGIFdssy9g=;
 b=IpEZ8UeMi25Kxu7y0saQdpwXtDKBP6XH3QG1iTVa4PsM1E5rGmW303l2gSIeWlGe0T
 RR82oCKSaCgopMvpHdG94FXTU73rcsamnEzwoJLSb3Iq+lXbCkFnqnR5pkBO1S1iXZnC
 0yUq/B69JjThBRnCggeXCkPpEwKLT1MEo4wHqZ2C53CUojhbbX+BEuG4ajClkRNeDqy/
 UXLAPDJ4mWoNXiiriRaooGz7moTTjRQGlf9yNM29kX1h1ZcyQSUcjJoHtvgqHj//n1n4
 9Sv7DePUsJO7/+mYORFVNHIDZsDeeOEri9rbOffRQP6WDzgxyndy2d/Qzu2Oao0VA7/v
 Jfgg==
X-Gm-Message-State: AA+aEWbRzTBpyEkLmWP3u5TlyRglbZpjfk8DnFbGf1xrOZbJ1RH+fz8W
 K5kVLeZwlG7t+773K9MQwNay8Q==
X-Google-Smtp-Source: AFSGD/WzF5OJEml7uSJSgxWmpcTrGT+iwNiaJPuDE3ayQQqgoz2e5t9Fjm+WzyyS0HCh7Srd+NXwQw==
X-Received: by 2002:a19:739d:: with SMTP id h29mr3130584lfk.85.1544652962794; 
 Wed, 12 Dec 2018 14:16:02 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id r26-v6sm3453lji.25.2018.12.12.14.16.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:00 -0800 (PST)
Date: Wed, 12 Dec 2018 13:38:33 -0800
From: Olof Johansson <olof@lixom.net>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [GIT PULL] tee subsys for v4.21
Message-ID: <20181212213833.nretkviqn66bnxtf@localhost>
References: <20181212123121.GB29450@jax.ideon.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212123121.GB29450@jax.ideon.se>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141615_598743_467EA370 
X-CRM114-Status: GOOD (  11.48  )
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

Hi Jens,

We generally try to keep our branches based on quite early -rc releases (rc
1/2/3), to avoid having to merge-back into our tree from upstream too much.

Your branch is unfortunately based on -rc6. Would you prefer to respin it with
an older base, or should I cherry-pick over the patch from it? Either is OK
with me.


Thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
