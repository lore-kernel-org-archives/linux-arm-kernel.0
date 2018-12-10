Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF354C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:36:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9CB20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H28k2QSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9CB20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r/RNuS5B2eAlUgDLMPy0tK3Nk1NnfkIJ/8TOi5P+pJE=; b=H28k2QSzLKyARu
	xGVstP8cZgguh5jx0qjBLq7OW1ZxixI9ITTSy/CwgK0LAmpbP5fHgk/gFFx5wFfp04hznwKzxvp9B
	41R1JTGWrvSAmSS0bu/xb1hiBqdNZGfglTlGhDm74s20wRyzNzUBx+MNCc6Jjatls1itznYbdDC11
	YfFOtLxALglid6yMxp7K9vfoYEQ9OATAODiecvNwwMma4o4HPsbYnK5Z58wB5lgzVUXrzVpVh/8Rl
	5aYlMAnwflYpBZbqb/iDuGqgaNUA832OyuBe3Zzu0Mk1lveKpvzi6qw77owJzlbSs7SMjJlr7/i8F
	d1KqVNlasJo8+73lrgGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKna-0003NX-JR; Mon, 10 Dec 2018 12:36:34 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKnV-0003KW-1G; Mon, 10 Dec 2018 12:36:31 +0000
X-UUID: f4a494469f034bea8d765f5be211ffc5-20181210
X-UUID: f4a494469f034bea8d765f5be211ffc5-20181210
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <nick.fan@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 82825730; Mon, 10 Dec 2018 20:36:13 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Dec 2018 20:36:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Dec 2018 20:36:12 +0800
Message-ID: <1544445372.3502.42.camel@mtksdaap41>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
From: Nick Fan <nick.fan@mediatek.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 10 Dec 2018 20:36:12 +0800
In-Reply-To: <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
 <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_043629_398128_9CF19C4F 
X-CRM114-Status: GOOD (  19.17  )
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
Cc: Nishanth Menon <nm@ti.com>, Chiawen.Lee@mediatek.com,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org, Stephen
 Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 erin.lo@mediatek.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 linux-mediatek@lists.infradead.org, Matthias
 Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-04 at 13:51 +0530, Viresh Kumar wrote:
> On 04-12-18, 14:59, Nick Fan wrote:
> > Add API to get voltage for multiple supplies from opp table
> 
> And who needs to use this new API ? It would be better to add the user in the
> same series to make sure this really gets used.

This new API would be required when handling multiple regulators.
You can check the example 4 in
Documentation/devicetree/bindings/opp/opp.txt for multiple regulators.

When we specify multiple regulator voltages in device tree, we are not
able to access the secondary supply voltages.
Because the dev_pm_opp_get_voltage only returns the first supply
voltages, this new API is required to get the specific supply.

> 
> > Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
> > ---
> >  drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h |  3 +++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 2c2df4e..ee73546 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -113,6 +113,34 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
> >  
> >  /**
> > + * dev_pm_opp_get_voltage_supply() - Gets the voltage corresponding to an opp
> > + * with index
> > + * @opp:        opp for which voltage has to be returned for
> > + * @index:      index to specify the returned supplies
> > + *
> > + * Return: voltage in micro volt corresponding to the opp with index, else
> > + * return 0
> > + *
> > + * This is useful for devices with multiple power supplies.
> > + */
> > +unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
> > +					    unsigned int index)
> 
> How will the users of this API get the index ?

For the users who only use one supply, they can use
dev_pm_opp_get_voltage to get the voltage data from an opp.
But if the users who use more than one supply, they will need this API
to get their voltage data from OPP.
The users should know about the supply count while creating opp table by
using dev_pm_opp_set_regulators function.
By using this API, the users can get the voltages by using index to
specify which supplies they want.

The following is a simple example to get multiple regulators by this
API.
for (i = 0; i < regulator_num; i++)
	target_volt[i] = dev_pm_opp_get_voltage_supply(opp, i);
> 
> > +{
> > +	if (IS_ERR_OR_NULL(opp)) {
> > +		pr_err("%s: Invalid parameters\n", __func__);
> > +		return 0;
> > +	}
> > +
> > +	if (index >= opp->opp_table->regulator_count) {
> > +		pr_err("%s: Invalid supply index: %u\n", __func__, index);
> > +		return 0;
> > +	}
> > +
> > +	return opp->supplies[index].u_volt;
> 
Nick Fan


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
