Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB13DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:20:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62612081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c/3dGwzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62612081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TxRGpLP4xxTKvCrkd7FvHgp3eQWoXC8P9u4iiBQMcjM=; b=c/3dGwzTrIA4Jj
	S/Hv3xsBjJI0p9ABv9fnOU52krxyHvsVCtWqsODnPg3zeP/CY//Owm6c0mbpwqmpX7I3jdIggYqSl
	5h3LMcn6fW3WqhLlRV0AoIYOQJB+SiWgK9uZjcXx502RsknaUuYgHvb1Ao1DTsKgZ7XTYyT34blU5
	WyS7jkg5gmBTmc5xvAlOCihvYhKnYm4hjEzdFmfwzdmVARig4QoX+le/nu0qWPtiumYsntehvIgQO
	66M9itRTLWDd0pbV5/7BioK7lALUAYol+BFVKbv4c44G7C7Ric0ukc7LtxHjxczfHgS6iySQf7p+7
	ho3uPcktVLwsZXjNg30g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTIu-0006UJ-ME; Tue, 12 Feb 2019 08:20:32 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTIq-0006SX-4s; Tue, 12 Feb 2019 08:20:29 +0000
X-UUID: 7dc3fd23a88d4b6a98d3bdada6dcf646-20190212
X-UUID: 7dc3fd23a88d4b6a98d3bdada6dcf646-20190212
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <michael.kao@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1909137393; Tue, 12 Feb 2019 00:20:16 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 00:20:14 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 16:20:13 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 16:20:13 +0800
Message-ID: <1549959613.22716.6.camel@mtksdccf07>
Subject: Re: [PATCH 1/7] thermal: mediatek: fix register index error
From: Michael Kao <michael.kao@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Tue, 12 Feb 2019 16:20:13 +0800
In-Reply-To: <6496b13f-57e4-af86-bb59-91a4705d91b0@gmail.com>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
 <1549006693-11659-2-git-send-email-michael.kao@mediatek.com>
 <6496b13f-57e4-af86-bb59-91a4705d91b0@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_002028_198122_54791C73 
X-CRM114-Status: GOOD (  19.39  )
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
Cc: =Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
 =Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 =Eduardo Valentin <edubezval@gmail.com>, =Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, =Zhang Rui <rui.zhang@intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2019-02-04 at 18:24 +0100, Matthias Brugger wrote:
> 
> On 01/02/2019 08:38, michael.kao@mediatek.com wrote:
> > From: Michael Kao <michael.kao@mediatek.com>
> > 
> > The index of msr and adcpnp should match the sensor
> > which belongs to the selected bank in the for loop.
> > 
> 
> If I get that right, this fixes
> b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
> 
> So please add a fixes tag to the commit.

It is true that the patch is fix b7cf0053738c.
I will add 
Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
to the commit message of next version.

> Thanks,
> Matthias
> 
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > ---
> >  drivers/thermal/mtk_thermal.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> > index 0691f26..f646436 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -431,7 +431,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
> >  	u32 raw;
> >  
> >  	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> > -		raw = readl(mt->thermal_base + conf->msr[i]);
> > +		raw = readl(mt->thermal_base +
> > +			    conf->msr[conf->bank_data[bank->id].sensors[i]]);
> >  
> >  		temp = raw_to_mcelsius(mt,
> >  				       conf->bank_data[bank->id].sensors[i],
> > @@ -568,7 +569,8 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
> >  
> >  	for (i = 0; i < conf->bank_data[num].num_sensors; i++)
> >  		writel(conf->sensor_mux_values[conf->bank_data[num].sensors[i]],
> > -		       mt->thermal_base + conf->adcpnp[i]);
> > +		       mt->thermal_base +
> > +		       conf->adcpnp[conf->bank_data[num].sensors[i]]);
> >  
> >  	writel((1 << conf->bank_data[num].num_sensors) - 1,
> >  	       mt->thermal_base + TEMP_MONCTL0);
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
