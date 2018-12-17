Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0460C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:41:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8102086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lAa9yyK/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM6FSfh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8102086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2dGjjdzlKG/onmG1wRq0P6R9dmxzTMpvZO5+KR2RC40=; b=lAa9yyK/1vZuw0
	j6YDXkFv3i0npAKohWxBUCJNzjXNy08uWxoZSKSu/vT40W7J6WbxcPzThV1UorggbbYLeFlOKguz4
	UgNu54h8WbxhnUDwVD4CVpoAKPi+oEK2B0Dd+mgJa8kXvZu2thM4OhY7byWXgqoOty4uvMjS8KT/+
	Ypmp5YZzmjth85+NAJzifPCFXQA+qtYET+odi+YWzyXq0pk3PzMHPQ24fx5y0K2yzfFMvTLnKoQxk
	G+T4vWCWpWMS9rEem1Q77oCubqpR6G8ASgSb2DhXkj33doAqk+OZmB7nd+UG6uv2SoWPtNFrvEXvx
	aedsPsHQV70SJjOlVhaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYxpD-0000zB-5Q; Mon, 17 Dec 2018 18:41:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYxp9-0000yJ-VB
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 18:41:05 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A71D2086C;
 Mon, 17 Dec 2018 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545072053;
 bh=/6TLKhoYmyr9xh25j31W+MHdowTtKqPQoal8ILNWY1I=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=CM6FSfh7U7P163eFsuMZMSLoNUcfcUc3+fCBAGWT7+zodqXvOGNwjOlwC531XnHqt
 ZEu3nlfB73CakgZq/2KAKOzz7xVt17p15Edf+4Ia1ijS2lOiQza824fkWIJbzmHASa
 /FQhJ+JFjrPQfQjQfui0P7obKfYjJ//KuA7v7Blg=
MIME-Version: 1.0
In-Reply-To: <20181217113539.nfwp4knbx3luxoqn@fsr-ub1664-175>
Subject: Re: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const
 pointers
To: Abel Vesa <abel.vesa@nxp.com>
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
 <154482171780.19322.123667425822315496@swboyd.mtv.corp.google.com>
 <20181217113539.nfwp4knbx3luxoqn@fsr-ub1664-175>
Message-ID: <154507205230.19322.658078387500141910@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Mon, 17 Dec 2018 10:40:52 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_104104_025073_F772D999 
X-CRM114-Status: GOOD (  15.85  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2018-12-17 03:35:40)
> On 18-12-14 13:08:37, Stephen Boyd wrote:
> > Quoting Abel Vesa (2018-12-14 07:30:08)
> > > This is mainly to shut up the checkpatch.pl script warnings about the
> > > "static const char *" needing to be "static const char * const".
> > > 
> > > Abel Vesa (3):
> > >   clk: imx: Make parent_names const pointer in composite-8m
> > >   clk: imx: Make parents const pointer in mux wrappers
> > >   clk: imx8mq: Make parent names arrays const pointers
> > > 
> > 
> > I still see warnings though so there seems to be some more work to do.
> > 
> > drivers/clk/imx/clk-imx8mq.c:401:89: warning: passing argument 5 of 'imx_clk_mux2' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> >   clks[IMX8MQ_CLK_GPU_SHADER_SRC] = imx_clk_mux2("gpu_shader_src", base + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sels));
> > 
> Hmm, I guess you applied this on top of clk-imx8mq, right ?
> This change is against linux-next. The actual problem is the imx_clk_mux2
> which looks like this on branch clk-imx8mq:

Yes. It would be great if you could indicate where patches are
generated. In fact, I see that 'git format-patch' now has an option to
do just this!

	git format-patch --base=commit

> 
> static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,  
>                 u8 shift, u8 width, const char **parents, int num_parents)   
> 
> but it looks like this on linux-next (which is exactly the same on clk-next):
> 
> static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,  
>                         u8 shift, u8 width, const char * const *parents,     
>                         int num_parents)                                     

Hrmm ok. I'll have to rejigger things and I probably won't be getting to
it until early next year.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
