Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:01:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC53217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 04:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KOuDaN79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC53217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HT5DaVwplsM5VMO1Yx1YUpPyQvW1IoTbCIxy4p/M7w8=; b=KOuDaN79H403e0
	37q9wVZ1haPFrVkDhR5/A+ELDxxF7hsAZQkT0jMhfitg0JYMotyZJiE3ZdKZ7n0no1EoGMDAF8fGc
	8AEIj9q14WYYnkd7np21q9OMDi61fGLsnl474itsOC+0P+ZhpTlvyLnshtsqguEX3qQ0XZOyXf9Vx
	HN0v9xppNVesPG1skTvWdBI694QdXR9lGfqtLoddOnngK1skA9/HzrF/lnNUa6v9goGG+uSKk1hah
	Qte+V6+1kcrQqC1FBKT+JrKdp6UOBjh7Jrwf8p0baeUh9RbYDPLOhfSLZ0M+pwtc0eONJN4HzZ9vY
	Zj27X7uhN3vtE08Uk90w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyTvm-0007pQ-UT; Tue, 26 Feb 2019 04:01:22 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyTvj-0007oc-EH; Tue, 26 Feb 2019 04:01:21 +0000
X-UUID: 105e51b9f4b64f90961539867408fec3-20190225
X-UUID: 105e51b9f4b64f90961539867408fec3-20190225
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <weiyi.lu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 878107950; Mon, 25 Feb 2019 20:01:00 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 25 Feb 2019 20:00:58 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Feb 2019 12:00:50 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Feb 2019 12:00:50 +0800
Message-ID: <1551153650.1047.4.camel@mtksdaap41>
Subject: Re: [PATCH v4 00/12] Mediatek MT8183 clock and scpsys support
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 26 Feb 2019 12:00:50 +0800
In-Reply-To: <155082168901.77512.12893153125579041936@swboyd.mtv.corp.google.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
 <20190201083016.25856-2-weiyi.lu@mediatek.com>
 <155069033021.77512.14493210110678229730@swboyd.mtv.corp.google.com>
 <b7abe484-71c1-5ec0-796c-544f1ac5d6f5@gmail.com>
 <155082168901.77512.12893153125579041936@swboyd.mtv.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2566077B6750DF2BE7912EE4D2CBC442DA67555DC3CF1235DF24BEF0A4BC65E02000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_200119_489766_2E7F5B77 
X-CRM114-Status: GOOD (  20.34  )
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

On Thu, 2019-02-21 at 23:48 -0800, Stephen Boyd wrote:
> Quoting Matthias Brugger (2019-02-21 00:36:24)
> > 
> > 
> > On 20/02/2019 20:18, Stephen Boyd wrote:
> > > 
> > > What's the merge plan here? Do you want me to apply these patches to clk
> > > tree? Will someone be sending me a pull request for mediatek clk changes
> > > this cycle? It's getting pretty late for much of anything making this
> > > upcoming merge window.
> > > 
> > 
> > As far as I can see, the clock patches are independent, so I think it is OK to
> > take them. SCPSYS patches will go through my tree once they are in shape.
> 
> Ok great. When patches for clks are interspersed throughout the patch
> series it makes me think that something later in the series depends on
> something that isn't a clk patch so then I can't apply it.
> 

Hi Stephen,

Sorry for making such complex dependencies between the clk patches and
others in this series. And just like Matthias mentioned, the clock
patches are independent from others. I could resend a clock-only series
right away if each clock patch in v4 is qualified to merge into
clk-next.
If there still some provide need to be fixed, please let me know. I'll
fix them and send v5 only for clock.

> > 
> > Do you prefer to get pull requests for clock patches? I wasn't aware of that.
> > But if you prefer that, we can find someone who prepares every merge window a
> > pull request.
> > 
> 
> I don't really care one way or the other about pull requests vs.
> manually applying patches. It helps if someone wants to pick the patches
> up and send them along when there are complex dependencies between the
> clk patches and dts bits or something like that. It also helps if
> there's someone else with knowledge of the particular SoC saying "these
> are good, please pull these patches". Subsystem maintainers obviously
> aren't experts in all SoCs and their various quirks, plus datasheets
> aren't always so widely available, so sharing the load with SoC
> maintainers who are familiar with the hardware usually makes a lot of
> sense.
> 
> Otherwise, if you just want to put your "Reviewed-by" tag on any patches
> that look good and are sane then I'll quickly understand that these
> patches are good and that I should pick them up into the clk tree from
> the list. Just please communicate one way or the other about patches
> that you care about because it helps to know if they've gotten attention
> or not.
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
