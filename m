Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A715C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:06:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26FF20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rGUH/+ml";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlKttpPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26FF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:From:Subject:References
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wuiTwY5RV/QX6THHeP+RqkGxjwh4sEgy/Mwt9BKw26w=; b=rGUH/+mlLlTLmN
	rKML30Wg6Zo6nxG/S+s8All/Rsu61p2gzeHddx2a3NbFDYWCyHnEeIzz6HvAwYrFgQ9XP4rwPXm5s
	U7anIRj2YpFBleaF/yoQGekdVeUb5a4eKBE9zdvyOCY5z+VmQcoiKlsO9Ejx/U45vSnwCj59Bycd7
	v/qO8+gNHRQT1tp+t88GTTgyf0zaiTfyIqRAKPn7LMxWAfaCumLEmDdKRy4+put4JFoc9I0Q+YPOI
	FDz6ZA1JtmRr0s5fTd/DdsyJ5KGhdhNpY+UDWnCfgxOzFzdC715AuoOQeHR44xMTg0RXxOd2qkdU4
	l9XazI/hzLuFjvGXwxfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm1Nt-0001Yi-Mg; Tue, 22 Jan 2019 19:06:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm1Np-0001YM-Iw
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 19:06:52 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 335D220856;
 Tue, 22 Jan 2019 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548184009;
 bh=9pRc+Fg5KfwT3VHobTyrcTqCOOG+bhhAqeMWDWKgWD8=;
 h=To:In-Reply-To:References:Subject:From:Cc:Date:From;
 b=dlKttpPHA+QlSDUA1Gcu084bnKBl5qnNXbqVkQpD6rgLznjVF7GAanEc55cmBP9Q/
 f1BFD5So3oJOKXu74z2iDAHkBgxb2D9JdhkDfSf5GcGEnzpbvUt6Stfuy0kVDpH7By
 q5JsnqIXmY38LS36HFwj40Asqt7+jRk0Detv6SQM=
MIME-Version: 1.0
To: Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <20190116110216.GN15808@dragon>
User-Agent: alot/0.8
References: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB42115D3E98B8B319936AC60E80820@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20190116110216.GN15808@dragon>
Subject: Re: [PATCH RESEND v1 0/4] dt-binding: clk: prepare for imx8qm clock
 support
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154818400852.20280.9414688242016617890@swboyd.mtv.corp.google.com>
Date: Tue, 22 Jan 2019 11:06:48 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_110649_635481_32E2A521 
X-CRM114-Status: UNSURE (   9.31  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Shawn Guo (2019-01-16 03:02:17)
> On Wed, Jan 16, 2019 at 05:40:01AM +0000, Aisheng Dong wrote:
> > Ping...
> > 
> > BTW, as the first two patches change the same firmware binding doc fs.scu.txt.
> > I'm not sure whether it should go to Shawn's tree for the binding part, or Stephen's clock tree.
> > 
> > Shawn & Stephen,
> > What's your suggestion?
> 
> I can apply the first two to my tree as long as Rob and Stephen ack on
> them.
> 

The first two are documentation updates? I don't care really either way,
so I gave my ack in case you want to pick them up before I get around to
the rest of the series.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
