Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF6CC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:11:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B762320863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6jF7UDL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfHD9qfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B762320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yCAO0IsqAsVLDQ1vF8XBosyD3p2bptE914yCqcSViGA=; b=O6jF7UDLlOtZJz
	FV0GfxxyMIudxzP+J7JD7sxc8Jq4xalI5W2gOoRPDRLc0s9MHGJhnKTw9hpBat3g80TKeTKKEMYDD
	c2R+R8Pr+9OqJBa+Tmk2rqNUdIn3x6q3Y/yiAFf/rzuLdTNKAs+H3TBZ/uTqFmvqH0GAuHCsD1zrh
	vEDYI/AoeQILeR69CJtXV6fpiQDGWJQOcldbruqCirsZY3qaT0UPRwSKWLAkGjTC68FiAEMZU0MXj
	W/XihmxOt7K1KT9mpr2feEwrFePqcW0EhOSoysx6AVVM4+NqWTZ3AJ9WkJUPzDSE+bUjEDVkzxKU6
	ns3lS8L+9x/MkwwBzoIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpQAM-00038v-7f; Fri, 01 Feb 2019 04:10:58 +0000
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpQAI-00037w-Uv; Fri, 01 Feb 2019 04:10:56 +0000
Received: by mail-yw1-xc44.google.com with SMTP id i73so2337201ywg.3;
 Thu, 31 Jan 2019 20:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7cAZcqrjPXXFh+0czRZgkohiQNUN7HEiDF7AJe9qNZA=;
 b=YfHD9qfkkZyQgeGZ0lfW0D/B14nHqL3RKAFFWia8oE7qrzRDd+zYmmrllihej/e9HE
 760wyK8cL2kZ48dr9O5LoIorT5K8NQzuPHHr4KL86Kujy1UoQgPsRNPxR4hVSETT5aHb
 riXtOl14ixHxUr2KQ7e4/PwLOPVJTk2E6Gz3fvxtgmq41AKz2RKqfvAsa+23+IpuDuQR
 r83qshMTuU1mSBm7fE2YbSOXjLDFMObtEfpP5SoSYx/Sxy/s9mXnM+1ZwiGSRowQyWGK
 BXVcyvcB+nMfYje3/fRKfEvdr7Bgm4XM/w/2TRoOq1SZnAR1RoHDs6gxe6x8YO5gkR3J
 3M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7cAZcqrjPXXFh+0czRZgkohiQNUN7HEiDF7AJe9qNZA=;
 b=UknSZuxu48j8Slk01FRVjlrQZIrxtwswPHPqtg2OABIsYCP3jmd7icuBfS12oQiB/x
 PZKj78bhoiboi0E6pnHkv/Tlnms3g2qwtXjCm4Owxa+ElqL7RUtvYa0qu9MuCvZHz7kG
 3It5ojRtHu/MgEnPf71fsXSugKWPSowNumo3h9O1n9aEK/1jDVJahjdazq/vL4hJ0MpZ
 UdLHgt9/JYEHmF2bBrjy0GEfRoMd2+03C6SPue4Oi6ljIiVKQqf8Oboh2ke5MzyT1BYM
 S7fsp44gGaDHZ5q86lW1Xi+zg5rIx9CvNzoceP1jUpPmaKH0RuJFC76xc1QHMUzp0PQ6
 AmfQ==
X-Gm-Message-State: AJcUukfCqr7jYanQxLoMIFuLe/NLjYvodvjEA5ZKnsr92gz4PRnpGetH
 /vn33f5zFFbQUOkWVw3HOI0q+Kja
X-Google-Smtp-Source: ALg8bN5s3/Xc8ZbeIaeY0wqq3iIvrJZU7HQgV9YMIWDdayBJkmVsVkvAvT73/l2P9+pMbIlLC4HBTA==
X-Received: by 2002:a81:bd6:: with SMTP id 205mr36362511ywl.304.1548994253305; 
 Thu, 31 Jan 2019 20:10:53 -0800 (PST)
Received: from [10.10.115.198] ([192.19.218.250])
 by smtp.gmail.com with ESMTPSA id i7sm2499034ywd.7.2019.01.31.20.10.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 20:10:52 -0800 (PST)
Subject: Re: [GIT PULL 2/3] bcm2835-dt-64-next-2019-01-29
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
 <1548788008-4733-2-git-send-email-stefan.wahren@i2se.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e9a43bc2-32cd-84d8-afbd-a9c8780d8f50@gmail.com>
Date: Thu, 31 Jan 2019 20:10:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548788008-4733-2-git-send-email-stefan.wahren@i2se.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_201055_025557_5EDEEBAB 
X-CRM114-Status: GOOD (  14.26  )
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
>   git://github.com/anholt/linux tags/bcm2835-dt-64-next-2019-01-29
> 
> for you to fetch changes up to 3688325a4acac981e95e25478d3703e3ab05d4c9:
> 
>   arm64: dts: broadcom: Add reference to RPi 3 A+ (2019-01-09 19:24:04 +0100)
> 
> ----------------------------------------------------------------
> This pull request brings in the arm64 reference for Raspberry Pi 3 A+.
> 
> ----------------------------------------------------------------

Merged into devicetree-arm64/next, thanks Stefan!
-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
