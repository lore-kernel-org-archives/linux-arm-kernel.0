Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90482C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:54:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B3C2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hHzEYZiJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmaWbTEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B3C2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	Message-ID:References:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/IOQljrpBJjCikXiPRpG/grr0M9Yt/AaB10O/THLEPQ=; b=hHzEYZiJt0IAiY
	ldjWC29+q1rJjDUAoPPtREPAnWpbm8Hq+eTCn7zBPD2Pvq1nQ8pW1UEFhBJgG/HhUve0TN8FZaZ/Y
	5sB8B6HrGaHyf0eE9K/jqeN1PANfgykYd6DBbU0AmUuYZrmMEwS6d2+bRJ94nONSWqZ+Vr5DfntRn
	Jo4NEPsgPx6zll6yF7etjkSlbU0/F0x7j7/3ynM28OScIYJrkUGklM/IXoUkoVnu/dAUi19z1M47j
	j8mQ6ilWiX2Kwuy9ElkNAAufjS/EUyqbJnaVYDQ+8P0XDjfYUL47YbkyqGTRedecjCPwvZOmYbznj
	XwijxCM22Brylem3xuyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygvb-0004DN-5i; Tue, 26 Feb 2019 17:54:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygvY-0004CK-8q; Tue, 26 Feb 2019 17:54:01 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DB0B32173C;
 Tue, 26 Feb 2019 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551203640;
 bh=L6sNzpRdCs77FMR+H0CNf38dl/Ds4JhU+XhECeoRiHM=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=nmaWbTEnHU72tvS/4TnuU5sS0trLOEON3gJJBzJW0Ivu6WW8u+GmqXk8wNNDcMeyw
 Pm4rng5sejODg0JjDiFHYr1NDmLxUKUNr/RUnUVOdMD/8MtS2ddCy8PZRbMrvrBmDp
 lZxE/FjRqk7q1p79qhvHi+xdEmGB3Q/u28Xf4K0U=
MIME-Version: 1.0
To: kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com,
 matthias.bgg@kernel.org, mturquette@baylibre.com
References: <20190214163218.26148-1-matthias.bgg@kernel.org>
Message-ID: <155120363907.260864.15274639985767740118@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v4 1/3] clk: mediatek: Add MUX_FLAGS macro
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214163218.26148-1-matthias.bgg@kernel.org>
Date: Tue, 26 Feb 2019 09:53:59 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_095400_331658_D5B5777B 
X-CRM114-Status: UNSURE (   5.00  )
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
Cc: sean.wang@mediatek.com, linux-kernel@vger.kernel.org, jasu@njomotys.info,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting matthias.bgg@kernel.org (2019-02-14 08:32:18)
> From: Jasper Mattsson <jasu@njomotys.info>
> 
> This is required to mark outputs of certain MUXes as CLK_IS_CRITICAL.
> 
> Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
> Acked-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
