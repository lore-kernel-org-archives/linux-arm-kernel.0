Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B61C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:56:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776232145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oFZgroUw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4AqeZwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776232145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZMvKNbtX7WnHnwrKxJHBf2VibUYCGb+fuODaxJ33QeU=; b=oFZgroUwbd/k4x
	Rj+JWXSdXlvEW1F6gvm+YyAFb/HrNdJ//C8I0RimhYPnZKbc6xMq99tv0myBao+HQi6vebyuoEvgZ
	7epVTHRyBNz7ZfH+AzbXV0cnT1KGIgL68qUL4bKhefb0QfBUB69hAU8nG97LqEGZnOirlgQ4fYy0Y
	2Iq6LSy4ueMAxCwtLKQCg1RdONdVhd4AjF/4rx7TfQJO2hXbeSANiU8JkP4vP3h/c/48leyeKIXm9
	t6OCgZu14F02nYKqAfF8HUQC7et/v0qF5VfKx3XT8gS7pE+DqdCOKdQZCurkHDZm4vWyVppsEAK2c
	OJXxOKsA/beqxR8W3CJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gScjK-0000vd-70; Fri, 30 Nov 2018 06:56:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gScj7-0000kW-0U; Fri, 30 Nov 2018 06:56:38 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E40C2146D;
 Fri, 30 Nov 2018 06:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543560989;
 bh=7AqF5/17soKo9H50VVQU7Jnbt3syLQ7EN/GeltKuMW0=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=R4AqeZwJHnoJzYNF8mM+Sn3nQirqpsIQY9Yf8624cUjwoMbxE5FKZtoynSUTW8UTX
 3j92PWCBAu4la8MkeAmedg642WvVGook0eZiTCsicFUqDa78MitsWICWJMwsgi78RN
 3JSH4w2EKpqF3tWZ5B1v+g419znXR7vtubpO0rkY=
MIME-Version: 1.0
To: Rob Herring <robh+dt@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <b947cd11a6b13a7a160bbb6af42261bf50bffe28.1541143168.git.ryder.lee@mediatek.com>
References: <815e38d4d74689980cd73c86d9e80fd5854cfc94.1541143168.git.ryder.lee@mediatek.com>
 <b947cd11a6b13a7a160bbb6af42261bf50bffe28.1541143168.git.ryder.lee@mediatek.com>
Message-ID: <154356098889.88331.174460941207189207@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] dt-bindings: arm: mediatek: document clk bindings for
 MT7629
Date: Thu, 29 Nov 2018 22:56:28 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_225637_077922_379C8B7C 
X-CRM114-Status: UNSURE (   6.17  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Roy Luo <cheng-hao.luo@mediatek.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Ryder Lee (2018-11-05 00:43:56)
> This patch adds the binding documentation for apmixedsys, infracfg,
> pciesys, pericfg, topckgen, ethsys, sgmiisys and ssusbsys for MT7629.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
