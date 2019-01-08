Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7C1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:05:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6AD2070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rsHsvnCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6AD2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C5Y40/XjbSsj0q03y7hDa2tVdpRsPXXIX2PXXwe+VOE=; b=rsHsvnCBKOQP2t
	exs2xK9JIO+p9VZq6t1o39gWGwefg6+r7zhSQs3owIqgaVzZYEJWp1fohsnHPUkJaeZrQv/Jy6Eqj
	uAYSzovDQZsbvg9OeJNQzsVvQfRoAiaV2dTh8MkCGQwN0py1GWZdXbZ+i0dDmuawPEhmS8IcU5ZgO
	JPDOq0qclCX9gyTLqIuxi6yMWVvhRORaTuukrhVJL/PjD/rxKpr+2S2HW3BXhYvecHibXBxoJAc8f
	XOJzPhXGn/zcT85fBYV/EWANfD3YlfqBTLs3O/VvZKpPdW16YUgjkpAViGCYhJhm6wkrpkQhTbKoB
	kgIQ09zLeuwHW4Nd7/pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gghhw-00051Y-IP; Tue, 08 Jan 2019 03:05:36 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gghhr-00050P-8T; Tue, 08 Jan 2019 03:05:33 +0000
X-UUID: c478d28b9e914dbc98353012ad056c88-20190107
X-UUID: c478d28b9e914dbc98353012ad056c88-20190107
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <mars.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 931364329; Mon, 07 Jan 2019 19:05:07 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 19:05:06 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 11:05:04 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 8 Jan 2019 11:05:04 +0800
Message-ID: <1546916704.4994.3.camel@mtkswgap22>
Subject: Re: [PATCH v2 0/3] Mark clocks as critical for MT6797
From: Mars Cheng <mars.cheng@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 8 Jan 2019 11:05:04 +0800
In-Reply-To: <154689458947.15366.14390825810412394676@swboyd.mtv.corp.google.com>
References: <20181116180901.17737-1-matthias.bgg@kernel.org>
 <154356044342.88331.13729809794593193239@swboyd.mtv.corp.google.com>
 <8e8b9c0f-7647-daa4-504b-7b86bcd45a04@gmail.com>
 <154689458947.15366.14390825810412394676@swboyd.mtv.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EEC90C1E2BC24CAD9F1D04DCAE853DD2CC27D9F55A8D1640A3E6C066578E56382000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_190531_324943_43DF5C54 
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
Cc: Matthias Brugger <mbrugger@suse.com>, mturquette@baylibre.com,
 sean.wang@kernel.org, linux-kernel@vger.kernel.org,
 Kevin-CW Chen <kevin-cw.chen@mediatek.com>, linux-mediatek@lists.infradead.org,
 matthias.bgg@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 jasu@njomotys.info, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen/Matthias

On Mon, 2019-01-07 at 12:56 -0800, Stephen Boyd wrote:
> Quoting Matthias Brugger (2018-11-30 01:04:02)
> > 
> > 
> > On 30/11/2018 07:47, Stephen Boyd wrote:
> > > Quoting matthias.bgg@kernel.org (2018-11-16 10:08:58)
> > >> From: Matthias Brugger <mbrugger@suse.com>
> > >>
> > >> Jasper send this series some month ago. As there was no reaction from
> > >> his side, I'll do a friendly take-over.
> > >> I tested the patches on my Helios X20 boards and they fix the issue.
> > >> I didn't add a Tested-by tag as I added my Signed-off-by.
> > >>
> > >> Changes since v1:
> > >> - add a fixes tag.
> > >>
> > >> ---
> > >>
> > >> Currently, DRAM-related clocks and the axi_sel MUX are not marked with
> > >> CLK_IS_CRITICAL for MT6797. This causes memory corruption when the
> > >> system is booted without clk_ignore_unused.
> > >>
> > >> This patchset
> > >>
> > >> 1. Makes it possible to mark outputs of MUXes as critical by introducing
> > >>    a new macro, MUX_FLAGS,
> > >> 2. Makes it possible to mark gates as critical by adding flags to
> > >>    mtk_gate, and
> > >> 3. Marks axi_sel, ddrphycfg_sel, infra_dramc_f26m and infra_dramc_b_f26m
> > >>    as critical.
> > >>
> > >> The addition of flags to mtk_gate also exists in the patch series "Add
> > >> basic and clock support for Mediatek MT8183 SoC" [1].  The type of
> > >> flags is unsigned int in that series, but the real type is unsigned
> > >> long, so my patch differs from that patch.
> > > 
> > > Will anyone from Mediatek review this? Why aren't the people who signed
> > > off on drivers/clk/mediatek/clk-mt6797.c included on this patch series?
> > > They no longer work there?
> > > 
> > 
> > My fault, I'll resend 3/3 with the comments you made. Added Kevin-CW now...
> 
> I never saw anything on the list. Did I miss anything? I have the first
> two patches in my local queue still but I never merged it to clk-next
> because nobody replied or resent anything. Please resend the whole
> series because I've lost track of what's going on now. Sorry.
> 
> 

sorry for late response. Kelvin-CW and I are responsible for 6797
clk.You have my Ack:
Acked-by: Mars Cheng <mars.cheng@mediatek.com>

Thanks.
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
