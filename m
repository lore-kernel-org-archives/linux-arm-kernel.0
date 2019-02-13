Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10E6C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:48:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760E12086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YVFOsZll";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZtVXEWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760E12086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s7egsVPZkDoN9HLM+WrjUAu0URCviwERL5zQLQS5hgs=; b=YVFOsZllFcMWXp
	pV/PG0F1fyN9EvO5wbWx1IpeFtUaEgKvOJSklJhGGHe+6BwUgM8qlITZ1rIpkxR84M4DgWefv06Fd
	szdqksLOmNsvr6C3NmUox38/s5ttIScE2B30M+2ZenntwAlLXSIUuf2kklQXV87Ka40iDhQgRESTV
	aLrhmpAIsDJ+IlqNl/SWyTzIo94JLtN/qi3bLqd6Phq17msuTArs0C2r6OocY5908XMwvwjpNUma/
	Tjt6EVvvfDJ3BZJ8qsax5BEfEa1cInJxZJzjg0b1NPIb8IuPnWudze4EpDHagg3nbCBSL7mfzvdTJ
	Ay+KFkbqSCKgTkla4wwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtye2-0000WR-60; Wed, 13 Feb 2019 17:48:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtydp-0000SU-Ch
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:48:23 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F0DD82086C;
 Wed, 13 Feb 2019 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550080093;
 bh=LoGu4ZFpYnInUrsS0hVTMhsGX33lNGrwKZApfVSsGoQ=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=OZtVXEWthhNHNzk3YJ4HfieZLR7ZZmoreYaYOlnQx/uUCofvgJPajcFKISoAMcv7S
 w5BWbL8clOEhf8ZmfCbNMAVgF989LF70mDAnjpLCw9cae+Oa1lxOJOhM0BDa734+Rx
 rzjBTv5rI7vP2V1Wf3geijEcxn5TgA2jx8D/Ol1M=
MIME-Version: 1.0
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
In-Reply-To: <20190212135154.2733-4-gabriel.fernandez@st.com>
User-Agent: alot/0.8
Subject: Re: [PATCH 3/7] clk: stm32mp1: set ck_csi as critical clock
Message-ID: <155008009213.115909.12905657780692674136@swboyd.mtv.corp.google.com>
References: <20190212135154.2733-1-gabriel.fernandez@st.com>
 <20190212135154.2733-4-gabriel.fernandez@st.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 13 Feb 2019 09:48:12 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_094813_581806_35E29307 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: Gabriel Fernandez <gabriel.fernandez@st.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting gabriel.fernandez@st.com (2019-02-12 05:51:50)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> ck_csi is used for IO compensation so it should be
> considered as "always-on" and kept on.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  drivers/clk/clk-stm32mp1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
> index e72079de83f4..5b30e4eeca2c 100644
> --- a/drivers/clk/clk-stm32mp1.c
> +++ b/drivers/clk/clk-stm32mp1.c
> @@ -1661,7 +1661,8 @@ static const struct clock_config stm32mp1_clock_cfg[] = {
>  
>         /*  External / Internal Oscillators */
>         GATE_MP1(CK_HSE, "ck_hse", "clk-hse", 0, RCC_OCENSETR, 8, 0),
> -       GATE_MP1(CK_CSI, "ck_csi", "clk-csi", 0, RCC_OCENSETR, 4, 0),
> +       GATE_MP1(CK_CSI, "ck_csi", "clk-csi", CLK_IS_CRITICAL,

Please add a comment to the code indicating this so we know why critical
is here without reading git history.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
