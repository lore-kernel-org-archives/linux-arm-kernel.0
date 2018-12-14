Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC60C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:12:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F730206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O68mRqbY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Zg5KFdxc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HkW8eZQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F730206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qrS4dMObhtbbm6v2W8KyLc0kuQbG+iBEDJJgSqxIKpU=; b=O68mRqbYRXBGJk
	1U2SlpZtz4P8cc2JHHYZ5bCdRWTfZF+Dx/lFLleEDdNfu6Si2IesCe9MGr3QSKkDaIrNdxCYoiOq0
	v4w2B0yaIY0+VXo+ew1QEv7yK4rDMayEETCcq7qqUHsL6WttHpA616HXnohsyVVkjrBJv3ukUoeD0
	KoGeHVtf+gnpv4dbjN7TfF4SjyKj3GZSSR5REneqFyKJBx68E4prOum3DwUxjMOmJ1ukp2x3RfY8i
	Fx+kRWBaVoc51wPZ5BssYyj4A4lszzr31/eRabSE4uQvekz86Y54aAuY52AG0PbyiZRUU5EpAZiQw
	ilyZA8R7wAQ6cTzycy9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXrwj-0007j1-HK; Fri, 14 Dec 2018 18:12:21 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXrwf-0007hv-WD
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 18:12:19 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBEHtFc2029226;
 Fri, 14 Dec 2018 10:11:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uMLPRs03fGvOAzhYlqG5Ll4l/u8GF3sNWJYWIP4K35U=;
 b=Zg5KFdxcVz9LvLDw31cr4mcSnFE+MzWDOSMdvobls41kRsmeIQMfST2YNcwHELu9STYJ
 6TL5q5846IEV8SAUy4qQmdv0ylMGcIUhW+0mVM+QYLwWW9ZkxQxbxBseQeTdAwwUsuKT
 /92Kp+8Kh8/nu6XRL5WErSAPwU0Jz2zaPlE= 
Received: from mail.thefacebook.com ([199.201.64.23])
 by m0089730.ppops.net with ESMTP id 2pcfs58ct6-9
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 14 Dec 2018 10:11:55 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 10:11:24 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 10:11:23 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 14 Dec 2018 10:11:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMLPRs03fGvOAzhYlqG5Ll4l/u8GF3sNWJYWIP4K35U=;
 b=HkW8eZQJObaqYDZhs6bN2FmokzSCRzxUduBLvgj6hW/zaQ7/alcsOdWXImzoF6nuldhulgdDIoKn1aW6znbnXgM/i31brmmoJR1zP7ZjpoHCSi+uZFs9G7WhmsqrUK3nwcSFD13CR10lOsOS67se3M7q2siMlBFlEIevyPReANQ=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1544.namprd15.prod.outlook.com (10.172.162.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 18:11:21 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::1bd:fa86:857:9b04%10]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 18:11:21 +0000
From: Vijay Khemka <vijaykhemka@fb.com>
To: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, "Rob
 Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
Thread-Topic: [PATCH 1/4] ARM: dts: aspeed: Add sensors devices for Facebook
Thread-Index: AQHUkx2FLuLFnaparUSSS8WntKzruKV9R9KAgAC8q4A=
Date: Fri, 14 Dec 2018 18:11:21 +0000
Message-ID: <B6C3C92D-1F9E-4425-ABF5-718D1A6755EB@fb.com>
References: <20181213195319.1333402-1-vijaykhemka@fb.com>
 <CACPK8XfAXDHqWcD=OKm4UhCh-+-7GBxL02Fi9_jgdmo2ZQZSjg@mail.gmail.com>
