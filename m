Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAADC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:49:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF1820861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CV8OsjNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF1820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eILoiuFoyfR4ZiCp2MU8hLgMfn38BbZcat9HIeBvGcQ=; b=CV8OsjNZ6LhoZf
	qGz684IhHYxbzUdfryLLp5fqAlUHxeeVM5WLoTzXi0xvzqxrEGj1G4hXR1NWHnTJO5ykVVprsAvfN
	Ugw1wfZ+5oi16/ZxUuCidzdV+ZdUn9RLb8kdiFLxuiIzozja/fnr5FaAOUcQQyX+l6oQG29Rryhks
	CieTaujP/6qqiJN0sbdASmOeTjk5L6uX/dtbiLtGOviHXTgZtFiosuOr9f7sp3uO53dQyl4EpnZvz
	uaiDd9gTkQbFfs7r6d5mKvug/9ifM+Y7O4beeE1yQMTFnvFKMzmExo9flN7uQ8eVan21nQjAC45FR
	kQyvAgxWZmilBfWbpWKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmG68-0000YW-8A; Wed, 23 Jan 2019 10:49:32 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmG64-0000YA-4w
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:49:29 +0000
Received: from lupine.hi.pengutronix.de
 ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1gmG5w-0000rg-RX; Wed, 23 Jan 2019 11:49:20 +0100
Message-ID: <1548240560.3904.6.camel@pengutronix.de>
Subject: Re: [PATCH v5 3/3] reset: imx7: Add support for i.MX8MQ IP block
 variant
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 23 Jan 2019 11:49:20 +0100
In-Reply-To: <20190122021043.25449-4-andrew.smirnov@gmail.com>
References: <20190122021043.25449-1-andrew.smirnov@gmail.com>
 <20190122021043.25449-4-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_024928_345223_C765E62C 
X-CRM114-Status: UNSURE (   8.98  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrey,

On Mon, 2019-01-21 at 18:10 -0800, Andrey Smirnov wrote:
> Add bits and pieces needed to support IP block variant found on
> i.MX8MQ SoCs.
> 
> Cc: p.zabel@pengutronix.de
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy@gmail.com
> Cc: l.stach@pengutronix.de
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
[...]
> +static int imx8mq_reset_assert(struct reset_controller_dev *rcdev,
> +			     unsigned long id)
                            ^
> +{
> +	return imx8mq_reset_set(rcdev, id, true);
> +}
> +
> +static int imx8mq_reset_deassert(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
                              ^
> +{
> +	return imx8mq_reset_set(rcdev, id, false);
> +}

Thank you, applied all three to reset/next with a small whitespace
alignment fix.

regards
Philipp

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
