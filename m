Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77174C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:04:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4484121736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qfebg8j5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4484121736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K63hgA+xzLBQ3O49QnRrOgdK0ZJ/hs4QbIRisudQ+9A=; b=qfebg8j5a+Xc2S
	2I4qZBeQ7rovbbOrbanHOyBkd/6KP1Ii76Hyh77feWTi9ZmfhIf0uOIiusBxp5GdqDFfZXihOCl1a
	Kev9o8X5d/zAOiHE1IJLfhasoCF4psqVTQXhYXFhnNhyf/eN+FyrLlUoKQVP2FHMeIYByoF5+a65C
	YVXMkCIeC8RIKoskQQJc6L0tPlC/r5jZAC2okbjB+VYjCIPn+lxPpM9obqjMNwsI//eMOgUgK3EcR
	FdZEQlAHBqu2dCzaHVfZAHU3hL4CaSBTxcaLszX+3xzWjQrPDFfyUMF2hL6kJEj3pliidotbP/I8R
	q3s29V01jmh3qqFEZ7fA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggShy-0001af-GJ; Mon, 07 Jan 2019 11:04:38 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggShu-0001P7-IN; Mon, 07 Jan 2019 11:04:36 +0000
X-UUID: c0c833fd4dc544acb93135d7f98941c0-20190107
X-UUID: c0c833fd4dc544acb93135d7f98941c0-20190107
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <henryc.chen@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1692015709; Mon, 07 Jan 2019 03:04:24 -0800
Received: from MTKMBS02N2.mediatek.inc (172.21.101.101) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 03:04:23 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 19:04:14 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 19:04:14 +0800
Message-ID: <1546859054.6818.126.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 2/7] dt-bindings: soc: Add opp table on
 scpsys bindings
From: Henry Chen <henryc.chen@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>
Date: Mon, 7 Jan 2019 19:04:14 +0800
In-Reply-To: <CAL_JsqJXFAEdSaexA3p62u8f3RsVA1vfNsOLu4aetB-iLb9qFg@mail.gmail.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-3-git-send-email-henryc.chen@mediatek.com>
 <CAL_JsqJXFAEdSaexA3p62u8f3RsVA1vfNsOLu4aetB-iLb9qFg@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3D2415C0AEB49D232C6ED296E50AE70C96799812009A42BA4E753082113069E82000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_030434_615612_5A4C2CD7 
X-CRM114-Status: GOOD (  18.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>,
 Weiyi Lu <weiyi.lu@mediatek.com>, "open
 list:THERMAL" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-03 at 12:45 -0600, Rob Herring wrote:
> On Wed, Jan 2, 2019 at 8:10 AM Henry Chen <henryc.chen@mediatek.com> wrote:
> >
> > Add opp table on scpsys dt-bindings for Mediatek SoC.
> >
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/opp/mtk-opp.txt  | 24 +++++++++++++
> >  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 42 ++++++++++++++++++++++
> >  2 files changed, 66 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/mtk-opp.txt
> >
> > diff --git a/Documentation/devicetree/bindings/opp/mtk-opp.txt b/Documentation/devicetree/bindings/opp/mtk-opp.txt
> > new file mode 100644
> > index 0000000..036be1c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/mtk-opp.txt
> > @@ -0,0 +1,24 @@
> > +Mediatek OPP bindings to descibe OPP nodes with level values
> > +
> > +OPP tables for devices on Mediatek platforms require an additional
> > +platform specific level value to be specified.
> > +This value is passed on to the mediatek Power Management Unit by the
> > +CPU, which then takes the necessary actions to set a voltage rail
> > +to an appropriate voltage based on the value passed.
> > +
> > +The bindings are based on top of the operating-points-v2 bindings
> > +described in Documentation/devicetree/bindings/opp/opp.txt
> > +Additional properties are described below.
> > +
> > +* OPP Table Node
> > +
> > +Required properties:
> > +- compatible: Allow OPPs to express their compatibility. It should be:
> > +  "operating-points-v2-mtk-level"
> > +
> > +* OPP Node
> > +
> > +Required properties:
> > +- mtk,level: On Mediatek platforms an OPP node can describe a positive value
> > +representing a level that's communicated with a our power management hardware
> > +which then translates it into a certain voltage on a voltage rail.
> 
> Work with the Qcom folks and create a common level property.
> 
> Rob

Ok, I see the reply from Rajendra on
https://lore.kernel.org/patchwork/patch/1027082/
I will follow the new common property, thanks.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
