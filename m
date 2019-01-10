Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4391AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:50:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1322620879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="guDXwI2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1322620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=46iQEaEhvPfA6IzsxgsknPM5RAR97ZXYZida6TnIqSY=; b=guDXwI2Niktvxa
	iHpcgJSx7epswjXPDIAbu2NGRvonFiq/VrXctdbpIoJRIcKWIBoZs5oifGlopzMkZsRwX2UHVzw6S
	4tzKHebU5hgWGbp4i85DZOzPmCJrvpyGGswXbFhg3qveEuoXSGOQcxMxYF+VJeR8GtFMUsG9ZPkU0
	ENIa4WTVzQcaXuRH2QAfDvDBG0IscKbwr3Rk6Km+w2RfilFY/rmR3rHQiOrfGXBgb3rYG9z0JjVv8
	u6CZRRmpEsrrJFcUTKsWcOyaPKuvUAv/Ar3vvPVVVVqY2pfe0oMjW1SZLVktDKufOAmSxQP2W8Tda
	4yb2nb5weafxihW8bOtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghW2t-0005vs-4a; Thu, 10 Jan 2019 08:50:35 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghW2p-0005vK-Ru; Thu, 10 Jan 2019 08:50:33 +0000
X-UUID: bda1fd1629bf4020b590c8eacdd9c33a-20190110
X-UUID: bda1fd1629bf4020b590c8eacdd9c33a-20190110
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <long.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1920418038; Thu, 10 Jan 2019 00:50:30 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 00:50:28 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs03n2.mediatek.inc
 (172.21.101.182) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 10 Jan 2019 16:50:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 16:50:25 +0800
Message-ID: <1547110225.3831.24.camel@mhfsdcap03>
Subject: Re: [PATCH v9 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
From: Long Cheng <long.cheng@mediatek.com>
To: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 10 Jan 2019 16:50:25 +0800
In-Reply-To: <d60c25c2-efe4-9294-dc7e-98f0333bff76@infradead.org>
References: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
 <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
 <CANMq1KB=yuEJxUdi8M9deDhAv24WZ-4h+26cFq7AzBi8uyd88Q@mail.gmail.com>
 <d60c25c2-efe4-9294-dc7e-98f0333bff76@infradead.org>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C0E1301CD85C79D6C4D6D9D004E32AB58BE59366EFE59482B05044DE530829012000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_005031_910497_8B3D862A 
X-CRM114-Status: GOOD (  15.38  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>,
 Zhenbao Liu <zhenbao.liu@mediatek.com>, linux-serial@vger.kernel.org,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Wang <sean.wang@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, YT Shen <yt.shen@mediatek.com>,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Ryder
 Lee <ryder.lee@mediatek.com>, linux-mediatek@lists.infradead.org,
 Sean Wang <sean.wang@mediatek.com>, Jiri Slaby <jslaby@suse.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm Mailing
 List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-02 at 18:03 -0800, Randy Dunlap wrote:
> Hi,
> 
> While you are making changes, here are a few more:
> 

hi

OK, thanks for your comments.

> 
> On 1/2/19 5:39 PM, Nicolas Boichat wrote:
> > diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
> > index 27bac0b..1a523c87 100644
> > --- a/drivers/dma/mediatek/Kconfig
> > +++ b/drivers/dma/mediatek/Kconfig
> > @@ -1,4 +1,15 @@
> > 
> > +config DMA_MTK_UART
> > +       tristate "MediaTek SoCs APDMA support for UART"
> > +       depends on OF && SERIAL_8250_MT6577
> > +       select DMA_ENGINE
> > +       select DMA_VIRTUAL_CHANNELS
> > +       help
> > +         Support for the UART DMA engine found on MediaTek MTK SoCs.
> > +         when SERIAL_8250_MT6577 is enabled, and if you want to use DMA,
> 
> 	    When
> 
> > +         you can enable the config. the DMA engine can only be used
> 
> 	                               The
> 
> > +         with MediaTek SoCs.
> > +
> 

above, i will modify.

> Also, use tabs to indent instead of spaces.
> The lines (tristate, depends, select, and help) should be indented with one tab.
> The help text lines should be indented with one tab + 2 spaces.
> 

in my patch, i already do this. So don't need modify.

> >  config MTK_HSDMA
> >         tristate "MediaTek High-Speed DMA controller support"
> >         depends on ARCH_MEDIATEK || COMPILE_TEST
> 
> 
> thanks,



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
