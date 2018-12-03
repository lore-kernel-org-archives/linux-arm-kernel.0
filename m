Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FF2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:19:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2585F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V4Rcrght";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="b2zLEf0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2585F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YynbXEb6QW1h818gH5zDI91rHOlKhkbMTWM/zLX/5Ls=; b=V4Rcrghtz5nwUm
	e7bgIssXBlg4gRS7cEHrm8IVzeo3mQMmgIyJ2facrVnG2eYtOOhKVvVIQRrSlHyeF1N3ofw3pc6se
	GaUuqmS8pV9GQJj9JcnO4SYyG2xLzgqmb7Npxw3EWr9ezWqPamb5iNF+GKg/Y4/QnlJuksoI94xnC
	Scd7cPdmLUXdgWWoFnheGoVEJnhAKiv6QMRftGahgQQvXkSpta1i5EHWQalpCTsEqTcLQWa1WGpm9
	D/YqNbkMP8FKCGMZvgss+RsAb1aDh5tLjeE7n+W+mvtMQYCGOmO13Wg7YztBc3TYxir0ddpelYP3m
	G7E24e+xBm8aFGETGAyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvcY-0003tK-QH; Mon, 03 Dec 2018 21:19:14 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvb2-0001y1-78
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:17:43 +0000
Received: by mail-lj1-x243.google.com with SMTP id l15-v6so12814466lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mSgLhQl1AF7dhz8IHFXTzhJX011VeaIOJgHnfByp8kg=;
 b=b2zLEf0kn4mWwZg6E1KcEoIAkMYRxz06GmHnr3r0uXuIgic7zudtozITPoqxTyedkB
 jvZ/x2/Ar9aB0Lp0OCsT1LW2lyOYvRqyLmKsp7tk2TImVll8dHTiejDJNMSzsOjkajv/
 xkyeAiIJPIjyySK/D1ZMKqORYQ93gKGnsUx5s0ymhd9eQdeSGpiLd4Z9lU0joGg6+8Cz
 P6cCA5EJca4IGjfzHKyXPZwhRDEb5uTwgBua4VZpMKSWXOMgA6ggV6O95MmN5yP3waOt
 X8NkuQYA/DdKWqJfwUOnaP/Fzjeh0w6nW44lejdaSZTVrx2j6zJHVYLVGrAX1XLdB/D/
 X8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mSgLhQl1AF7dhz8IHFXTzhJX011VeaIOJgHnfByp8kg=;
 b=EdUedmNA/IAOfVf5xwOnZ1oqyD/He2VqYIazmTeTWwrSnpbNkgFXUyQ3QzkJBuSkiW
 CxjR9I86HhpHZLTrGk4oGVrn/22tfUjRgRFgBAxfW62lHL7oPEukV3ETTS7Q9tCOA4ol
 WeUAsjUmW0D0FRhkVB1Gm8PqlePnn1ThmslEksPhjoOsI2ovAGHhG8+2APwAKsf45WEr
 KNV8zT2Kl8KdQWbSBLXuhxpqI9yJcivgQqmz4j7vj0LrpbobWGNPz7s6q5BVWe3nvEY+
 IKT/ouJjyhXZGWtEUTjxB84bXKCEGazHUQ4IBUGHscVpmqmjQKnEDQE/wswwfhpmb5H0
 B3vg==
X-Gm-Message-State: AA+aEWZ6+mRPC9xHhqNsOFLRi52AE4hfWoCeTNIVUF0JkJQYDMF9e36S
 ktv7n76ksaQZw5ViCi9Cto4odg==
X-Google-Smtp-Source: AFSGD/UwEXGtaQlfj9ThnbyWcA0SF1EYfU9aLMDTZTwo89g+B4TEBJjsR0bTivr9tLbzZwXNMi7YrQ==
X-Received: by 2002:a2e:9d86:: with SMTP id
 c6-v6mr10838647ljj.146.1543871838771; 
 Mon, 03 Dec 2018 13:17:18 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id o14-v6sm2713470lji.70.2018.12.03.13.17.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:17 -0800 (PST)
Date: Mon, 3 Dec 2018 13:07:40 -0800
From: Olof Johansson <olof@lixom.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [GIT PULL 2/4] Broadcom drivers changes for 4.21
Message-ID: <20181203210740.x5zxpty5x4jnb47v@localhost>
References: <20181201203942.13376-1-f.fainelli@gmail.com>
 <20181201203942.13376-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181201203942.13376-2-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131741_218813_1571073F 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 James Hughes <james.hughes@raspberrypi.org>, arnd@arndb.de,
 Eric Anholt <eric@anholt.net>, Yangtao Li <tiny.windzz@gmail.com>,
 khilman@kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 arm@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 01, 2018 at 12:39:40PM -0800, Florian Fainelli wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.21/drivers
> 
> for you to fetch changes up to 1861a7f07e02292830a1ca256328d370deefea30:
> 
>   soc: bcm: brcmstb: Don't leak device tree node reference (2018-11-28 13:46:44 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM/ARM64/MIPS SoCs drivers changes
> for 4.21, please pull the following changes:
> 
> - James fixes the firmware interface after a commit changed the use of
>   VLA and broke large transfers
> 
> - Stefan adds a timeout check for Raspberry Pi firmware transactions and
>   updates a bunch of SoC/firmware files to use SPDX tags

Should the timeout and large transfers be merged as fixes?

Picked it up in next/drivers now, we can cherry-pick the fixes if needed.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
