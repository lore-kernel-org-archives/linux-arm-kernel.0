Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96454C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:38:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6447920685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RVlDSyVy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8SsE1qN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6447920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PNesoxSYV3BY8f9HBc6DlwsKE2YgUvYdfNToS+E0jm4=; b=RVlDSyVyaloQ2+
	k+95GztbHQ8EMx8aqZr0crLvy2hyS0RFn+8RAsuPV20s4+388XN4zEiTtXpigr+tXp2p0eQ3+lIJ8
	60shGspvrd7zFI3oYEGQoyNTIVKuPvM1Kr8cg8RgH765v6FP+3Dk18DQEAhK5xCcN+aEfSPOlHOMQ
	MSltxyPCj6DtCaJ0At+R18bVwlK8UYEp4mv+3upZLO6lQmzLcOOW5Ir61Pv3mhcgWJz/J0PGoJWOR
	4XBEuel2+rHDBJnjVuskFCC8N4CrYQkzBpcleiPcfzxLgm3ENAISX3DiBtYuyVl5hb3iBdvKD/W9F
	sRQIvkJ1KMfyx8fFrZqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghIkP-00046d-Lf; Wed, 09 Jan 2019 18:38:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghIkN-00046M-Dh
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 18:38:36 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 00F5920657;
 Wed,  9 Jan 2019 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547059115;
 bh=zAHkjSyi+jTx0DIie4pkuFbukekEgTKpSWVM0YuaOak=;
 h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
 b=e8SsE1qNCHJvSHwA2tc38zbYfveTMH4a3ZufmnI2f55+h4z7E2F8CPlBs+ebW49bN
 obg10Rll0Qcxct8Pt5AT89Mr0+pAZbU3h4vyat9jPromqSdtW//awLnKeSOlhIwjYB
 e6UpQqe326xBYoG/9GQsbacom7qelor/eQh87UgE=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: zynqmp: Fix memory allocation in zynqmp_clk_setup
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Jolly Shah <jolly.shah@xilinx.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20181224055058.GA23947@embeddedor.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181224055058.GA23947@embeddedor.com>
Message-ID: <154705911409.15366.7750153096311644237@swboyd.mtv.corp.google.com>
Date: Wed, 09 Jan 2019 10:38:34 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_103835_472157_A8FD381E 
X-CRM114-Status: UNSURE (   6.79  )
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Gustavo A. R. Silva (2018-12-23 21:50:58)
> Fix memory allocation and use struct_size() in kzalloc().
> 
> Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Applied to clk-fixes

And I added some words to commit text.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
