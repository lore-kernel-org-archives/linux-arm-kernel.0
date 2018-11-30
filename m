Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55453C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:58:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F87F20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GaQxNIKG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="SGzToQnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F87F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8G4WeKIGe9OlWBU/fQ+8+mso9944ZNzp/rHIvcQswSU=; b=GaQxNIKG3XNK6C
	ueFGiOLkk5KBhVTEC8xfiO1ZtxFIpbsX94qjogLb3w10ka+iN6oBe51KqPRJYsIGghzCWnfrvTaVK
	ALEclMU5evxAfVTebRypImRnjRxE9/k82328GiByGIvUTj6cJQSVHIHt5S1+KnXethVmxaIww3jpN
	6NBKpG6mmPgxT3yNCTSnv8cGvVfggSQw/pL8E0coKDwx6tqflduUPMYhWkF+Hvsfka+/XR3ZtvN+c
	gR8JypmJnb6RQeyGqAz1qPRHNUaSWoiqTJQgTqPwhzTMFtWeQ+NYq1yzJ5Nn2y5Qq2XQuDjx3QCYy
	jZ7HVGzxmw1CYKIyBmCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSrk4-0005M5-4c; Fri, 30 Nov 2018 22:58:36 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSriD-0003ya-Ec
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 22:56:47 +0000
Received: by mail-lf1-x143.google.com with SMTP id p17so5270361lfh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 14:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=O6vopUd6ZAN0xMBqctvcBeiQlmEl9jbsnEeatPls4Vc=;
 b=SGzToQnHqXMibuQSi6uXQgSBCurPXdvWEAYDh6ZZzBrjEsfQee6gGHscbruOfmd9mp
 lAJRQvipMdW49chIh5ePA+iE58kzUdlvmyMtTKBw6jabQrcv8cS54VL8kuQFlk2be8Jh
 Ili5ZasDrMeCWQvxWiAPXAkZgTyES+gd45Qw5MnmG6N3vysnEFE02HtazAExc8YXkrnx
 so/ZMwIQqevAeVYRwdPCTSwmXF0Ud6nG3nX443jStJnm1G0AcoiXS6tLwD15T7rGXL7g
 MVsLnO7PucZJvi03docC7Hn8rvwY71hSKPL/++DvrI1Px9Ffc1cfk3G5RPQ3AKO0aIkB
 AexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=O6vopUd6ZAN0xMBqctvcBeiQlmEl9jbsnEeatPls4Vc=;
 b=MKz5XOpDCfJ8ont/L1R9rrEIxYfx26FiEJMPGmQfiC5sY2Bi/leSlVXm353CVhEAVm
 JVWyO0V2HJew1jXvVd7jGOyg/fSxU8n3hhPqacwmqVolSN+7+xJnL8dqlYsKqlFcjwaO
 BsI5yosaNVbA0hgiZtTJ1fXYRqIFhr5UHF5JVcX0kQh8/3FRrhJESaYIKFWrs6xM71CF
 c7W3uJybxW/AAuuDmp3dGzaJFErMmcQpWgFEQKSlxBPcTQ724D8c96CG/ho6ARGHrXVA
 +QIm/0DD0IKLqIzKfiAuqG9QOAuaZEUgnv16tG+LUh9UnLMdg8rBW2euJOk1K9gQoway
 tMkA==
X-Gm-Message-State: AA+aEWYsEq3nMuM2ePpiC71DSaVXhjqiRhXpIxjhihbxPydq/UHMLZUx
 6nD5F31bQE9yKd0TGv2SaorYcA==
X-Google-Smtp-Source: AFSGD/Vbh0PmsB+12RlTSedZ7WTiDmE2yf+y5V4aSHdrvFKB+2NZf4i7CCov1L9Qm5hRTeu8aUR79w==
X-Received: by 2002:a19:df41:: with SMTP id q1mr4893434lfj.25.1543618599581;
 Fri, 30 Nov 2018 14:56:39 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id b17sm1034044lfc.21.2018.11.30.14.56.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 14:56:38 -0800 (PST)
Date: Fri, 30 Nov 2018 11:58:47 -0800
From: Olof Johansson <olof@lixom.net>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL] i.MX fixes for 4.20, round 2
Message-ID: <20181130195847.5ju3zlaozl4cl6iz@localhost>
References: <20181130153822.GA16590@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130153822.GA16590@dragon>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_145641_961399_0655A2B1 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, arm@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 11:38:25PM +0800, Shawn Guo wrote:
> The following changes since commit 1ad9fb750a104f51851c092edd7b3553f0218428:
> 
>   ARM: dts: imx6sx-sdb: Fix enet phy regulator (2018-11-05 10:11:04 +0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.20-2
> 
> for you to fetch changes up to 512cab3e7e0be11234f965d9898936dce2325382:
> 
>   ARM: dts: imx51-zii-rdu1: Remove EEPROM node (2018-11-19 22:35:45 +0800)
> 
> ----------------------------------------------------------------
> i.MX fixes for 4.20, round 2:
>  - Reomve non-existing EEPROM device from imx51-zii-rdu1 board.
>    It was added by mistake.

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