In-Reply-To: <CACPK8XfAXDHqWcD=OKm4UhCh-+-7GBxL02Fi9_jgdmo2ZQZSjg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::5:32a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR15MB1544;
 20:2TzQ0BGX/IEpR9Jo3t0CXEJzRQ/8nDm3YVN+6ObR2MI9ZKD2BNpcPUv3uaKoPtVETS0/z1GlQ4YcYB98ypPcQ7l87eeYW8CC8+f7iUhS7jBYkdLs4cQSRekZTSHDX1KjLpYkB3/jztYK2ZKkL5jGrki3jo+Qv2HKv6wWOlaoO20=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cf44c02e-608c-4f9f-6436-08d661ef8d70
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR15MB1544; 
x-ms-traffictypediagnostic: CY4PR15MB1544:
x-microsoft-antispam-prvs: <CY4PR15MB15448B002778BB575204FA4ADDA10@CY4PR15MB1544.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:CY4PR15MB1544; BCL:0; PCL:0; RULEID:; SRVR:CY4PR15MB1544; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(346002)(366004)(136003)(376002)(396003)(47680400002)(189003)(199004)(53936002)(99286004)(4326008)(86362001)(83716004)(46003)(6512007)(446003)(7416002)(6246003)(229853002)(478600001)(316002)(7736002)(2906002)(54906003)(110136005)(71200400001)(71190400001)(76176011)(102836004)(53546011)(6506007)(186003)(82746002)(68736007)(6436002)(6486002)(25786009)(106356001)(33656002)(6116002)(256004)(5660300001)(305945005)(11346002)(105586002)(14454004)(97736004)(486006)(2616005)(476003)(36756003)(8936002)(81166006)(8676002)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR15MB1544;
 H:CY4PR15MB1269.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 05SqbRHiDa2PCB6CtGnInyVq44EUhoJWgcUgfgHKB2KU7RJBxz24pKjm11+VMaPUFDGJBde5IUBfMcYKdWCzVIv1tFIZnbfI6AmdTiVAslgPsfCPL0/wWgP+XaBZyfmaXhw/x84+nU9o8Quw/Pw7mXbS0AvG7VDyJYseoYzn3spPaRgY82C+tQytZQyR6+cuYRrE9jSvSCHD8IwVj92eKSZmFRRg24PguyL/ZuNlqCqAc2nCYPuLjqo15R0noIBfC8VqYU8faSMO4yynlWqLYFuHHu6zD1fEVosU4n35eEiZIXuDL9tuHe3sV+t7IBJt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <4CA366D04D0E184A82A8F707A9625F7F@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cf44c02e-608c-4f9f-6436-08d661ef8d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 18:11:21.6734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1544
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-14_10:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_101218_193674_DB5F3487 
X-CRM114-Status: GOOD (  20.89  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "james.feist@linux.intel.com" <james.feist@linux.intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/13/18, 2:56 PM, "Joel Stanley" <joel@jms.id.au> wrote:

    On Fri, 14 Dec 2018 at 06:23, Vijay Khemka <vijaykhemka@fb.com> wrote:
    >
    > Added ADC and other sensor devices in Facebook Tiogapass device tree.
    >
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    > ---
    >  .../dts/aspeed-bmc-facebook-tiogapass.dts     | 33 +++++++++++++++++--
    >  1 file changed, 31 insertions(+), 2 deletions(-)
    >
    > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    > index f8e7b71af7e6..58bbe08d3ba7 100644
    > --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
    > @@ -21,6 +21,25 @@
    >         memory@80000000 {
    >                 reg = <0x80000000 0x20000000>;
    >         };
    > +
    > +       iio-hwmon {
    > +               compatible = "iio-hwmon";
    > +               oemname0 = "MB_P3V3";
    > +               oemname1 = "MB_P5V";
    > +               oemname2 = "MB_P12V";
    > +               oemname3 = "MB_P1V05";
    > +               oemname4 = "MB_PVNN_PCH_STBY";
    > +               oemname5 = "MB_P3V3_STBY";
    > +               oemname6 = "MB_P5V_STBY";
    
    "oemname" isn't part of the upstream bindings. Is this something you
    have patches for?
This is a workaround field used by dbus-sensors application to avoid overlay for dynamic detection of devices based on json file definition.

Can you please also review other 3 patches in this series.
    

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
