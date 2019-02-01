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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07D4C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:10:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7278120863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i+DQzomp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtaCWsxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7278120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3gm0vbb7+Cy/q/df2r+ayzfw0Ub50AODO/SF/TC8njg=; b=i+DQzomp1f7Mme
	8r32ItthE16U2d2PGVByo0BUx0/VQQMZWwjVN01+wT1fw7VvG+k+80bgt/tcZZ+hOXxiU+8mpwJmn
	1b4DnTDbxE7Cj7Jc4rhuhOaB7jIYZGYAB39MEFG6iGebyYQlvCuLH63m0fC9sZPkSp5WeR1p6aG2r
	GnUNEA/n8pIEJBdK+hDTJRN8vX7jx7GvGqfexcfzdkpSKM2qVn1zBn08ohO2F/ggQg1i0G/K5Bke5
	NMVgMc+BUqB6ynkoXJEulNp4bttmddk4nc78nUlcJOSjUDBy5Q5FXYwRn0k1Lth3aBnb3m6itolj6
	b45da9HnER8+9jaHgYyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpQ9z-0002rJ-Ul; Fri, 01 Feb 2019 04:10:35 +0000
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpQ9w-0002qu-Mp; Fri, 01 Feb 2019 04:10:34 +0000
Received: by mail-yb1-xb43.google.com with SMTP id k189so2138790yba.11;
 Thu, 31 Jan 2019 20:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gwP9pWApQ96SNbTh1zx8qjARByA4CgCXaf/6XW1DafI=;
 b=TtaCWsxdZeFmWsQoGt5cDPuwuCWMfDCoSJbwcCEH7tppauYBBsuefir1tlxM6tY2ft
 XCMvy8OFpXMmWEcIEm7xzJOoOjsdEAvzowFHiKsOYjCzL2v6n7+PH0ZcGNgWGSkbxKi3
 QbJhufxpVWeiFh5xw3cA+TvWrrns0DFURA/5nWv0R9wV0cMH64ZEbt4MG4g8F0atxDTT
 2Jjj1ov9G6M7NJSTOOxgVLIcqhW5MH8RZesZDm9PDxRDF/VfSqgNoNMWLFASGYTLxbQL
 0XpmT1U/474y3FTeNkF/QvdpxjMliWdXvylcoPKtQ74lFreGKQbMRpQSTuwBYhTsdt+Q
 7SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gwP9pWApQ96SNbTh1zx8qjARByA4CgCXaf/6XW1DafI=;
 b=T4rADRlc8B0DtVDhrGJLq3kfCkTWo8KJb+XteZIeZOwZ6YB7mSx/iYwE8vhX6XX6wU
 tdAAUBfZx8tm30LLBU+phP6uLIdRA87eJiKa55xxGKPgfKS5o0aa9XnpscVG1/2gRwf6
 RTQPv9Yk4urw1NK3puwOS7Ao7WU0r+SGNfRltw2/n+ULudfc8MIHWSaI73kxlrpCuMtl
 btEj0ch5ytm09AZxg5mrMosVRxrk046UmL15sgDhBujBOaPQ3NlJmtP/581JSCxU/PpK
 DjFhMG5X3iDY8lqktLC83/5CQC1Zsw3yUx77J5prvDcKheRXontBLAeSDnS1bUkjk49P
 4huA==
X-Gm-Message-State: AJcUukejpBGSFOr8JkP2OD1V5ON9Y1NFMonp0aAWxFA95K4My22uNm42
 CGwFYU1DbZJdb3yzbq++kJB/ZWFl
X-Google-Smtp-Source: ALg8bN7+u6ezOSj3jN1JBqWRDB3obKKueml+pH9B527JhjpfeXgcnJbLBzB0fJ8TbqCIpqJraiQIUw==
X-Received: by 2002:a25:c207:: with SMTP id s7mr35006011ybf.37.1548994229816; 
 Thu, 31 Jan 2019 20:10:29 -0800 (PST)
Received: from [10.10.115.198] ([192.19.218.250])
 by smtp.gmail.com with ESMTPSA id e124sm2362913ywf.17.2019.01.31.20.10.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 20:10:28 -0800 (PST)
Subject: Re: [GIT PULL 1/3] bcm2835-dt-next-2019-01-29
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <92b0b6d9-ced1-4a0a-e0d5-d72751dacfcb@gmail.com>
Date: Thu, 31 Jan 2019 20:10:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_201032_770691_301D06D9 
X-CRM114-Status: GOOD (  15.76  )
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
> sorry for being that late and hoping it's not too late.
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2019-01-29
> 
> for you to fetch changes up to 14117e0af4a853b2b37925f526b2bfe1cfc7b285:
> 
>   ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl (2019-01-22 07:25:59 +0100)
> 
> ----------------------------------------------------------------
> This pull request adds the necessary changes for the new BCM2835 PM driver,
> support for the new Raspberry Pi 3 A+ and the missing GPIO labels for RPi 2/3.
> Additionally it contains some minor DT fixes.
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks Stefan!
-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
