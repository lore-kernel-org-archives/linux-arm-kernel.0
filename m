Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30359C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:52:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A5F2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bzlhkprR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="th7J+H0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A5F2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=baY218zFJbrIoZ/tCm4k84eqYBpdcZtJdazFLsTjadg=; b=bzlhkprRXwfAau
	wrvBbzRzLID0IJDEPNBkn/5OIyDNkXamhhsnHC24CqRoi5i31gxNlWWoX+9oQQ2pe+glZ/CxqWxKY
	1INjiNfMH/EFzaT+7orR4JVBOWxigx07Tjc2MYF/DBYSsuTSNs7rkkl0wtRVaQka6/nTUiRxztWeP
	lEH9gE3PUoXris83df7kn56G3opkImzG0TVNZLgiEZUmFQXhimCUChKoI3wUwSMyqmga4RsH6/OLj
	9LU77ZMbLUV9jhuKEGpx6fpo0hZlEddbQE+bSmYN2VeLIUPoY3uLXlSc6m6lfCODO8Z9otQbSQY3l
	3xdzbefSpltM24KQ9mCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVb9j-0006Io-RM; Sat, 08 Dec 2018 11:52:23 +0000
Received: from mail-db5eur01on0607.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::607]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVb9g-0006IA-6x
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 11:52:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaeWFvrsXhK56kFaDLLsEhBZtmEpWqSmqDn2wjzKFyQ=;
 b=th7J+H0JOQvq6pNAmIMklv49gjp9yFxwjgGaw8H7KeRN6oCDFsucGZF8qql7hKo8P9xNIW0J4vScpdYkrq2ulQU+1K/vEBt9Ulmm6u0iMAjzyU7kl11mPp9LmLYEu2ZCTW6gVv68iVwoi1rXxwgx1zj+4BMIFqxQtggp56P+W98=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3720.eurprd04.prod.outlook.com (52.133.29.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Sat, 8 Dec 2018 11:52:03 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%4]) with mapi id 15.20.1404.023; Sat, 8 Dec 2018
 11:52:03 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v4 2/6] arm64: add basic DTS for i.MX8MQ
Thread-Topic: [PATCH v4 2/6] arm64: add basic DTS for i.MX8MQ
Thread-Index: AQHUfELcnHGgzTZTVUSaNCzZm56coaVTDsYAgCCJYICAAAVxAIAAS48AgAD3MQA=
Date: Sat, 8 Dec 2018 11:52:03 +0000
Message-ID: <20181208115202.uxgbvc2kmjnowisj@fsr-ub1664-175>
References: <20181114175242.12468-1-l.stach@pengutronix.de>
 <20181114175242.12468-2-l.stach@pengutronix.de> <20181116232524.GA2013@bogus>
 <20181207161723.2u5z3sdobbpop4kz@fsr-ub1664-175>
 <1544200612.3709.111.camel@pengutronix.de>
 <20181207210718.ueg2uw6tfniniscl@fsr-ub1664-175>
In-Reply-To: <20181207210718.ueg2uw6tfniniscl@fsr-ub1664-175>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3720;
 6:BqHYHAbp0YsAZo3k7fOC15ibQKouAOgQl6/G8LLSfnv5EI71oyZWP8y0f8NJ6AGYTe3vB/uHmQsYG184JEW4IUQX3As7coCDK87VAKyEW5LagLem1suznO2kodIG9g5cMelVhseVSqneqURppRKq7xQy/F8jkSQM59mJL2QAJn/tIzXJdicTS5F50rP+VJajUgFfPX7yWqfVyLRxB4t/CTn7bZuY8UGu3b6EP0fxNwodDT1UljG0PqoQMUZVfiAk3pDKQwXx5PdkEHb8+UoyXYZ42XeqAjvjwKKROAngmWZdeSdDy4hZFKAuhnaW8pdbbyll3FycGJ0eeB5C7nynk+f8Ne8KA1aU5T134+c0p0k3dnoMlbWHeszufBnxKB7p9gfbTR1J1GXiFnzDpEsmRPyQOGy5/2l73D304594GBwxQ5GD/QUVS6aLpdyY0g29cXZqNR0ux2JfaB4JApJMpQ==;
 5:gdJwGp3AdwoVq5KyA7GPVgiB9caYsj/FQlGNCZG+rKXZfmKCTVEq871cmxXbVF0JeRemdTZp/pwutWrf4AxqYqo19KkL0X2JnpOrmsEwZYsqd5lkFb0WKr1/z0zhZXvItN2J778dqGbMX+e+c1ym3xX7CuwvRWXJ6o/0nppwotM=;
 7:YpG+NP13OHu/2BxsWRFwvqM7rGzDBKQvASFzEIWpJiYNyp4QenQ5OdApzpCi6i3DXxUJyZeilukOXMVtnOaBHr35M5gvgYQF3T05CXkQE0NU9zHclI6yP4VJ9TbcMptsnD+SZpVFHSWzAGFWGsnLyQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 77977754-1eb8-477f-26e3-08d65d03921c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3720; 
