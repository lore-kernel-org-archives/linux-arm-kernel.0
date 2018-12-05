Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4A1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:30:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4D720892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PZsI5BTQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxqcjrz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4D720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AcAY+AtZOLzUQ7yggtWXxAHq1/2Ktb5lMxJSEQAi/uw=; b=PZsI5BTQzcJVBt
	G4L5dljBTt9oQ17xdvlIIR1ze8Sxa+9bTQIrWCcthlJKqEl0yNz/aP1x6GtCD3JgGCTwUMlGtFiHS
	XaBs+kqMyOj4+xaYOCPH2Xqrv32+ExwmoEItOdexqWyMqPq84xBwc8U5GctxhqJZHElt4jmQOo04H
	EbqxJiIKzB8tH4apb/DvllOpjv43yLJxqu2Ec10j6HaWnZy0/igZNt+hmHI23RG1m6ojKvEy9uEsq
	0Phjv/scF4S9Kvatwe2Yofqo7aeg26rCGEBm58DG3HwxrnK6r819qBAUbLnQeCuQBor/mgBGShJ+n
	o5wb3Qh4QsH7Tg0UPvLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUdog-0001gS-Tu; Wed, 05 Dec 2018 20:30:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUdod-0001f1-Rr; Wed, 05 Dec 2018 20:30:41 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 542BE20892;
 Wed,  5 Dec 2018 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544041829;
 bh=b4oyxS4iMopUp29m2C2NQI+PNAYq+8M0E0GyaLOMv9U=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=dxqcjrz6byhUjV+YY09tMOlRnBZSZLW+Btc/O2OxbP9Vu4qdqQjLkCpajGo0AqRov
 K7P97hNaGvz1o5Y+79k70+sbRyBgUx6zsgrGw3x3WjVB8xJt3XKowpZwRbvB0GuaFL
 VHVo+1H6fOzSQHqqDmazP/lZZtl2MjYgDeLVpUQg=
MIME-Version: 1.0
To: Ryder Lee <ryder.lee@mediatek.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <2e828830d051ae641cfd55a6590cb243539d6ca8.1543991319.git.ryder.lee@mediatek.com>
References: <2e828830d051ae641cfd55a6590cb243539d6ca8.1543991319.git.ryder.lee@mediatek.com>
Message-ID: <154404182868.88331.17985605359797731500@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: mediatek: fix the PCIe MAC clock parent
Date: Wed, 05 Dec 2018 12:30:28 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_123039_911622_D0E507F3 
X-CRM114-Status: UNSURE (   5.83  )
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
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Ryder Lee (2018-12-04 22:41:10)
> The PCIe function doesn't work as the clock tree of MAC layer is wrong.
> Hence fix the clock table.
> 
> Fixes: 3b5e748615e7 ("clk: mediatek: add clock support for MT7629 SoC")
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
