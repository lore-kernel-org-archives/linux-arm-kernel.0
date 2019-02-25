Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC9CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:22:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CF020684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ea3UFzmR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JevmI0d3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CF020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SlebvviiPHRjeWq331NcXDXZwpC19Xat0hVz46Uk95Q=; b=ea3UFzmRjAYDJs
	UFNOfX2Ft/yX0F4cz0mtJS1HxMI8KdJXUpHDHrm/zCPwjQu9qHRFZE/HstRTab2n5zhCkObWmKBmi
	3ogYEcIN+EHOqNlyrZppsOleuGvj8MUtk9G2cPGln51bfO/07Fa5cmtI6DlDTLuosVijVoBbv4Wz2
	nxoeYmFP5MZQ6xh+XiZQF0k276saMzOfjBPa/xc4fSLeZ8qPA39KAuq9HynyA7kvtkXhmgVPdrSuE
	5jeDMONi/dybW/+ItZhqf2g237JcU/vuIhm58YphDjYehfI6UbSmIc2vaW1HqKoZy8ENOUjlIdFWa
	L3qX/VB9g3KLk9vAXpNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJwy-000748-E0; Mon, 25 Feb 2019 17:21:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJwr-000701-UV
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 17:21:51 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8C57420684;
 Mon, 25 Feb 2019 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551115309;
 bh=B11qdtzD4kvPekptQ8/DwF7Tpovpen1qO75lHMRYb58=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=JevmI0d3htbubzraz3yIWbu8XD/A1b8k7lwL/g/JM0fU8SK6vry+byfb64hfM1+1j
 b7PpFKMm363LJ8m+mudNHYa3Nkn7Zv/OzhNxDnrBfYdz+3Yo1I6qj1F81FuQ9OR3gH
 x5MtJcpodyrqsw365DHsiso1R2a9W6c5bUkgUAEs=
MIME-Version: 1.0
Subject: RE: [PATCH RESEND V6 2/2] clk: imx: scu: add cpu frequency scaling
 support
Message-ID: <155111530880.77512.16435986555733393398@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550802436-13007-1-git-send-email-Anson.Huang@nxp.com>
 <1550802436-13007-2-git-send-email-Anson.Huang@nxp.com>
 <155086249004.77512.8709011386763447047@swboyd.mtv.corp.google.com>
 <DB3PR0402MB3916BA142113B84C0199C93EF5780@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <DB3PR0402MB3916BA142113B84C0199C93EF5780@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
Date: Mon, 25 Feb 2019 09:21:48 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_092149_996628_4547474B 
X-CRM114-Status: GOOD (  14.49  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Anson Huang (2019-02-22 18:32:28)
> > > +               cluster_id = 0;
> > 
> > Do we still need to check this anymore? Why not just always use cluster_id 0?
> 
> The i.MX8QXP ONLY has 1 cluster named A35, while on i.MX8QM there will be
> 2 clusters, A53 and A72, so we need to use the resource ID to initialize the cluster_id.
> 
> > 
> > > +
> > > +       /* CPU frequency scaling can ONLY be done by ARM-Trusted-Firmware
> > */
> > > +       arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
> > > +                     cluster_id, rate, 0, 0, 0, 0, &res);
> > 
> > Because not checking would make this work, vs. checking causes this code to
> > sometimes use an uninitialized value from the stack.
> 
>  89 +       if (rsrc_id == IMX_SC_R_A35)
>  90 +               init.ops = &clk_scu_cpu_ops;
>  91 +       else
>  92 +               init.ops = &clk_scu_ops;
> 
> I think it should be good. Only when plan to support cpu-freq scaling, then the
> CPU clock will be switched to use clk_scu_cpu_ops and the clutser_id initialization
> will be done according to CPU resource. For example, when we plan to support i.MX8QM
> cpu-freq scaling, we will add A53 and A72 check here and switch the clock ops to clk_scu_cpu_ops,
> also we will add the cluster_id initialization in the SMC clock set rate.
> 

Ok. So then please make the set_rate function fail if the rsrc_id
doesn't match something expected. As the code is written right now, the
compiler can't figure out that cluster_id will always be assigned, so it
complains that it may be using uninitialized data.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
