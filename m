Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D39C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:43:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F50020892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NeRbK3QL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrB5L84k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F50020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bDC9y+BtDMQJ4xRWolWc2anxp7tCaDfQ1VVJIfqVOQk=; b=NeRbK3QLJusW/B
	GQ5HLLS/fzbrhT9VEwaGXL2raLX32thgQlWRa6mJu2j8gv9ZvedC3KMbN14lwCUwIibVrDtq1QAXC
	k6YV2kkN6jn125OA4cYPetKI5cWw9KKP/N6gEJQng3CHbnIQuEPYF9uxgNfSVWcFsYK4YpYjPL+Pq
	cw4Oz0VrTQblZDBbofBMp/Yl1b/KgrQu6A3lAHeg57thtL3g7ikjgAj6Ubb+eGg7pEA601A6Hbnfk
	He4K5t5PFSnHeusRD6WjiiLAfuvsslMPkMdZx5vON9VcIxBxhWSYXsyoNDZn9PNchc1CplrRW2uTj
	ITLjkCptnQorjUqk7jkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUd4i-0005Tu-06; Wed, 05 Dec 2018 19:43:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUd4f-0005TC-EZ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 19:43:10 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0CB3B20892;
 Wed,  5 Dec 2018 19:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544038979;
 bh=RXXNtRRNwYb/woiVusohMNz6wg6Q9tnaWcMlh8GM6TA=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=BrB5L84k89yZ8gbGeQP9MdMvKt5DoIGNoluCmORG0tA/EHXkIE0EIYNN1TfcbxFNN
 cnW5nL6nTNY0rdmXPWkrvvn3A4HNZJKTXPDWC9yvWU8GCBUY3K69YT5eVPNpBf6sMl
 kByVSoPipwJeeGZWbvJeokK51k+RkwT7NqxQjmvg=
MIME-Version: 1.0
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng DONG <aisheng.dong@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM0PR04MB4211FE93C147DB95181E8CBE80AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1542809234-539-1-git-send-email-aisheng.dong@nxp.com>
 <1542809234-539-3-git-send-email-aisheng.dong@nxp.com>
 <154386202048.88331.5253991483966563852@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211FE93C147DB95181E8CBE80AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154403897845.88331.2924678136478578037@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH V8 2/7] clk: imx: add scu clock common part
Date: Wed, 05 Dec 2018 11:42:58 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_114309_503308_441135D1 
X-CRM114-Status: GOOD (  11.77  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng DONG (2018-12-03 17:26:01)
> > > +};
> > > +
> > > +/*
> > > + * struct imx_sc_msg_get_clock_rate - clock get rate protocol
> > > + * @hdr: SCU protocol header
> > > + * @req: get rate request protocol
> > > + * @resp: get rate response protocol
> > > + *
> > > + * This structure describes the SCU protocol of clock rate get  */
> > > +struct imx_sc_msg_get_clock_rate {
> > > +       struct imx_sc_rpc_msg hdr;
> > > +       union {
> > > +               struct req_get_clock_rate req;
> > > +               struct resp_get_clock_rate resp;
> > > +       } data;
> > > +} __packed;
> > 
> > Does this need __packed? struct imx_sc_rpc_msg is naturally aligned so I think
> > we don't need this.
> > 
> 
> I think this is more safe way. But struct imx_sc_rpc_msg is unlikely to change.
> So I guess it's safe to remove it.

If the struct is naturally aligned then I would say remove __packed and
only add the marking if it is really needed. It makes more work now, but
is cleaner to do it this way so we don't have to think about it later
and we may be able to generate slightly better code if the compiler
doesn't have to worry about packed either.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
