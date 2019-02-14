Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E121CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:00:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BFC222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hz/Srabl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJctJLWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BFC222DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tmhW6WmBSd55JuVevDuv/7ChjeLI7LJm6ko5pMtazRQ=; b=Hz/SrablN3/S3a
	mAZfWeweqCNsOoA10oO4y+mupj3ZiI8Fr7TuHZaNQqXBQ8ZMeEn6/Aiik4PTufx+tuw58ZiXbsaII
	3UW2wPUrymoHuUCXXHH9sZyfQq0UNgDkLQeX3+Qg+Nm7Fmz7Gq10hEhjh3YVFebxqeUpZg/Hsmvws
	g7cWDZes4lyMkWcph7qGyhguZLSHhpFXvsd9I3fa1p5xE2ZjKCvF650PMpdMDZy6whVS1VE22SJ6+
	KS0YcYzTWZVVFC2BGg7HNzCx9ZMSlPY7PTxxgjGd/RA8fz2gEn+t150CcXXxM8Ya/cdqKWABBhBBy
	bEikuix94k9RPadWzg8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guKNN-0008OQ-05; Thu, 14 Feb 2019 17:00:41 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guKNJ-0008O4-Th
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 17:00:39 +0000
Received: by mail-ed1-x541.google.com with SMTP id b17so5611791eds.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 09:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qKi37h0Ix9JQ40bmp2j0SNPnRS6GvU2wisamH96+cI8=;
 b=FJctJLWYCUVxagY9VrAZ8F35BGaPVly5zZBrufREG8zzfpajV3WAVhPI06+nSoJPsb
 TCgILy1VMSJFICdbluRBcxEiosFkHoV2rO9tN6uJv0nEcqtRxZzc4FrwL/InjLkTVAwR
 E2x8a7wx00Y2BZ7X3okeadtHhmE0sfKstxtY1+HgLDyMGHbDVjbe/T8/PM589SJIhV8o
 RVojC6yeQxO6s/820cgouDZcaoO4pnpJWX2QNMf8dvLJN3oHy9pxbnoFDy8qEyGpXOHi
 DZyB8HDFDkZigWOi0cKcy8+4WdFVu1P8BZJUL7jUGd+/f5bd94NXMo20zPB7pViU8WhG
 rZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qKi37h0Ix9JQ40bmp2j0SNPnRS6GvU2wisamH96+cI8=;
 b=ZtMv+qiQvYfAUGspxEXpyo537QPt9aSzpV8ZVnbIxH/n5dpQlWcE3jicTNgo/dTdmd
 KnQnZbtL+fc/EkgPWvCP/1f5etre73uXGQkwGUBwbZLW5k4E+Yi88CXMkXeYKfQzQgBP
 IGcXYCWail+fXhGyNp9wLBIAuiuDxzep+XyDQEnRIJpwoFmXn6DArcanvnAlQuZUSHnK
 FxHfseO8eckztX3esDlTY6Rs7aYuXgjRWPYBQsMURyxnOSBv3Ru6ClYK1EpaUDKesOhc
 FEtWN6/ZdNwnqblsIrVqMAbYVZGfCY0P5LK5bWVnS3eDC3qLmWWZky/SPposV2mzs1BF
 YkFg==
X-Gm-Message-State: AHQUAubVVfhCG+oj2zMG/zVQWlIuyBrvb13miYVxqDNGNmWDg29YlCma
 IVkTMYToOyIkOt0I8kIs7Vc=
X-Google-Smtp-Source: AHgI3IYvP87g3QgU9McriTzbz2room1pOV8pvqMnSrzJ+qoDDZSEj0KZ5/xLkcAo9DEKooKcuPNfKw==
X-Received: by 2002:a50:ad4b:: with SMTP id z11mr3850148edc.157.1550163635472; 
 Thu, 14 Feb 2019 09:00:35 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
 by smtp.gmail.com with ESMTPSA id k20sm640085eja.33.2019.02.14.09.00.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 14 Feb 2019 09:00:34 -0800 (PST)
Date: Thu, 14 Feb 2019 10:00:32 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] arm64: crypto: Disable xor-neon build when using clang
Message-ID: <20190214170032.GA30494@archlinux-ryzen>
References: <20190212194645.32504-1-broonie@kernel.org>
 <CAKv+Gu-W2X32ZCqKsJVqSqyJ04UK2eoNCDKp=2OfsO1HhKaCuw@mail.gmail.com>
 <20190213114033.GA7540@sirena.org.uk>
 <CAKwvOdnx-_KtojEEbnWvygDLXec7ckCfciP4iwigPT5Y3bdmxA@mail.gmail.com>
 <20190214163047.GC11988@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190214163047.GC11988@sirena.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_090037_960865_22EC2834 
X-CRM114-Status: GOOD (  11.10  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Jackie Liu <liuyun01@kylinos.cn>,
 Nick Desaulniers <ndesaulniers@google.com>, Will Deacon <will.deacon@arm.com>,
 Stephen Hines <srhines@google.com>, Kevin Hilman <khilman@baylibre.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 04:30:48PM +0000, Mark Brown wrote:
> On Wed, Feb 13, 2019 at 01:45:08PM -0800, Nick Desaulniers wrote:
> 
> > Nathan's patch [0] is probably ready to go; with Ard's suggested by
> > tag [1].  Again, I'm not happy about it; but KernelCI coverage is
> > ultimately more important to the project.
> 
> OK, Nathan will you post that?

Yes, I can do it later today.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
