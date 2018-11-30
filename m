Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B727C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:47:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AAE2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U24AFmH3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq+I7LeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AAE2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EdQbhEJMJTQAAWDuJkSLq5EFItXdMw5YMo5s7qn5cfw=; b=U24AFmH3WBs2h1
	GG5Za+jzttoM6KrFbg8sZLhGEZSPydSj+p39H4H7uxjVSBbLKm6kpGLK3bxWr4jcvdV3Vjro2qnhV
	3V3sFKRmU1sUG7wHC7ccJVmmZziy2Y4nvXZMZBf9t/3ipnh1Jno8SaM3xpjMDb8df2gGlAa0zyirv
	CrvQjZP73grOLGhmYM4cl77y/1BurebZxCstoREPqTjFosrA0NAVYKfD9DtnvAFk8pQeJnE8k9rSz
	QgJhsHkB6FfnKengw6JmQup7XbNkrc9nMVwMlE48hc2l49zPObYIC1uU1Kmb9QqDDZ7a4RN7G+Qhu
	I7VLlq9zb56ZGqDQOwsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gScaQ-0003ze-70; Fri, 30 Nov 2018 06:47:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gScaM-0003yY-IH; Fri, 30 Nov 2018 06:47:35 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 166FD20863;
 Fri, 30 Nov 2018 06:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543560444;
 bh=k00Kyz0bOoUiNJk5/ViRHfM2wN0VmnuKK832rMILqMk=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=Oq+I7LePdXVAdv/PxJ/p0BMaUoc7v4CpCmONDMI629/bJ/rW7zRvbvj1EdCzXr8RI
 9NvNgzZGuteGDXoSHGQnJBUY5Yh3eIpLRwHS8yWejINlJHz+2rWrfryoE0jmvvt0Tr
 IektJnUA8UJapvWM619CXEOX3lO1NE7RZylADdwY=
MIME-Version: 1.0
To: matthias.bgg@gmail.com, matthias.bgg@kernel.org, mturquette@baylibre.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181116180901.17737-1-matthias.bgg@kernel.org>
References: <20181116180901.17737-1-matthias.bgg@kernel.org>
Message-ID: <154356044342.88331.13729809794593193239@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 0/3] Mark clocks as critical for MT6797
Date: Thu, 29 Nov 2018 22:47:23 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_224734_623263_27DC4A0C 
X-CRM114-Status: GOOD (  12.46  )
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

Quoting matthias.bgg@kernel.org (2018-11-16 10:08:58)
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Jasper send this series some month ago. As there was no reaction from
> his side, I'll do a friendly take-over.
> I tested the patches on my Helios X20 boards and they fix the issue.
> I didn't add a Tested-by tag as I added my Signed-off-by.
> 
> Changes since v1:
> - add a fixes tag.
> 
> ---
> 
> Currently, DRAM-related clocks and the axi_sel MUX are not marked with
> CLK_IS_CRITICAL for MT6797. This causes memory corruption when the
> system is booted without clk_ignore_unused.
> 
> This patchset
> 
> 1. Makes it possible to mark outputs of MUXes as critical by introducing
>    a new macro, MUX_FLAGS,
> 2. Makes it possible to mark gates as critical by adding flags to
>    mtk_gate, and
> 3. Marks axi_sel, ddrphycfg_sel, infra_dramc_f26m and infra_dramc_b_f26m
>    as critical.
> 
> The addition of flags to mtk_gate also exists in the patch series "Add
> basic and clock support for Mediatek MT8183 SoC" [1].  The type of
> flags is unsigned int in that series, but the real type is unsigned
> long, so my patch differs from that patch.

Will anyone from Mediatek review this? Why aren't the people who signed
off on drivers/clk/mediatek/clk-mt6797.c included on this patch series?
They no longer work there?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
