Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BACC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CA22081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G0aP5Cbd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ3SS/sE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CA22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N31ol7sdMzTe2y0I331CVXOAMRLApDlX3LXOq50lHpY=; b=G0aP5CbdBlj+Vu
	LQBNWkGDJJ6ilYyiUawhs/TxRSartM54qe1zdvbo+ybJrbpKd4pphok1hHQYL0JEirAXgccCCm77K
	s5dftqkNKH35CD9ownZOYEQivbkWYu6hIWqXtHi1D/u2wzcdEyxmw52Nr9wnkqHcTcKup28jqe+kO
	lw564mrbE+A7W2+m9oC0dRVQ7oLhxbK1KTkHEky6mjfgWVH5PV4W5qF/C9xrGqqOIxBa4sBrpfi6m
	PNiyA/rpqgnJ1YcW+k8YpAz7jTlKjsaWIycREXEo38bu5qB1oW3c9BPF9U4M/L7HxeMg3vdxn8ibo
	NxlMD461UcVQgetXmt8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtws-0000H1-3E; Mon, 03 Dec 2018 19:32:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtwg-00006U-5G
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:31:55 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A5812146D;
 Mon,  3 Dec 2018 19:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543865508;
 bh=/tu1B3Tvpt5e9OWM4uOsnuS5dI/SkfzdXsllXp+AuSM=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=LZ3SS/sE7WdlrSOAvvai2uJz+RrR6ISX2hCvwVxIDjDCJnTF4HMLJmUwIXwRdEL/g
 hNkBrB0kpEuDuVoO6UeqHwsv3za+SlCs2jaxJg4MrC+bBxhOQ8qvhxk9rj1oM+yfCc
 d3MGfJ+pa7GgWl/b5hqAFSn8yo/6oa9cLnHpY41s=
MIME-Version: 1.0
To: "A.s. Dong" <aisheng.dong@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-2-git-send-email-aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <1542200198-3017-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386550758.88331.8573266036365450221@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 1/9] clk: imx: add gatable clock divider support
Date: Mon, 03 Dec 2018 11:31:47 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113154_262706_B32812F4 
X-CRM114-Status: GOOD (  13.42  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Anson Huang <anson.huang@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting A.s. Dong (2018-11-14 05:01:35)
> For dividers with zero indicating clock is disabled, instead of giving a
> warning each time like "clkx: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not
> set" in exist code, we'd like to introduce enable/disable function for it.
> e.g.
> 000b - Clock disabled
> 001b - Divide by 1
> 010b - Divide by 2
> ...
> 
> Set rate when the clk is disabled will cache the rate request and only
> when the clk is enabled will the driver actually program the hardware to
> have the requested divider value. Similarly, when the clk is disabled we'll
> write a 0 there, but when the clk is enabled we'll restore whatever rate
> (divider) was chosen last.
> 
> It does mean that recalc rate will be sort of odd, because when the clk is
> off it will return 0, and when the clk is on it will return the right rate.
> So to make things work, we'll need to return the cached rate in recalc rate
> when the clk is off and read the hardware when the clk is on.
> 
> NOTE for the default off divider, the recalc rate will still return 0 as
> there's still no proper preset rate. Enable such divider will give user
> a reminder error message.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
