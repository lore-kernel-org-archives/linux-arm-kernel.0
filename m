Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FDBC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:17:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9932F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yzs7YjSA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="WcoNsykA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9932F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TbgWJTvsbm1pbbR/YrWdCOcpIDGH2fzQfzoK0izVHQs=; b=Yzs7YjSAr1jLCZ
	hsrVCONDSZsdCy3L2d5+vzXw/5LaVcc/OATV76cd+8zrHcQnYdAglR8U2qPTCSty7v2feMw4czgUS
	yPGlNX1JEZB/DBcBf+5Ax1neVYggm8WfxzW4YDMr2qHOtb7QrFlYIgz1cJXbYHS6cYAqDn3itHXpP
	aeYihFwpxX9Ef3AyvgfWZ21IjHmKMAUUwOmJaab0gKLdEePwcL38oykd3qzmAVeo/GylXQPSU9coq
	8Ua7fQbp5KkfIPxfgwzw9DrpK3aTAtpZGFhdwu1Obd/dGEUju63znyOUptfKq50h/l7UaEKgGPmhy
	frlh62/jsQQqmN7ZIK4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvb7-0002Fm-KU; Mon, 03 Dec 2018 21:17:45 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvad-0001ka-Ol
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:17:18 +0000
Received: by mail-lf1-x144.google.com with SMTP id z13so10290883lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YMvWUTyRghiKIX75ytyQEJ13qz241P7RZxsvxpUboNg=;
 b=WcoNsykAs3K13BoiognulRf68zHDcS22qqwX0TtIEVs+LvNssZHJS6TAM9rUQmgWPZ
 UOt0S0uJrZlahn8ol0rJHf3oZTTCw/OZZ81l1eOueFBqLqO4RaBmnDy4LOdMxNVlOea2
 fhY6nuRCZNto3Dm1DVlGHIBtAMMMf9CChe4FonlyBFavUQvuwfocMrtL77o6Qdya4epp
 oUEcJNWCA4U6UjCrEboIngRs4ahPyw8sCS+1SN/E7HYBzLjAgGaiVCsiseV8k7+iPPd3
 1z0brp4+FRPKe7XWFm4M344WlTxoS0G5MFDga8R3qZ1VqvcvlSN46W3TsSlkbKfBVX/W
 Vi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YMvWUTyRghiKIX75ytyQEJ13qz241P7RZxsvxpUboNg=;
 b=YlVTGTiknDoWMyt6qYXk76/XrPChvLotS6jrNi0Akt3U/5WpxEA2LQoyG6dgGL4Wj6
 19c/Y58wYR3DrMiHSfHn7bY7JhfdeGsS/UyYsrX+pTotbMNpTeh5p4zfRmc+u6UbYxXT
 6jFIcav0N/3qYrjtLgkyvAoXT9GHF/gWf468MO/BJPZmRhVO4tYqNwrDzZVEC7WmfslA
 JqTY/ald/fbCnHHm9dWtZLlJaFQcio3/BQA0jEPZFUFLgKd/3wzV76FS2ffXouwQeaoY
 KRu5NTeglT3/3kwp/Is6nFsUV/ZwXtyc/npsSAiqnOe2f0PCg5mkpgPCjHgZhAW/c23z
 O9oQ==
X-Gm-Message-State: AA+aEWb3qKl1l2nb/FrgD6RkX58NkwsTvZUHa7G/lvlHbvkYBBZ7FBrQ
 /oDPENwzy/O/BWou3NXVQtVWOw==
X-Google-Smtp-Source: AFSGD/WUCh8IXtCJca7VP4XXnbHb73ID06EkO5BpdgtP2yRZWbN3MRexxpGe4Clnx8g9vgLzPcdMyQ==
X-Received: by 2002:a19:5402:: with SMTP id i2mr9824133lfb.128.1543871821354; 
 Mon, 03 Dec 2018 13:17:01 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id q4-v6sm2656812ljb.4.2018.12.03.13.16.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:00 -0800 (PST)
Date: Mon, 3 Dec 2018 12:54:48 -0800
From: Olof Johansson <olof@lixom.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [GIT PULL 1/4] Broadcom devicetree changes for 4.21
Message-ID: <20181203205448.affzfbdwdtnbhheh@localhost>
References: <20181201203942.13376-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181201203942.13376-1-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131715_812110_FD8FF36F 
X-CRM114-Status: GOOD (  17.11  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh@kernel.org>,
 arnd@arndb.de, khilman@kernel.org, Phil Elwell <phil@raspberrypi.org>,
 =?iso-8859-1?Q?Ren=E9?= Kjellerup <rk.katana.steel@gmail.com>,
 Eric Anholt <eric@anholt.net>, arm@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Vivek Unune <npcomplete13@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 01, 2018 at 12:39:39PM -0800, Florian Fainelli wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.21/devicetree
> 
> for you to fetch changes up to 9994241ac97cb84d1df98fdc172d3cc6b04b11bf:
> 
>   ARM: dts: BCM5301X: Describe Northstar pins mux controller (2018-11-30 10:35:02 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree changes
> for 4.21, please pull the following:
> 
> - Rafal relicenses a bunch of DTS files he wrote under the GPL 2.0+/MIT
>   license and adds proper SPDX license tags in the process
> 
> - Rene adds support for the Linksys EA6500 v2 Wi-Fi router based on
>   BCM4708 plus two BCM4360 and BCM4331 radios
> 
> - Phil documents and updates the vchiq mailbox compatible string in
>   order to establish a correct agreement between the Raspberry Pi
>   firmware and the ARM CPU's view of what an ARM CPU cache line size is,
>   he also fixes the mailbox "reg" property to be correctly expressed in
>   bytes
> 
> - Stefan updates the Raspberry Pi Zero DTS files to use SPDX tags
> 
> - Florian enables the SATA PHY and AHCI controller on the BCM63138 SoCs,
>   he also does a bit of refactoring of aliases for the Northstar Plus
>   DTS files

Thanks, merged into next/dt!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
