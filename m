Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CEFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:59:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0629220700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UkNjetax";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h/frq+od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0629220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hKmaKLtKGt4txawzt6imGSCfiNDpUAGIRqQMxJyc5QY=; b=UkNjetaxkJ49Px
	Sa2kXwXn6C7rz/gpGZiDz35qqA811wsnJeBpaHxzd8IBMiJ2QlpE8KcK8PpkzOYeu6GHKKYjcG66D
	ghr7epAnQiEbqRxaPuA60ypk7or6RgyRVEYKj4ltXiWHxkaIOqSVNu7DJhm8p4TAMFk+NCPY7oyK9
	1TJWFWvd98NfMa7s1lJFqKaw6NNBFp5jw76ymCekBrg5PXKGzia6N1xOK72XQ/7tRQsSMBy2iDrjL
	zwqa6sbCJux3OjEPcXl9Fygq3IwxGRoAYoEIZg0o8MNEhw41X3wsA6XpOT7/uMPCclETHZlJLG8a3
	Pjwj+R9C003ItGLw1BfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi6hg-0007Eh-QH; Fri, 11 Jan 2019 23:59:08 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi6hd-0007EI-DR
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 23:59:06 +0000
Received: by mail-pg1-x543.google.com with SMTP id v28so6950109pgk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 15:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YXS609+Rr6Firj7E3CvyBmMR2oehV0/tgvrPgdkRRUM=;
 b=h/frq+odSvkPp71ZOX+utraN21aXiQKtMAVRIkkriqkC6MI/yvvAP+WNxhCgg2Fqhs
 I3TMY7PGPh9+btnsz+G3jJ09+gWrvanFn53IoveMNYyh6Ao/zqSu527gKQRDiOzf8FZP
 r5+KZk0eAbA5Iu2hCAsn1avLCpm+rPQ2TR/C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YXS609+Rr6Firj7E3CvyBmMR2oehV0/tgvrPgdkRRUM=;
 b=uFkOQIfAA2gLMF9m9+B3YvIEK2rAtqqXaXB7IGdtuqFhGUhfNkLr2DRAyoERiXtsxk
 cxb6d/YZNNQ65KY0HP/ehlBoJdwpMZi941E19cjugSn33G9Tzzx/UbinC46fz7D4UVlh
 mTx2trtOePqOQ5HGSTKL/zVS13jTx5rE7Yuz1wtyfCOljKuyYtR7RAljCbiomlZAe/rD
 Em0K9xx3tTaM26i5RPdE/RlkEijJ1WsMn4dR5FmqWI2HHtVbdIQnSy4WSDaJtzshePYD
 Jk/HEJtWrkDl0xB+7/V6cldKIE4gYeyiHVTQwNlhzbCfIYtHUwTprlTe/FLSjpHOVw4/
 ur2g==
X-Gm-Message-State: AJcUukekqzkY1UmX3h6RGHlgYbNYkNFttXbZB2oIXXlxNDED8wpKM7/m
 8qzjZyus5W993SNS68b+mIQcIjuXyxJQGBuHDEhCP0FMV3+4c9JMNiRMq3+pJ/4IZeY10KwQfj4
 E1u8RUhgKgTzTQS6U7DQ4qxwI42GRh4/SWT37sThvYlnXrSHrriHp7ulXvicwP52+CiibUb/luG
 bG+7ZKm7iT0/U=
X-Google-Smtp-Source: ALg8bN7xRpKks2BDpy3PoPgjGMzpdg3A/VIgRcgiaNK5w0N2PooKIbWCfCDwIS+o6+bsN9curvA9LQ==
X-Received: by 2002:a63:295:: with SMTP id 143mr14746138pgc.362.1547251143332; 
 Fri, 11 Jan 2019 15:59:03 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id y29sm102477011pga.59.2019.01.11.15.59.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 15:59:02 -0800 (PST)
Subject: Re: [PATCH INTERNAL V3 0/3] Add support for PWM Configure and
 stablize for PWM kona
To: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
 Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
References: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <4678b237-d0df-ef85-182f-759125a5c085@broadcom.com>
Date: Fri, 11 Jan 2019 15:58:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_155905_456461_A6393E7F 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Please remove 'INTERNAL' in all of your patches and cover letter.

On 1/10/2019 9:08 PM, Sheetal Tigadoli wrote:
> Hi,
> 	This patchset contain support to make PWM changes configure
> 	and stablize
> 	Following are brief changes done
> 	a. Add support for version2 compatible string
> 	b. Change PWM config and stablize delay in PWM Kona
> 
> Praveen Kumar B (3):
>   dt-bindings: pwm: kona: Add new compatible for new version pwm-kona
>   drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
>   ARM: dts: cygnus: Change pwm compatible to new version
> 
>  .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
>  arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
>  drivers/pwm/pwm-bcm-kona.c                         | 128 ++++++++++++++++-----
>  3 files changed, 100 insertions(+), 32 deletions(-)
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
