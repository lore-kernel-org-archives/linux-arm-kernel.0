Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE42C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:58:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C186218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KUm9mYCT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6IWwxj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C186218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YaekpEsDZyOJz3myWhBqSjFcocSzBVzNjMYonKBWQRs=; b=KUm9mYCTahYFPF
	btjHJrHXv15abdUDyF1gCMhoG/89e9cg9ZNyrM6wVn5qlE9ivkJVO7oboec82cGpfBOYDEQlMR9pg
	YYxh4vGW761bOE0xRts53I/Qqnp2Ykw+3THdeEbeGJPz5/dnWjvNNzS5Pux6MAkwg5IDSeBm96Y13
	0pHGUm+8Qz+vAWsKgMBvbLDY5qXGxDRvozq2+GSj/LSOhSjEItNp1ZvU5yGT+FuiJCcLsMTko/XlL
	uu/sQh2DwzhQVvDjLtE9h+UM9d1gIRlJNpGnnj1uwhv2aHm+Nyb+1P++S5c3eXVwwsMpVc6RzespW
	Sr2ZRPYcyah0psD4H3BA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmiKI-0000Fw-Aw; Thu, 24 Jan 2019 16:58:02 +0000
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmiKC-00009e-Tr
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:58:00 +0000
Received: by mail-lj1-x234.google.com with SMTP id s5-v6so5843132ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 08:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=2j3fgzl9GdufTs+aGQ8Rghc2YkcEWvP8KqeJKctdyYw=;
 b=c6IWwxj5FVT6evmCq+mJWZ4bnC9UvmVpb4eTSZeEF+0JdmvRtMTjEXvniA/B6zmbQy
 vcbF5Y5O/NoWvcI4F6STI2xKSd9uKrN2+OjG8zSWkTAQJfrQ3f3SxuWh4VpejfGwAYWg
 1p2AWndjVsDnpBxirisLJGws/As6ioXBKLRfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=2j3fgzl9GdufTs+aGQ8Rghc2YkcEWvP8KqeJKctdyYw=;
 b=p1S5BPYqfyZhV9yixD3arXNF7kcNJWrLdzX857/ZJKCCpKq3olwsvqoi5nav0Ylg4j
 UbxGhz5QqUdOcjO7xu1T9cgDwGWyiK4WVta3ZwHHvdHkn07bgcgszm7r+gu50c3nzUJn
 7hoNTGW4id/exEDjZ1mzYYAyygujMI+VX3jdik5psWmtcjXflApph1MKVQ+Ckt4z7y/k
 RpEMOHCGCOcvDAEnC+ZSftG2SlD+tCMIM8ZmKA9w6CHpR4D5OZCn/NTb+wZKONvoSY26
 +nNyze+zTqSH8KGuXQEfCnSTLjUu8pKwPzU5c+kqg/jPoSuLAxGAiFcYRN0OOhX41L25
 WmHQ==
X-Gm-Message-State: AJcUukf0z3GdMjGemrlUb9dGQPQtEizPKhqT7x6kxZnl7lMUbUdiAy3D
 3muoGL05i8GnwyyAzz83Y/sFShjNvtBnXinsmW++Xw==
X-Google-Smtp-Source: ALg8bN4g7grKDMN59Ze9hHhcokbn5BsOw3tjCToIOPIKLdLztl2MfsFaU1rB8JU4fqjdi6y7NzQrI9rg48rxmYGL4tQ=
X-Received: by 2002:a2e:3012:: with SMTP id
 w18-v6mr6049605ljw.75.1548349074140; 
 Thu, 24 Jan 2019 08:57:54 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Jan 2019 22:27:42 +0530
Message-ID: <CA+G9fYv0m79UC+Pq9Cq_5vGcos8A87oPYA7Ph7LUyZrfEkLXQA@mail.gmail.com>
Subject: linux-next: arm multi_v7_defconfig build failure next-20190124
To: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_085756_961425_0C348FD6 
X-CRM114-Status: UNSURE (   3.79  )
X-CRM114-Notice: Please train this message.
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, computersforpeace@gmail.com,
 gregory.0xf0@gmail.com, p.zabel@pengutronix.de,
 Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

linux-next 20190122,  20190123 and 20190124 build arm
multi_v7_defconfig failed like this:
drivers/reset/reset-brcmstb.o: In function `brcmstb_reset_probe':
reset-brcmstb.c:(.text+0x110): undefined reference to `__aeabi_uldivmod'
reset-brcmstb.c:(.text+0x160): undefined reference to `__aeabi_uldivmod'

Full test log,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/448/console

Best regards
Naresh Kamboju

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
