Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8524C10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:46:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96A321852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N+YVaAxy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/PdYZw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96A321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	Message-ID:References:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yBNntDCU1vEtqtmGtZE6nSD21XOVoV9eW7JlIibechg=; b=N+YVaAxy/1haMU
	esfGe9BcPq/RwnKi/bEcZFYgBtyne07o+XW0P4gNvrMiDDhWdLVMUwacOMw+TwU++p4GZjahEcEo8
	69ol9/F9srTY8yPMKH+oaCnbfooYiRyKQzrglU6j72qP4HvNYIvf5czH9+k6b88Hnh5/cf/CFdydz
	KL4kqH0flsf2mx5STrHNdRjhhTEqYqZCt4rRJ/cUzSA7oVz8rkHxmLIUfx18h5w9lgnw+LsMiCj5R
	VBz2n9huGtiV3Vj53/BP017dv+ACrxw9sA12jnb2uiXo/nYa17j2g8HVG8eyPrGGA95OSbMpqyFIc
	1q8tHpuZAcC66CgnmqGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygnn-00014k-3H; Tue, 26 Feb 2019 17:45:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygnk-00014O-I3; Tue, 26 Feb 2019 17:45:57 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 716162184D;
 Tue, 26 Feb 2019 17:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551203155;
 bh=c2z4jtwehHe3TphH0an2gBgC1jwH9c+EUAZ8n2yejXg=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=M/PdYZw1E4fFGr2llB9KDjWf/mWEVOkmQ1+z3iUitWRDwd4atQx1zu2MEpnP3KXMd
 niwA/w1GoB1Q5/aG0YE88d+zZTYlOfwjr15BMoXXc4j765TfNzGijU/qHWL2QxT+pc
 NR68QCuB01MobEzpPkcRlLNrG97dFCTtwEnUhJII=
MIME-Version: 1.0
To: Weiyi Lu <weiyi.lu@mediatek.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
 <20190201083016.25856-2-weiyi.lu@mediatek.com>
 <155069033021.77512.14493210110678229730@swboyd.mtv.corp.google.com>
 <b7abe484-71c1-5ec0-796c-544f1ac5d6f5@gmail.com>
 <155082168901.77512.12893153125579041936@swboyd.mtv.corp.google.com>
 <1551153650.1047.4.camel@mtksdaap41>
Message-ID: <155120315465.260864.9490825097795511702@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v4 00/12] Mediatek MT8183 clock and scpsys support
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1551153650.1047.4.camel@mtksdaap41>
Date: Tue, 26 Feb 2019 09:45:54 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_094556_615817_395CA3CB 
X-CRM114-Status: GOOD (  16.91  )
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
Cc: Rob Herring <robh@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, James Liao <jamesjj.liao@mediatek.com>,
 Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Weiyi Lu (2019-02-25 20:00:50)
> On Thu, 2019-02-21 at 23:48 -0800, Stephen Boyd wrote:
> > Quoting Matthias Brugger (2019-02-21 00:36:24)
> > > 
> > > 
> > > On 20/02/2019 20:18, Stephen Boyd wrote:
> > > > 
> > > > What's the merge plan here? Do you want me to apply these patches to clk
> > > > tree? Will someone be sending me a pull request for mediatek clk changes
> > > > this cycle? It's getting pretty late for much of anything making this
> > > > upcoming merge window.
> > > > 
> > > 
> > > As far as I can see, the clock patches are independent, so I think it is OK to
> > > take them. SCPSYS patches will go through my tree once they are in shape.
> > 
> > Ok great. When patches for clks are interspersed throughout the patch
> > series it makes me think that something later in the series depends on
> > something that isn't a clk patch so then I can't apply it.
> > 
> 
> Hi Stephen,
> 
> Sorry for making such complex dependencies between the clk patches and
> others in this series. And just like Matthias mentioned, the clock
> patches are independent from others. I could resend a clock-only series
> right away if each clock patch in v4 is qualified to merge into
> clk-next.
> If there still some provide need to be fixed, please let me know. I'll
> fix them and send v5 only for clock.

It looks like Matthias has some comments on the first patch that need to
be addressed. I looked over the rest of the clk patches and they look ok
at a quick glance. If you resend just the clk patches without the rest
then I can probably apply them for the upcoming merge window.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