x-ms-traffictypediagnostic: AM6PR0402MB3720:
x-microsoft-antispam-prvs: <AM6PR0402MB372085BF3581CB4AC69CFE62F6AB0@AM6PR0402MB3720.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3720; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3720; 
x-forefront-prvs: 0880FB6EC1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(8676002)(81156014)(25786009)(66066001)(68736007)(6306002)(14454004)(8936002)(966005)(81166006)(478600001)(45080400002)(93886005)(54906003)(99286004)(53936002)(9686003)(6512007)(4326008)(6246003)(97736004)(316002)(6506007)(102836004)(76176011)(6916009)(33896004)(186003)(26005)(3846002)(6116002)(33716001)(229853002)(305945005)(7736002)(5660300001)(256004)(486006)(44832011)(446003)(476003)(11346002)(71200400001)(6436002)(105586002)(71190400001)(2906002)(106356001)(86362001)(1076002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3720;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JmfpRPYIZkH8xQKcVu0sDlN2la2X/MJ0uJYPwIpw9KNIIk9/Q1wCGzMEMvaxX0uTNn1w6VJgD3s5iI0VQJPnrRlKM+N32nlD3B2zSbBAByaqXxbpyZzamMklsy3YJMMFu6Fsm1a/jtALkjwyuca6Csj8SOmMj0M+YkcNixaa4KjGH+mMRBUDLW+BAO2AFc4TTMwoLBSrsDv7tkdrCYFSrB562m8akrbtmdRneOBOmZL2XS3xsFwjorvyFB3E7tAWvwU843E5pm0K1Zri+PGxS3/9FBU4S9aAt5MExYmjnSKhyN3mTSOw2IWH0g9mhv98a1DMQaGMqgjDRIsQ/jRuyuldwOelliU7Vg59LyeykBo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <4D2975C01CA10D4E8F2991BB756FA8C4@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77977754-1eb8-477f-26e3-08d65d03921c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2018 11:52:03.6066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3720
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_035220_322427_2A693344 
X-CRM114-Status: GOOD (  22.09  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 09:07:19PM +0000, Abel Vesa wrote:
> On Fri, Dec 07, 2018 at 05:36:52PM +0100, Lucas Stach wrote:
> > Hi Abel,
> > 
> > Am Freitag, den 07.12.2018, 16:17 +0000 schrieb Abel Vesa:
> > > On Fri, Nov 16, 2018 at 05:25:24PM -0600, Rob Herring wrote:
> > > 
> > > > > +
> > > > > +	clk_ext1: clock-ext1 {
> > > > > +		compatible = "fixed-clock";
> > > > > +		#clock-cells = <0>;
> > > > > +		clock-frequency = <133000000>;
> > > > > +		clock-output-names = "clk_ext1";
> > > > > +	};
> > > > > +
> > > > > +	clk_ext2: clock-ext2 {
> > > > > +		compatible = "fixed-clock";
> > > > > +		#clock-cells = <0>;
> > > > > +		clock-frequency = <133000000>;
> > > > > +		clock-output-names = "clk_ext2";
> > > > > +	};
> > > > > +
> > > > > +	clk_ext3: clock-ext3 {
> > > > > +		compatible = "fixed-clock";
> > > > > +		#clock-cells = <0>;
> > > > > +		clock-frequency = <133000000>;
> > > > > +		clock-output-names = "clk_ext3";
> > > > > +	};
> > > > > +
> > > > > +	clk_ext4: clock-ext4 {
> > > > > +		compatible = "fixed-clock";
> > > > > +		#clock-cells = <0>;
> > > > > +		clock-frequency= <133000000>;
> > > > > +		clock-output-names = "clk_ext4";
> > > > > +	};
> > > > 
> > > > This is really 4 independent clocks or is 1 clock connected to 4
> > > > sinks?
> > > 
> > > According to the RM, yes, there are 4 independent clocks. Here is a
> > > link to the rm:
> > > 
> > > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nxp.com%2Fwebapp%2FDownload%3FcolCode%3DIMX8MEVKBHUG&amp;data=02%7C01%7Cabel.vesa%40nxp.com%7C303f3053feb94a3c1c9f08d65c623255%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636797974154936811&amp;sdata=CuJSqDl1WiL%2Bc%2B4wYnr3ssDDpH3DorYIzLN87PNHVh4%3D&amp;reserved=0 (page 829)
> > > 
> > > Unfortunately, the old link (which worked without login) does not
> > > work anymore.
> > 
> > It's really 4 clock inputs to the SoC, but they may actually be
> > connected to the same clock source on the board. So I really wonder if
> > we should even put this into the base SoC DT, but rather push this into
> > individual board DTs.
> 
> Hmm, it's part of the SoC, right ? So I would keep it in the dtsi rather than
> having it duplicated into every new dts.
>

On a second thought, you're right, they seem to be input from the board and
would make sense to be in the board specific dts file.

Though, one problem with that is that the imx8mq CCM driver expects them to
be available.

One solution would be to keep as is since there is only one board (evk)
that is supported.

Later on, when another board comes around (and if it doesn't provide all the ext
clocks) we can rework the CCM driver to supoort that. 
 
> > 
> > Regards,
> > Lucas
> 
> -- 

-- 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
