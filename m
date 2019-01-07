Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A81C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:56:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC692173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h0y9GT6Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="edwqp2HW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC692173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xVEQJYbnZtGmLE7PRun0kWUn54URauAFYdw/IwVV/ng=; b=h0y9GT6Y6IFq8o
	R4gyUnPfReI7Gze0f+goLcVClIg4VwiZwacHqHxhl/NKR9fWpfEiQUBwW5zB/KaOo6oeemTVIxYRx
	TJi7bwjUdRSQr9uNdlabPSgzPAQnqyS1/XIplSiPtEGNoN31dEEIqQmS5ol1wLMoPB4glXYWV0BwF
	Vzl4l0ZnL8kfdK3yEDSWlSpdLc6VRxhpRhD489Fd5gYrjm70uCAuRq6ssybt/xdgI28pojyyLZK59
	3FzcJyCeoy40tST2vs0J2ynXTG1nlGtKYCUfPb431NF3bo+MpD33GS21ZwjNLos5B+VfwSueDPhfv
	Cw+kgHcDrn+6/yAWrCVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggbwp-00043a-Kz; Mon, 07 Jan 2019 20:56:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggbwl-00042s-Ug; Mon, 07 Jan 2019 20:56:33 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 65D9E2087F;
 Mon,  7 Jan 2019 20:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546894590;
 bh=dvhf/8ktZNja+Dd7pfhSXqGIJZ2othMcMh326Q6CcQs=;
 h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
 b=edwqp2HWsU/W1IZmP0hXEnSBBCxjscDaBdvevUomDokC2AXFYKiOUAJyK9iNelLJU
 jG3pqeifpvF4BOpY+nu4QGCCpfnmsZOWzS/e7bfbjr7XcnMjtiEREjQdNGIVjr0wbX
 FKM+I6sOLYxWvG61llhMvf9l9U5kotgb9oHIxdmQ=
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] Mark clocks as critical for MT6797
To: Kevin-CW Chen <kevin-cw.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, matthias.bgg@kernel.org,
 mturquette@baylibre.com
In-Reply-To: <8e8b9c0f-7647-daa4-504b-7b86bcd45a04@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181116180901.17737-1-matthias.bgg@kernel.org>
 <154356044342.88331.13729809794593193239@swboyd.mtv.corp.google.com>
 <8e8b9c0f-7647-daa4-504b-7b86bcd45a04@gmail.com>
Message-ID: <154689458947.15366.14390825810412394676@swboyd.mtv.corp.google.com>
Date: Mon, 07 Jan 2019 12:56:29 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_125632_007208_06C2F6F4 
X-CRM114-Status: GOOD (  16.05  )
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
Cc: Matthias Brugger <mbrugger@suse.com>, sean.wang@kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 jasu@njomotys.info, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matthias Brugger (2018-11-30 01:04:02)
> 
> 
> On 30/11/2018 07:47, Stephen Boyd wrote:
> > Quoting matthias.bgg@kernel.org (2018-11-16 10:08:58)
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> Jasper send this series some month ago. As there was no reaction from
> >> his side, I'll do a friendly take-over.
> >> I tested the patches on my Helios X20 boards and they fix the issue.
> >> I didn't add a Tested-by tag as I added my Signed-off-by.
> >>
> >> Changes since v1:
> >> - add a fixes tag.
> >>
> >> ---
> >>
> >> Currently, DRAM-related clocks and the axi_sel MUX are not marked with
> >> CLK_IS_CRITICAL for MT6797. This causes memory corruption when the
> >> system is booted without clk_ignore_unused.
> >>
> >> This patchset
> >>
> >> 1. Makes it possible to mark outputs of MUXes as critical by introducing
> >>    a new macro, MUX_FLAGS,
> >> 2. Makes it possible to mark gates as critical by adding flags to
> >>    mtk_gate, and
> >> 3. Marks axi_sel, ddrphycfg_sel, infra_dramc_f26m and infra_dramc_b_f26m
> >>    as critical.
> >>
> >> The addition of flags to mtk_gate also exists in the patch series "Add
> >> basic and clock support for Mediatek MT8183 SoC" [1].  The type of
> >> flags is unsigned int in that series, but the real type is unsigned
> >> long, so my patch differs from that patch.
> > 
> > Will anyone from Mediatek review this? Why aren't the people who signed
> > off on drivers/clk/mediatek/clk-mt6797.c included on this patch series?
> > They no longer work there?
> > 
> 
> My fault, I'll resend 3/3 with the comments you made. Added Kevin-CW now...

I never saw anything on the list. Did I miss anything? I have the first
two patches in my local queue still but I never merged it to clk-next
because nobody replied or resent anything. Please resend the whole
series because I've lost track of what's going on now. Sorry.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
