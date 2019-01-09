Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2B8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:10:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6ED214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ccbUDeF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6ED214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s/AdYF/5cRRFGhsRwiWrnli/INfBA36Op5rLnXETmPM=; b=ccbUDeF/i++S6f
	Ua06m5TYS7LB1nxn7Hu/laGDQYOkR9BRiIylzk1rO+4TXQTsWP1eZu2g5ZG/CLce+8s+Wc4oNyAGC
	YIdyDGGRtbIizTQH4Nh2qjZWedDG5dziSiLKOQvaPQImlI84E/XVBFWbBTmLxsaVseQ0O0BcnigDs
	3yynrGqsDJ1sxCfdDkX5Pjg52f9d6whQPrsNJTU5CZfscwZml4Uhgf9Oq7fgXuoW3eURPUNyFa5Sg
	xjzzGz8VhGJKYO+Q1Li6nkeXBfT8l46LQ7Hx6FLhXeWCFknQh7A4/tBuqdtjrpTJVUr0kI92ZIouU
	lJiZGRzW3lZ8Ym5m9zYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghJEq-000239-Vy; Wed, 09 Jan 2019 19:10:04 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghJEm-0001mO-Nm; Wed, 09 Jan 2019 19:10:02 +0000
Received: from oxbsltgw03.schlund.de ([172.19.249.20]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXGak-1gmF9N3AlC-00YkVV; Wed, 09 Jan 2019 20:09:51 +0100
Date: Wed, 9 Jan 2019 20:09:50 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Message-ID: <1739529063.54681.1547060990832@email.ionos.de>
In-Reply-To: <1546034967-2427-1-git-send-email-stefan.wahren@i2se.com>
References: <1546034967-2427-1-git-send-email-stefan.wahren@i2se.com>
Subject: Re: [PATCH V5 0/3] ARM: dts: add Raspberry Pi 3 A+
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:HmwJ1/semdqoaOo1w9Mr2zs8Tf+Y9r6rPO6DqJ2cNsonV8XNQPq
 A5KBGY4woy+PPNMNWdPshZMm8tLJgx6hmDhIHguxMEHjN5Xrsc709qKNKKfQfzm43BaaGMy
 TqzCycIk0LAcK4PIyFRNUnF98dOD7LS9hKwrqmQykLho/6bcuvIiTFcFqEAM/AEhpcFAjd+
 Gxjcg/IU8ioJNLrNiZF+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P1lowX0IdWQ=:cvLp/CTHO+x8aYN9TAHTNC
 AeSoj1+uUWKz7j3EkWOU4L8JCoY+wi5ygQS9zucin1slAodRe0vUX3c/PRh3+jfSxrJd4dXhJ
 lJ2MP/opp0bsRmrkuyKwRseAffmOL9DF5Qdv/hIuL+ePVnJpWOXA5eV8BplHJ2nUCy9nSU0Uj
 mHmCF+dJqE686csFWv1ro0TbKteCxmGDphco+KQPYbzy5jJm8/sWt/phHlxQjD2fwzz5POCKC
 TcRTzitg1m/tDwZYU/omufUZxOhlCWax38vHlnyPOieYB/nZByqTsjyGGPcyfSArzle0MWb3X
 CzInMsxoO76QG2DnYKLm1YOs6sPi7KciuAnCnYcDPpjhckiXQxq4gWA8rC1QcPmpErTSF6oLf
 RbBCKwbHCAwCO5aZ4dhb7/ntWms+1TWjlbBsXhNerm1sow/JE/QYhCb1D1qiQ7mdxq+wINOYH
 ZuBqfza1hE8E0/lI28ahyDqB+4oV+vFYqC7u7nx1dX+CrvAK+wiiTy4vOO01uZ+f/ojx2+tMP
 NPjReQ1lvnDnu/cAoT7Px0iCjfAn6/yf6LL5sxEbIRBc/tXSqfDIU9BkeI4M+bzi3kTrMoGsu
 oaCYvAv3DUqTbUm+vomDI4AhhBdzl2C37KdRG6E5/yIyZHBh0KGqYKkIM5Xn45uOIxY2Di1nW
 NLKJEHwKqnVrIc7c3yYad5TuFLXsSldUb4nwcfFY+KNlwwdImxYeFWteoWQGCJvA0Gnk+bjrf
 ovRz67sI7S1i2Vtarp5RSUYPRz8vm6azkSQFoR/vuhXATdWsavbQLWHqcsI=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_111001_071196_1ADF7A31 
X-CRM114-Status: GOOD (  14.63  )
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
Cc: devicetree@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> Stefan Wahren <stefan.wahren@i2se.com> hat am 28. Dezember 2018 um 23:09 geschrieben:
> 
> 
> This patch series adds support for the brand new Raspberry Pi 3 A+ .
> Since there is no official DTS file yet, this one bases on a procfs dump and
> the dt-blob of the firmware [1].
> 
> [1] - https://github.com/raspberrypi/firmware/blob/master/extra/dt-blob.dts
> 

Applied to bcm2835-dt-next / bcm2835-dt-64-next

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
