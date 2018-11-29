Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17B4C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:45:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31962145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QdSTYe3l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1T4GyXw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31962145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gPKocBd/knWkhE3x1cuZE7bd3miPL20f6NPsLYBCSOA=; b=QdSTYe3lssP4VL
	AcCyWrTNxctZuZE8dLd6FA+dXHGHiq8yEO9AWpuxZSFl+qdISZWIJ5Wd1UUoYc0cTWgQMQvDZnGV+
	INvkADntlKceBTbvKLARWbWGEh9auKTv1M8XNXKgnQ42IWZ/PBzbTXvyJLAd8Y+LxGLSuK5NzlNol
	YQFajjJMs0SNcGXZ5bCDT+BGfZQjyXqQQTiYJ00xmeN9FYAWS9Qa6q6GW7dvdvxJfZyRNJ7lzQrPb
	VGNM+nkYpZXrubU+dP0ec3CivfoD9ZiXLcirsgtBM3JJiVTS/eMnz/HH5QNCBct64uYyNlHO/CGi+
	QSN35AiYgUW2u2QL0t8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSW00-0004sA-K0; Thu, 29 Nov 2018 23:45:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSVzy-0004rP-7g
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 23:45:35 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C35C02145D;
 Thu, 29 Nov 2018 23:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543535123;
 bh=49zSS3k4eVEOrNLBfQTbyTe+luG824xEl9+CeksydJY=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=1T4GyXw/zxaLfcGQJ4aE0ByvOhGtC2wi3rJibQdfCUuLt1xB7ManGeFtJg+SYj8qR
 J26vRrAyay0YiMf4XJATTUkabb/Ao7rLBI7nuym4oFhnsT0z+eV6ts5sH+ZzQVjlqo
 v/AVxXIhbY5qjVZVDVDiTGl+4GwFdg7B1+vAAmZ0=
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
 Nicholas Mc Guire <hofrat@osadl.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542803310-32673-1-git-send-email-hofrat@osadl.org>
References: <1542803310-32673-1-git-send-email-hofrat@osadl.org>
Message-ID: <154353512315.88331.4548631955021366823@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2] clk: zynq: do not allow kmalloc failure
Date: Thu, 29 Nov 2018 15:45:23 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_154534_301499_67580C00 
X-CRM114-Status: UNSURE (   8.64  )
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
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@xilinx.com>, Nicholas Mc Guire <hofrat@osadl.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Nicholas Mc Guire (2018-11-21 04:28:30)
> The kmalloc here is small (< 16 bytes) and occurs during initialization
> during system startup here (can not be built as module) thus if this
> kmalloc failed it is an indication of something more serious going on
> and it is fine to hang the system here rather than cause some harder
> to understand error by dereferencing NULL.
> 
> Explicitly checking would not make that much sense here as the only
> possible reaction would be would BUG() here anyway.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---

Nak. We don't have any __GFP_NOFAIL in drivers/clk and I don't see a
reason why we would want it here either. Just handle the failure, or
don't care if this is so critical to system boot.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
