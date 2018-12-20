Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C66C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:50:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E3521852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rgFl0Izv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GVLe5Ofk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E3521852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ea2FIv1uSGqYoWhzzFB+fu4ht1yNkJv3pG9zPUCARW4=; b=rgFl0IzvKksCo2
	UdBCJiay4BX49RRitI7JnYjUyPpHyne1oFat97jYLTTSPbNHsU2mmEOgaBoHuh8bIGOxdwaQ93qWj
	QME4QsvzuXCrc3JLBfTAHoTfsBGiTdQk80cDrgDxW4Vf69hpsZWRnu3Nm4YeNarvgDmVQAMIAHK4B
	TgsYp0sYKEpY3l21k4x3spj1O/PG8fu7v9Nu92p9JhhrwptgWW+BU5e6pFMVZPlEdH1pHqk+7TuBB
	B/QH5R23n1jZgYK2yTdSFz+HNRaZ2VYC++YgS0AriGAWM5LLzMoVY3UPl3xVgMs/Ldw6Acq/gedpO
	fmHws/kAjSQDR+f4F73w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZyi8-0007Bc-5I; Thu, 20 Dec 2018 13:50:00 +0000
Received: from mail-eopbgr130058.outbound.protection.outlook.com
 ([40.107.13.58] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZyi4-0007A4-R7
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 13:49:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkcCJiV2WQFsrXNuqNgG7d72OprWL334/HS7NT47Vjw=;
 b=GVLe5OfkxXzJpS4rNfVsRcCpkG+MPnNz1EuKqVd26V2Hciq8GWIbR0plIYL0mtk/SLfRKn+b3ZMhvXCSrnPh5YzvTMXSzD+1qtkVlPy32KD0WpeNttVoZSnjIZ21ZjEBmH16Wp1J8ZiTbveHEgf33VEaS0Lr7TJwSFr5jFN1MtY=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4208.eurprd04.prod.outlook.com (52.134.30.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Thu, 20 Dec 2018 13:49:39 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::7d6d:ce34:3439:c184]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::7d6d:ce34:3439:c184%4]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 13:49:39 +0000
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Trent Piepho <tpiepho@impinj.com>, "andrew.smirnov@gmail.com"
 <andrew.smirnov@gmail.com>, "robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
Thread-Topic: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
Thread-Index: AQHUlocxSxlVauzxZ0epY0uSJZc9vQ==
Date: Thu, 20 Dec 2018 13:49:38 +0000
Message-ID: <VI1PR04MB553399573A1D360C62C17E61EEBF0@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com>
 <20181218151533.GA2922@bogus>
 <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
 <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
 <CAHQ1cqEMxxo9JGN5be4XQWAtPz7nC2JyLCr3qasnD5QK7_hOYQ@mail.gmail.com>
 <1545268969.22930.77.camel@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4208;
 6:7IPnIeMhbOu36/3E0MyaxMqnz+ED2KsZbjoL/gfw3WpzWFa9BtuI+9Dxr0U9KtWqH8kLCO0uJGsYz8VlTuQowV7cp7H32xB9OI84eAXhNvkKQYYL36mzGv0bWr0pm5rloBdf0fKuHjni5oJtGbThpqIMSH5vfhUJ/UFH2EvbplTpLQTIKTHHCZh9Np8cS+iljoR7XRmTZ+jsNcTWMXfH9IA+tCE6oHFk+uAwbQccBNNU7SrOqtV0vpvYXv7OFzjvCl901H9RyE/hmpwzdY2L3YEgh2mycWmBlEtXyBO9trGhZ2s/volMi3hDMmrIbJ90vyj/J5KRjfGf1u52csT6uey1dTG/Wq3vGCGCclZKbXGYrsyvK69AcJJGSlZL/P4K+8nxYHNfGICEl29oEjeKiEfedQNiBQ/561LuMyxnrpqZtXP0NvljRtq5YSp0IAhxKH6zZccN4AuiZfAcwAY32Q==;
 5:u17CXV2TpFw5bCl2Cy44bqQyKh4eK4kR3mawa1WqH0hIfjUBpPHn+mH5mj0DBx93VlL2Rd5xiETbIApwFdC0we0qcWd8JdnNrt6Jx5iI3JlH1IiWYlxF05Oi6ymJObDNn5COBjwLtBNadibIwuUO5npGKgM0MCJgMqB2yOUnBco=;
 7:FOCE4AUSGqfu+rBSaqLtJgcRLmkY2uMUPwVJ0cmuCoA4VaCs+Pc3lb3MM1VeZRqPJLjS7GZVFgw5VSaldnhJgOcEN5YmVx2ZEWREBmvOy+D2rj3MFkxCWWwQLScS5XOMNu6OJPVfvhNDqJcMneIn1w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a0288583-788a-40d2-2dd4-08d66681fc6a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4208; 
