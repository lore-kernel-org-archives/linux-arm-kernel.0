Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB62920867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t3rbX2jf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="oaLMfSmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB62920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J7DyK8UuDunYl/YCIMBpwhPWhwMyzx5Zw7JOAVzXApo=; b=t3rbX2jf4MyKz2
	qGySnuPk/1F0kzF5BXqzB+XJzSrOCfGYbQIfp2hpVF/66694d/ubtxxKm8RaeWdOxn0X4D638ggZp
	HNR3NdQRECtvaKKxD7H1RYeP1L7kDftlxbtg254Z+GnQC5y/J/l+jjZS6LdFRykd5F53KHlzqUxa0
	TIWSaFcAhCYGGeGYEglZSSq0VS0vyf88vtp87zduorBZPFBaTux0ZG1c25Y/APXlofoGuuosppygO
	NHjfv+d04lrDGwDzYUyilwTzczlfwFNYhYGrdhJAloj4Im2UGFFdetZvq9N4VhCVkjIdnJQqnGYFa
	H0lejs6lRehXBacY9pIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSshi-0005Yh-0L; Sat, 01 Dec 2018 00:00:14 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsey-0002QT-QF
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:40 +0000
Received: by mail-lj1-x241.google.com with SMTP id 83-v6so6471769ljf.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=otb8H92GZNX0iLZAhQat5PkP5OgihU+RubrR9kLEvhE=;
 b=oaLMfSmTa5lzRrNH1voT4HQFyNLWsoWFwpDg4NBPu45TOLGcsdv96IjlQOgt5dn2mg
 00oiL6ZxIEmPUuHC0QZRJMnsyFXQkUJ8Icbio0EgPEQm1HJuYVsN/lyCjdKSDF68JeMr
 REMe5LFE62wZhhRWqAKQrTmuT+zvEnCgsLlWQ/31sRSJ69RoZxSMqA2gyY7cihOTzUGB
 XlsAqSeiQ9fVKcu+dyqUdc9+39LU4iSokIwZHKZskHIjmz7zcuKB3pNl5YT9/smiqTgx
 3FKrjZbSg4ut+X7+E26NYp38VyLCJUkrolmJqahan2NkEY1lvtOQ0VjDlUh3EjZdNE/I
 8/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=otb8H92GZNX0iLZAhQat5PkP5OgihU+RubrR9kLEvhE=;
 b=Urs9nR6vXHgXn1ZUcu9sARwfJ1cpR3WK1q/uFsHNnmH40kP7+p4uY/FhToExSDvtFH
 YokP70zhkioWmaGY1/mG88+EsfwpKrs59yccSnFqrw0/go9BmcnQ/I0TUC7Z7cplamtn
 VQLlfxVyW3pXnsB0LfOS/VTv44QQNuBPdKE9ryvd1XYOnDVoL1+cAw8qiCWrgXjdoYsh
 lpwx+WJhMeLCttdx1h1eA9Aw98ZtZFbUksZzGLDYOOi33ICGrcyU1tEJxO8/welSJFpP
 mtqXyhyQ9BcVvdF97jG18XTC8uvGUnbfY6ZxdJlsqFs4771Bvzsxq7nPzrvt2M9jaYEB
 4wNA==
X-Gm-Message-State: AA+aEWZFiINxTZ3pQMhsyYyim80i4Fnu02nS3kYBhMsvni+qXlEJvS2a
 mjcxAPGyOCSEsZYG09mJkB9hug==
X-Google-Smtp-Source: AFSGD/WXVVigI8VJ4J3M2kk5Rw6+8dlV/Z0P+jVH1SAjbvrPOnQEneSYcUTXVzwyVm21vatQC0RMtw==
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr4384687ljj.43.1543622233076; 
 Fri, 30 Nov 2018 15:57:13 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id y14-v6sm1025684ljj.55.2018.11.30.15.57.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:12 -0800 (PST)
Date: Fri, 30 Nov 2018 15:39:24 -0800
From: Olof Johansson <olof@lixom.net>
To: Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [GIT PULL 1/2] ARM: socfpga: updates for v4.20
Message-ID: <20181130233924.pdjbcyada74xsqb6@localhost>
References: <20181128154403.12872-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128154403.12872-1-dinguyen@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155725_160128_74229B49 
X-CRM114-Status: GOOD (  14.73  )
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
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 09:44:02AM -0600, Dinh Nguyen wrote:
> Hi Arnd, Kevin, and Olof:
> 
> Please pull in these SoCFPGA updates for v5.0.
> 
> Thanks,
> Dinh
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v5.0
> 
> for you to fetch changes up to fbc125afdc5048cb027002147a0e0def7c18573a:
> 
>   ARM: socfpga: Turn on ARM errata for L2 cache (2018-11-28 09:23:11 -0600)
> 
> ----------------------------------------------------------------
> SoCFPGA updates for v5.0
> - Split Kconfig options for debug UART on Cyclone5
> - Remove unused functions from socfpga platform code
> - Turn on ARM and PL310 errata for SOCFPGA ARMv7 platform

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
