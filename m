Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F8AC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:06:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356522075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A+j5h943";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIDmzxHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356522075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EMA+DkSRblwLYG1CYur0t+i17KLPBQ4JTlxhGiHfb+0=; b=A+j5h943b2bJkc
	GnrK+KbuRPQwsbvpXIApyAHzc9/n+W8Tk60exSa7n6IHn2d4wrckjtB+VNPeNls7yzI/K0OoQZPoH
	lVt30watfrc3/gRUFSu7Nm/RGcFdlBhwZW5C+smt0k/CYG1x5+IcnLxvZ2+12K6LnFTEa28+n3N2b
	TWBIWRwLJcLClQxcWa36zvy3Q9sc7hCDHauOUW9Tt41J30MlhYA4urIAQGpJbo1K/oYOiqqaHT/LI
	FdNmtL+iPx2M5ZgCAq3MI3jVgetVTnd7A398Y5Ql8smm6rlbp65uzwf0a4cMwd7DzjPUw94GIcK9y
	PSt0pUrrfRvZTajh+FTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcsJ-00035U-4k; Fri, 14 Dec 2018 02:06:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcsG-000355-99
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 02:06:45 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4444F20870;
 Fri, 14 Dec 2018 02:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544753193;
 bh=oofKFFdzq2Rza/u4kJvP+EsLTIxPjnVd1+e3slj+aBE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TIDmzxHyHJUce+shdW9CMtF49h7VHLSCYj6hSK9f4tO9TjIU531qr7u/f4MiNZOBo
 I1m5/4yURy6SyrR9OO9EgmJtQQfX5AKj3AVoIjxevy1RgyqAkI9vY/ukyVhXuh8y/y
 pvGnaecJiwmj3oJEh4MIaYVc7IqM5oSAVCXvd1+M=
Date: Fri, 14 Dec 2018 10:05:34 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V12 0/5] clk: imx: add imx8qxp clock support
Message-ID: <20181214020533.GC13243@dragon>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_180644_334538_A66DD0B7 
X-CRM114-Status: GOOD (  10.05  )
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
Cc: "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 03:42:46PM +0000, Aisheng Dong wrote:
> This patch series adds i.MX8QXP clock support which is based
> on the clock service provided by SCU firmware.
> 
> Note: It depends on SCU driver which has already been merged by Shawn.
> So this patch series could go through Shawn's tree as well.

To be clear, I'm not going to take this via my tree, and it definitely
needs to go through clk tree.  If there is a dependency on my tree, you
will likely need to wait for the dependency to land on mainline and then
retry.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