x-ms-traffictypediagnostic: VI1PR04MB4208:
x-microsoft-antispam-prvs: <VI1PR04MB4208124F5081D5FF5B8D5674EEBF0@VI1PR04MB4208.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4208; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4208; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(7416002)(4001150100001)(6436002)(6116002)(14454004)(68736007)(44832011)(486006)(54906003)(26005)(9686003)(2201001)(476003)(97736004)(5660300001)(305945005)(8936002)(39060400002)(76176011)(74316002)(105586002)(8676002)(6506007)(4326008)(7696005)(53936002)(110136005)(55016002)(478600001)(102836004)(86362001)(66066001)(53546011)(7736002)(33656002)(256004)(2501003)(81166006)(229853002)(2906002)(316002)(99286004)(186003)(71190400001)(106356001)(3846002)(93886005)(25786009)(81156014)(446003)(71200400001)(6246003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4208;
 H:VI1PR04MB5533.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VGEjqDLLpUiukcbASdUyKIvXFcsznDxqNJyJENYiZp4ZwnOYAgiYV6pYQDNBgjPviQLCqcR1MtNeYNt42DhH7Aiox2K/SZUn7Cw4y6tSlVmVMK6Hl7afojz9cK/UXYTmzSmp5LJLRoH3VRcOFgramB9vnfl4HFTgIxeOcCI+YGYRx7TqSlVOBzhXVo3+hb7tkjfdxCWVWGWNWHooLxUTgBEbIYhG6TED4BLVlzJUhbzRpHEV3WRie+sfnSygslar04yCabidrXtb2ZMnlnHXSBDS4iyiTXBTMEVO77HsLxKUAErQsyraL9LYDvJP63/o
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0288583-788a-40d2-2dd4-08d66681fc6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 13:49:38.9103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4208
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_054956_881144_01F0D214 
X-CRM114-Status: GOOD (  15.92  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, "cphealy@gmail.com" <cphealy@gmail.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/20/2018 3:22 AM, Trent Piepho wrote:
> On Wed, 2018-12-19 at 16:47 -0800, Andrey Smirnov wrote:

>>>> This series initially added explicit offsets but I suggested a single
>>>> "controller-id" because:
>>>>    * There are multiple bit and byte offsets
>>>>    * Other imx8 SOCs also have 2x pcie with other bit/byte offsets
>>>>
>>>> Hiding this behind a compatible string and single "controller-id" seem
>>>> preferable to elaborating register maps in dt bindings. It also makes
>>>> upgrades simpler: if features are added which use other bits there is no
>>>> need to describe them in DT and deal with compatibility headaches.
>>>
>>> You already have an id for the controllers: the address. Use that if
>>> you don't want to put the register offsets in DT.
>>
>> Lucas, are you on board with this?
> 
> Does address here mean the address from the controller's reg property?
>   
> How do you map that address to the controller's index?

I guess you could have a constant for the address of the first 
controller and then substract. But hardcoding any sort of physical 
address feels wrong with DT.
> The situation here is that some registers for these controllers are
> interleaved, right?  I.e., there's one register somewhere where bit 0
> means enable controller 0 and bit 1 means enable controller 1 and so
> on.
> 
> Isn't cell-index already the standard device tree property for this
> kind of setup?

Look at how this cell-index property is documented in other bindings it 
seems to be an excellent fit: just rename controller-id to cell-index.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
