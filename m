Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9A8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:35:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591712085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sHMdWBE8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rNUrM981"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591712085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1fftMu9SJVpv+jDEdmesZWvgcg4ZO0hrlwPsyawoGnQ=; b=sHMdWBE84iEcrt
	jYAS7B57/H2emkWXcCq8bWadMyAVIsk3zg21RmZAuhu0zcspPZdllKFL3QvL8IZXcGAqARRSASBW3
	F4Dz0LipEX5cejqi9T2RqcNASP/DbB0MaUvViVzRKPq8DncQ/qwmAM2IaZxAhZgLTMXvUcf9xKyEe
	NsL3cWirGSwvOKY/5aKhQjWuT26sbFNriNMqRTi52bSbqlZmWe43rDzCiBwjCvHL7XzdqXDAgjDaR
	jPBWExuXYKIrQcGH8xMEkrdDtRPQFr1pHCvUARG6v0DoWGSXKEthe3vutpk9PSCSfMigcb86rEMGj
	/MiwRnvEvdp03l+xn4iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnZd-0002kP-JC; Thu, 21 Feb 2019 12:35:33 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnZa-0002k0-LF
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 12:35:32 +0000
Received: by mail-qt1-x842.google.com with SMTP id p25so30975365qtb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 04:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qkfOAxs3btCiae4NHQERlsgB2PY87zUqwzXCRdmU68c=;
 b=rNUrM981iJKrNKYl4KJqp+31hlK5Iw25tJ/4XZjuGg5HeMewGmpgBiilND153UJrlO
 Wme9/waabe8HBNxuX0AQWivdMv1uwav32hlDHV0LfsRkEY8wUQ6ret+4JB05D048GK44
 2VSl3eEvdXi/6E5yM4T2NlxbG7FOkxJs9JOqgb3fJRn4xisLvgEFHPzJBglyKxVEIzQo
 NafFo+E9a/F6hzSR3L+HtMimRHY56enE4IbCjNIeCufrY7Lg95VTkLvcCmDJXwmwe/7F
 d8J/rmsfUaP3Flft9I9avgwEhd2D1OW7ppJajIlRWxDjp9oaHVPGSOEGhtIvVjV/OxnO
 A7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qkfOAxs3btCiae4NHQERlsgB2PY87zUqwzXCRdmU68c=;
 b=ZzFofVvIUEWDuJLyC7Z9rRC4JPlPniWnNuFYeC5+YmQ3RCZv83Ly5Ikoj26mf27naR
 BWMy6J4CJAHM4bx/9ABueqmcTZ0fdcDygh489+fCxKqd0Y3b1Z0/jTTCsjUbdkLbLjzV
 hgIDQLSyK0auaScNd0GkrANMrly38MUBv7xk9t+8pJTDfhEcBApq+wEorXVGzlGyU4kU
 RcwR22NRmRrNnPep/SB1avfDyQV/CcEYupBR1Gr55sGlOiBg7AQN/9ba9quyJeDucMcI
 1hbWb/sfOQS0LfmpJe6/tu3xHOjj3EBqYIp2A+GbG1rmq2cSxPX+meCA2nXrkvX4Yb96
 n2+A==
X-Gm-Message-State: AHQUAuawsSo3e/sVxbLD1k/sHXnyRaS7YdidUYvc2He0EHPW2tv3imNy
 WNhuygobDT4I6tfPjbmo2tVKAlpjYpuEBoi/FSEAXA==
X-Google-Smtp-Source: AHgI3IaZCVRWK0qGQbtsIv1pkb++3mI8ivGZ9uwFAtOtgVVjzvHHxtl3Fq5KTXoANH2wZ/Ufve8w2jVHzImsImKpimU=
X-Received: by 2002:a0c:d84e:: with SMTP id i14mr29899910qvj.134.1550752527180; 
 Thu, 21 Feb 2019 04:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20190203212936.17053-1-vz@mleia.com>
 <20190203212936.17053-3-vz@mleia.com>
 <CAK8P3a0hO+u_pONptqjCFbiFXw9kM=JHiwixQDsM6mH271R2QQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0hO+u_pONptqjCFbiFXw9kM=JHiwixQDsM6mH271R2QQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Feb 2019 13:35:14 +0100
Message-ID: <CACRpkdbkZSdfBHR5ftKoC0j3uZicjkqWpc4xJg18ba4uqsin0A@mail.gmail.com>
Subject: Re: [GIT PULL 3/3] ARM: lpc32xx: NXP LPC32xx platform changes for 5.1
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_043530_700249_B7794D4B 
X-CRM114-Status: GOOD (  10.90  )
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
Cc: Kevin Hilman <khilman@baylibre.com>, Vladimir Zapolskiy <vz@mleia.com>,
 arm-soc <arm@kernel.org>, Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 5:53 PM Arnd Bergmann <arnd@arndb.de> wrote:

> I wonder if we ever go the pl08x DT support to the state of removing that
> as well, I think Linus Walleij also looked into this in the past, but we still
> seem to have this on spear, s3c64xx along with lpc32xx.

I looked into it at one point, started making patches but they became
large and scary :D but that was mostly because of SPEAr
strangeness.

The LPC32xx should be an easy conversion to DT because it does
not use custom signal handling. Are you sure it doesn't "just work"?
arch/arm/mach-lpc32xx/phy3250.c does not look like it's doing
anything the driver can't do from device tree already.

Look at:
arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
for an example wikth PL08x and DMA on two UARTs.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
