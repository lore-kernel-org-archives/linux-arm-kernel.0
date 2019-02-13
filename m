Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E73C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:48:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3A8222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tpqP8qHl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2JL+8D5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3A8222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lp9/3KAs/cu/u5c2/Air11nyKJdvJPug+psGLmu4j3M=; b=tpqP8qHl8nnudo
	niE3p6bfsxqRPpHAXQEj6YNBRhC+skYzxAlrsMoKxZhKb3iFKeUbSbvV6ZtI1lCeFY27ZYr2tdekm
	m8R+7cNF9d/gCC136Wn0HuowxMz4NyBMs+b6vUK6xxg1skZ0ZnYmg2D8xgbG7k80zZu8LlNxizwux
	mU3Sx7DuQqZg/ChA5+dxGrcqLJQcIyPiVoQZ7YrH5FNqmEWcFLu+YvZO+B71kc1g/w+G8L8bTPLVz
	jnMr4g+1FhZuU/Tf/kvIDwoqKOaFhZwH7lgVAj5WRndjb94Bj0pQUFbGTfYt/gN8caHgWpPx2VKiY
	BVCnm1mdc+nX2P3Xwt/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtyeD-0000jU-Oc; Wed, 13 Feb 2019 17:48:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtye4-0000Ys-DE
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:48:31 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F3DF72190A;
 Wed, 13 Feb 2019 17:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550080108;
 bh=SS0vbOTs/1srZxpl61yK6HRHGQuJgvxT9uBD1u1g7g8=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=2JL+8D5YIFLBvLVlrvXP6ViyyH7kpowtchdZKoC7pTaEX5l8ECKxZUuFOpphbZaJr
 sa5V8yUdvisv4KUrnfIE0ZrFxyZMqIyfF2vW/OUWPLlWwms4Q5454+NBtcWmXSwejt
 b31B1YZE/2o3che2nLgcPVsdZhsUAJxJQ4W09pEI=
MIME-Version: 1.0
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
In-Reply-To: <20190212135154.2733-5-gabriel.fernandez@st.com>
User-Agent: alot/0.8
Subject: Re: [PATCH 4/7] clk: stm32mp1: fix mcu divider table
Message-ID: <155008010726.115909.10603966457383347348@swboyd.mtv.corp.google.com>
References: <20190212135154.2733-1-gabriel.fernandez@st.com>
 <20190212135154.2733-5-gabriel.fernandez@st.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 13 Feb 2019 09:48:27 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_094828_821710_719C420E 
X-CRM114-Status: UNSURE (   4.82  )
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
Cc: Gabriel Fernandez <gabriel.fernandez@st.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting gabriel.fernandez@st.com (2019-02-12 05:51:51)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> index 8: ck_mcuss divided by 256 (not 512)
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>

Any Fixes tag?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
