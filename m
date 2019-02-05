Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32BCC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:29:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF25217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b7bhqW8Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYQE+qUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF25217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:To:References:
	Message-ID:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u65QdrH8AwjIZFZ64cRg1uXh9oEDUEXnpE8qPZHXWEI=; b=b7bhqW8QiA5TGq
	EirL7wlfp/xcDVh/oqdFj9Rj19bn6tmZfbvrghfXAp0v3qTaDaNQYTxEVrq6X+ttoXzOzU8xwhpzF
	jUzSq2E5Jx5jMMCl6/ZyHo0b82MB4Njq2Q7jRXAblVb4MJsDEejHOYSy+JRHccBBFbVKPOohDHYNF
	NT9dCflvQ2Ka82q1abldiD4pJFWIoNW6Qkb3YKfGVqYqqTmHe+c5CY+ZMLBUmEgIYAS1an/e3w9Ck
	/+JeL0RFMNaPYaAq3ZgE6VTsr8okR3072l6SMd91WkckCAcv8D8BcmMX4Pcrv3oTsU1mRt7TFAWrF
	ymII6Qh2LYgqHC7GEWXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr8Hx-00033Z-0F; Tue, 05 Feb 2019 21:29:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr8Hs-00032Z-Gh; Tue, 05 Feb 2019 21:29:50 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2D66217D6;
 Tue,  5 Feb 2019 21:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549402186;
 bh=ZP5E8jQJR9FhiqPbHYxquvqdcJKLTBhGOgfWvKEmLhs=;
 h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
 b=lYQE+qUz/rKFTC9mVVeAtBT1xgNb5wLVX75NuQEqnKHjB5ZInJIBx1V2C4PDr57Pn
 B+clZedrndeDjic0I2swbLemlXwxHzw+GJV/XaCcudJ6iTIObiEJgjCj2TQZMf2snQ
 gzTOMgD+U9Sh2otxEnw5PxHffGDB4RvbyWLaaFTE=
MIME-Version: 1.0
Subject: Re: [resend PATCH v1 1/2] dt-bindings: clock: add clock for MT2712
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940218591.169292.1772059946021644625@swboyd.mtv.corp.google.com>
References: <20181214020417.2871-1-weiyi.lu@mediatek.com>
 <20181214020417.2871-3-weiyi.lu@mediatek.com>
User-Agent: alot/0.8
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Weiyi Lu <weiyi.lu@mediatek.com>
In-Reply-To: <20181214020417.2871-3-weiyi.lu@mediatek.com>
Date: Tue, 05 Feb 2019 13:29:45 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_132948_575806_9C6AC6D7 
X-CRM114-Status: UNSURE (   5.58  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Weiyi Lu (2018-12-13 18:04:16)
> Add new clock according to 3rd ECO design change.
> It's the parent clock of audio clock mux.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
