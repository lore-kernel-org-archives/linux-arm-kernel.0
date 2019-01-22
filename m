Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A50C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:26:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E752B2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EA/tixAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E752B2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=doCbhDumv2mmweyRGnApze7MStLs+iGnlQ5S33+5DIA=; b=EA/tixAiYdp8fa
	eZpjpy6CSGMHE0kXIE58Uy7IiyIjRQ6/y/xjBquENmjEAozBrN3x6qJknLIwbYHuXMxqy1IjJjppS
	nr9o0SoYVBhF0LRw0PRq5/dxf/cLJQ+pkHH2I5i2cz9iBZWeM/HdOon1sMTxWQ9nXbUXo6EUeXHXK
	3hRNoJl0BlVTtoDHfcG7xSFm596+lsxB+7/8v6gsHUSYUzcpN0tFreiG+3lP6fndfNnRq62wfByVW
	XGzb0w3Do1l8M0qgY8Z1xLRGegmjHJdmMlCUGoraV+n1MVwj8BuQAbLWw+p4EwuBLstecCG2OwxAu
	boxyKA0VzCGsar457DtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gltFr-0006Li-UC; Tue, 22 Jan 2019 10:26:03 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gltFo-0006LF-Ki; Tue, 22 Jan 2019 10:26:02 +0000
X-UUID: 86c8e0c5bd7c4da3ae582d774e332d4b-20190122
X-UUID: 86c8e0c5bd7c4da3ae582d774e332d4b-20190122
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <sean.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 439996699; Tue, 22 Jan 2019 02:25:56 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 02:25:55 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 18:25:52 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 18:25:52 +0800
Message-ID: <1548152752.24552.17.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
From: Sean Wang <sean.wang@mediatek.com>
To: Loys Ollivier <lollivier@baylibre.com>
Date: Tue, 22 Jan 2019 18:25:52 +0800
In-Reply-To: <86imyh13kb.fsf@baylibre.com>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190121171019.GA2903@bogus> <86imyhapl9.fsf@baylibre.com>
 <CAGp9LzpgZDEdKFH4ZLqxtO60unxXRJoXNsGugNT=oojHDMp+3g@mail.gmail.com>
 <86imyh13kb.fsf@baylibre.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 219F940BE4EC650BDC4D949AD58ECD2AA3A36865E4A51A9CA58055DBBBB831A92000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_022600_686551_37929748 
X-CRM114-Status: GOOD (  18.51  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Sean Wang <sean.wang@kernel.org>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-22 at 09:47 +0100, Loys Ollivier wrote:
> On Mon 21 Jan 2019 at 18:44, Sean Wang wrote:
> 
> > On Mon, Jan 21, 2019 at 9:29 AM Loys Ollivier <lollivier@baylibre.com> 
> > wrote:
> >>
> >>
> >> On Mon 21 Jan 2019 at 17:10, Rob Herring wrote:
> >>
> >> > On Thu, 17 Jan 2019 17:54:32 +0100, Loys Ollivier wrote:
> >> >> Add binding for Mediatek-based GNSS receivers.
> >> >>
> >> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> >> >> ---
> >> >>
> >> >> v2:
> >> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> >> >> Moved current-speed as an optional propertie.
> >> >> Removed the status line in the example.
> >> >> Added "mediatek,mt3339" compatible.
> >> >>
> >> >>  .../devicetree/bindings/gnss/mediatek.txt          | 39
> >> >>  ++++++++++++++++++++++
> >> >>  1 file changed, 39 insertions(+)
> >> >>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> >> >>
> >> >
> >> > Reviewed-by: Rob Herring <robh@kernel.org>
> >>
> >> Thanks Rob,
> >> If there are no objections by others, I'll stop sending these two patch
> >> (1/4 and 2/4) and reference any new patch serie for 3 and 4 as depending
> >> on those two.
> >>
> >
> > Hi Loys,
> >
> > Thanks for adding the first GPS device driver. It's really nice to see
> > more device drivers added to upstream support.
> >
> Hi Sean,
> 
> Glad to know you're supporting this initiative.
> 
> > Do you mind send the series again with Cc linux-mediatek@lists.infradead.org 
> > ?
> >
> The series already has linux-mediatek@lists.infradead.org in Cc. Does it
> need a resend ?
> 

It doesn't need a resend, it's my mistake. thanks for clarifying soon.

> > Sean
> >
> >> --
> >> -L
> >>
> >> _______________________________________________
> >> Linux-mediatek mailing list
> >> Linux-mediatek@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
