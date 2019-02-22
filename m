Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB12C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:46:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C79920700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yu5hfQic";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJjR4trV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C79920700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QptxTj6PdWzUA8F6mKKyxerm993NXW+4B38e5o+RsYY=; b=Yu5hfQic0uazVt
	PxxJ+JM7NiZ1nL/22DDn8NOPQr/cgWkTTbmWLd+5uQ2YLFqXxUKj4pRNKoprQxkCW659inAUqLRKj
	qYfTewYN3DgyTRNK5I/Ma6Y71WQyULQqwUz2bMalb1FZKGVEAwFsFbYCCaldWE6RyeBpVylObai5R
	tNTOcW/g/EDxBas0A42uCA42Cs9lVJAFfajt8BXWnVe80pMABsoErun8TArqxmj/fpM8HkdTK78vm
	i5UNyshRyCZ5X51uKEIFqTsfrziSWtb8x572U21XdKs2gzc9P77+P1ypGkmYnvz9lC0VApslOrG99
	5Li6Tdntz2mZxMz5jDdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxEu3-0000xN-Qp; Fri, 22 Feb 2019 17:46:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxEu0-0000wz-Nw
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 17:46:26 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 459E520700;
 Fri, 22 Feb 2019 17:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550857584;
 bh=FKwqrUUguu6NXIhqOpxtDvpDKNPuz1Ra3atbXUUhTWc=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=mJjR4trVsbcC/03rAfScJB4DuFBnG1OW7vXMZZ3kZ3m5PEI2xnEILwW2h6LPsvcbn
 5F8/SHFwx1P3JsDdkiiGxd9skUIEbR3sPvGGgo8h9F7WSMF4q0F1B5Duy76Y1xvF29
 /0J9CnP5GAXIelVhFL4gvpoQWLjH1fk6/iFbf7rU=
MIME-Version: 1.0
Subject: Re: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Message-ID: <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
To: Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 Anson Huang <anson.huang@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
Date: Fri, 22 Feb 2019 09:46:23 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_094624_799611_DB872E32 
X-CRM114-Status: UNSURE (   8.20  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Abel Vesa <abel.vesa@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2019-02-22 09:07:32)
> Make the entire combination of plls to be one single clock. The parents used
> for bypasses are specified each as an index in the parents list.
> The determine_rate does a lookup throughout all the possible combinations
> for all the divs and returns the best possible 'setup' which in turn is used
> by set_rate later to set up all the divs and bypasses.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Tested-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>

I suspect these tested by and acked tags should have been dropped,
unless you discussed and tested off-list?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
