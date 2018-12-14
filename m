Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6269DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:09:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992302080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DSBVOvHr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="prQgo4xN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992302080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jm3hkeQbh3KkYZz5+sbM3y3vQ+7F/aNtW5uTAGHa50E=; b=DSBVOvHr1Ww/VR
	3oobRahBnkfNFb0PIhKfaS4wbWBCe+qv3ouQqAc1lyf7cVbXSCt/ZdNykUp7XyM3XAKDL7oG+3xbl
	3ABM6T8DFeugZPGMJWT5CPafubGQBNR5shkODrAsfxOkQ2QbJTrO+1xRUf28RvB4iOiUl3DV8oiKb
	1Za2V7jq9WFuijRtmdA6MGLBmGxVTZRcbx77kmoTMtoFf/W2lbsLh1b4bHrTcOglUhwnbAD0RKhmu
	dEQ1dZBAEQtAG2ilv0xVc9m0mhpAosGyxBd5ebb26FtFlLD+ocZOuYamDauA1XAxY0ui4x0F/E0Eg
	cCruZo/29idqM3OhjH9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXveL-0001Em-PM; Fri, 14 Dec 2018 22:09:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXveI-0001E9-6B
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 22:09:35 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 31AB72080F;
 Fri, 14 Dec 2018 22:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544825364;
 bh=uwkyTDQFFrU8AareHfHeF0viFesQNKGmlCXwm+jQL28=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=prQgo4xNt2dHf7mcWChlj9xO+1in6q6orETggpfdjJXm6LhKLjZdUSHps0Ra/Savn
 TDcON17dPbRTIiNVpyaZApEXUg+CuKbmJTW7HlpFUtvxk7aZnUtuOmU9N1SdUeCO5J
 QawF17klIKAbkky62l+lp5mrmiIifKlyltPMd46o=
MIME-Version: 1.0
In-Reply-To: <20181206171516.15891-1-gregory.clement@bootlin.com>
Subject: Re: [PATCH v2 0/5] Add CPU clock support for Armada 7K/8K
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181206171516.15891-1-gregory.clement@bootlin.com>
Message-ID: <154482536298.19322.16460657058404864070@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Fri, 14 Dec 2018 14:09:22 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_140934_243848_472E4BAD 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquèl Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Gregory CLEMENT (2018-12-06 09:15:11)
> Hello,
> 
> This is the second version of a series allowing to manage the cpu
> clock for Armada 7K/8K. For these SoCs, the CPUs share the same clock
> by cluster, so actually the clock management is done at cluster level.
> 
> As for the other Armada 7K/8K clocks it is possible to have multiple
> AP so here again we need to have unique name: the purpose of the second
> patch is to share a common code which will be used in 3 drivers.
> 
> The last 2 patch enable the driver at dt and platform level and will
> be applied through the mvebu subsystem.
 
The binding "marvell,ap806-cpu-clock" is not documented. It was in the
previous series but then got dropped from this one? Why?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
