Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3668AC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:11:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A3620863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H47sBBwv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FClNe0NZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A3620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P/nTTHI1C/IIHSc/ALMWipneBB+kFTiWTsqb5KmbLxs=; b=H47sBBwvHYHXMx
	dAhF9dc2mDeg8ZSa5xXcepOxtt1XmKXgOKl9/5qLiJZq5lOJKJuf0mvMwyqtmoi22zDu0LpRGlGO+
	Q0E1A+GThbhpljbHPJ9SfAs+Am78TYusf64ZDlF81x8wvm88iaR70YalrTT3VLeHuv1mcwgG5eJSZ
	xNCvrN4bM7pMQDAwNyDsuRtqeX0c+EcvFVKS6Dt5rIwZcBBJZ/iJzkrzNr6gPEmZqWqpz4h1em4a4
	pJ9d6PZkV0xUrZcfmlDHgsZMDsCoycHUW0V75AeoqA6J+jASvixIMyVK/mCa4ZhrS11aVr+dkfsTb
	RRi/r4H7zl+EL92+ieOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpQAs-0003X3-UC; Fri, 01 Feb 2019 04:11:31 +0000
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpQAl-0003Vq-PA; Fri, 01 Feb 2019 04:11:29 +0000
Received: by mail-yw1-xc42.google.com with SMTP id i73so2337554ywg.3;
 Thu, 31 Jan 2019 20:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FtKJqxcqR+APmgWZxYnFePCXapABjOJViKC9j/0nP84=;
 b=FClNe0NZWiv+JoBwKt8itY5ZWl06a3dQZ7Iu9oSzwkGCGh6PjmUPqp6r5/IAldM7TK
 87jMszvmCwJU4hYcuAqJETrFYIalzf7sT4nA/f9mcbqPlLG9vgb17N75xWBEf4+bRQCb
 3NP05vl/gx2TB3HXpE4oCK4zwQvZBZ8imMuyn8wXDVFDLL6znS1yyZ3uvMyJiEK77ySM
 JCi6GKG7sGz6qdH0slEr1pjxKy6u14rc/IlsItsAEVw7cOS0Tw5itP9Z8tRbC/erfdPQ
 SV7WF1vpwW6/In2m6OSCFj3E0iB2XGxHKzXjvMnW6bc+08XgCeACFoNUWstpTAOnQafi
 VnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FtKJqxcqR+APmgWZxYnFePCXapABjOJViKC9j/0nP84=;
 b=N2wn/41zSipwhxSH2+MzdmpXq3Y9l1SgOD2P0gvvxCa/sZ2EgW3NBqrbM+0f0Mm1Ot
 Xwm/iCGDnWHTc6WvxRm8wceTY9t4YDCol7SnnirvS2ruQlHSu0ccyPaL8e0bWL5zHXiC
 r54XuQYdTByFkeoUMwrP8KfPrevoGnon/eWvntfl0I/SLEPT3XYdF3DCJmDbRnvcpcso
 cxhyfNg/lTFnMZMn7OL6HsgyoBpl+2PgLBVYE0dttO1XhFiBQ/SxRJuZGOCLzaOJN+nU
 RjYKQLJcCgDMOLzlQ1QoTHEKcgpf601S2BfMz4a1vCDT86WXTYntK6dsRvOIXrOlFzOW
 RJ0A==
X-Gm-Message-State: AJcUukfcJTAy/cgzrDJknRDQmt9jU4iXalcOMC88nnGHC8lj7bPBqnze
 4TecFKIqUNymC602WmXa+Kb+8t9C
X-Google-Smtp-Source: ALg8bN5QfLRkMdP0dcjUe+h3Isxld/pQ/s8y1OpsIp6uFNDdHihte9/C4BJmUwaGhVPQssEJjkA/+w==
X-Received: by 2002:a81:27d6:: with SMTP id
 n205mr36357665ywn.305.1548994282218; 
 Thu, 31 Jan 2019 20:11:22 -0800 (PST)
Received: from [10.10.115.198] ([192.19.218.250])
 by smtp.gmail.com with ESMTPSA id u4sm4704746ywu.92.2019.01.31.20.11.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 20:11:21 -0800 (PST)
Subject: Re: [GIT PULL 3/3] bcm2835-drivers-next-2019-01-29
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
 <1548788008-4733-3-git-send-email-stefan.wahren@i2se.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <687d6f9f-f64c-3959-5561-5f606d2d90f7@gmail.com>
Date: Thu, 31 Jan 2019 20:11:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548788008-4733-3-git-send-email-stefan.wahren@i2se.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_201123_970266_8736F0AE 
X-CRM114-Status: GOOD (  14.56  )
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
Cc: Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 1/29/19 10:53 AM, Stefan Wahren wrote:
> Hi Florian,
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-drivers-next-2019-01-29
> 
> for you to fetch changes up to f494caa480f7089ff9bba16dd865e190cee7e545:
> 
>   soc: bcm: Make PM driver default for BCM2835 (2019-01-24 19:19:22 +0100)
> 
> ----------------------------------------------------------------
> This pull request brings the new BCM2835 PM driver and a workaround to
> avoid network boot failures of the Raspberry Pi 3 B+ BOOTROM.
> 
> ----------------------------------------------------------------

Merged into drivers/next, thanks Stefan!
-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
