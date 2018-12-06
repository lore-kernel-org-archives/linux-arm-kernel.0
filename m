Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41BCC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:34:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A7C20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OsyewEQZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7OiYgAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A7C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HICNI9psoBQgV4NGIWBxzeqv2EIDnFjerYtClFPCKpM=; b=OsyewEQZ1QvOcs
	svlfFcB38T9J5yK417pY1Nj13uplgddg/WKs3muY8wn8wM0Ufs49Q+Kx+W51AQ9pYofG080X+a8Vy
	5q8RYBA7mRcVKEYhLlVtL9caRvHjelbhyt0YekgBfyhm0ozBiIQHUDa6bhTMLaFhme2atDLjkwsOh
	DBxZkveKrpHufhhqaJQyrZCjF9RT0tilOS8c894C8V+wdxckMRjshf17jZXwmL4f3GyMaj8oKFr7v
	LpiyrOTmlWu9sOTlEh96g/NWD/yIMUFIJ5O63RZ5hWfXpZbRMXAyrD4GOwUyhwLMa9Q2s/+fy/rFr
	bWqWf87rUmm0nRYYcneA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyTa-0001oF-7H; Thu, 06 Dec 2018 18:34:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyTW-0001aJ-V4
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:34:16 +0000
Received: from localhost (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1DB5320892;
 Thu,  6 Dec 2018 18:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544121244;
 bh=ok9FelNOkJo1RjlM1vN19T5cC5Nm7k/oKnNz+ST6o+A=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=d7OiYgAHquP/YY5/lH4loWthw0q24pOVW8sUfYNmlDi5LRZmbM79Z7FyRvz6sLOVL
 E0fh75EJ3fN43a3cr9wcLJWrnkJltPWMJto7SukMcVmh3KTFZSHSJDJLzRUkG6JPwL
 INulEQ4w+6SnnihjT1LpvOIJgfNPDztxr0NA0/Yc=
MIME-Version: 1.0
To: Andy Gross <andy.gross@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <cdeb3962-81a2-48dc-9b75-d97a817a0da9@codeaurora.org>
References: <1542314695-24071-1-git-send-email-jhugo@codeaurora.org>
 <1542314695-24071-2-git-send-email-jhugo@codeaurora.org>
 <b50bc3d4-f80b-6adb-c28b-1be254eb7e16@free.fr>
 <0ba54ffd-1d47-5ae9-ae9c-4a03d57e6ff3@codeaurora.org>
 <20181205164843.GB1492@tuxbook-pro>
 <05b9ee40-d51e-3f80-8ca4-217fa6fbd51c@codeaurora.org>
 <154404384283.88331.2522037578224950651@swboyd.mtv.corp.google.com>
 <14cad8f0-7388-16a0-b1ba-4cd5a469a17e@codeaurora.org>
 <154404615332.88331.10043835293734703587@swboyd.mtv.corp.google.com>
 <cdeb3962-81a2-48dc-9b75-d97a817a0da9@codeaurora.org>
Message-ID: <154412124335.88331.16092762627424651997@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8998: correct xo clock name
Date: Thu, 06 Dec 2018 10:34:03 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_103415_040606_AB3D2EE5 
X-CRM114-Status: GOOD (  19.66  )
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
Cc: MSM <linux-arm-msm@vger.kernel.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jeffrey Hugo (2018-12-05 15:04:01)
> On 12/5/2018 2:42 PM, Stephen Boyd wrote:
> > Quoting Jeffrey Hugo (2018-12-05 13:20:07)
> >> On 12/5/2018 2:04 PM, Stephen Boyd wrote:
> >>> Quoting Jeffrey Hugo (2018-12-05 09:03:54)
> >>>
> >>> I don't quite understand the patch in general. The xo_board clk should
> >>> always exist in DT and the fixed factor clk in GCC is there until the
> >>> rpm clk driver can control the XO clk state vote for the kernel.
> >>
> >> Sorry, this wasn't apparent.  It doesn't seem like this "requirement" is
> >> captured anywhere.
> > 
> > Agreed!
> > 
> >>
> >> As far as the SD clocks are concerned, they are defined in GCC, and
> >> eventually have a root parent called "xo".  "xo" isn't defined anywhere,
> >> so the SD clocks can't really be used, and the hardware doesn't come up.
> >>    This patch "fixed" that, but I missed the link to the rpm driver that
> >> Marc pointed out.
> > 
> > Hmm ok. The SD DT node should just point to the xo_board clk for now and
> > later on it can be changed to use the rpm clk when the rpm node is
> > created.
> > 
> >>
> >>
> >>>
> >>> If anything, change the DT node to be named xo-board instead of xo_board
> >>> because that matches DT naming schemes and then add a clock-output-names
> >>> = "xo_board" property to it so that we keep the underscore.
> >>
> >> I see this now, and I agree with it, but then SD goes back to a broken
> >> state because there is "xo" clock for GCC.  Its not quite clear to me
> >> how to make GCC (and thus SD) happy again with this change reverted/fixed.
> >>
> >> Bjorn mentioned offline he is going to take a look, but he has a few
> >> other things on his plate first.
> >>
> > 
> > There is an XO clk created in drivers/clk/qcom/gcc-msm8996.c, we should
> > do the same here until rpm can handle this. I'll pack this patch up and
> > merge it to clk-next soon.
> 
> Thanks.  I pulled in the below change into my tree, and fixed up the DT 
> based on the discussion we had.  SD works, and things look sane to me 
> per clk_summary in debugfs.
> 
> Feel free to throw my tested-by on if you want.

Thanks. I did so and merged it up to clk-next.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
