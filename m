Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4E8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:51:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218772089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kRtYbLMD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LOHgd+04";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="GZTT1ycz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218772089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ViuSi6WNnL2zwkGasd+zNr1m6rfqCqIu0uQsUJj1RPs=; b=kRtYbLMDS2N08w
	BsKvpPhHnlkuaVS7h0TkWY4E+WgIRnElALlKfKi3quMFS3x509FRgwnerL4zJkTea+1ohhRh5lz9Z
	aquWX7zsV9hY6UOL1sEyyCPWJ1TW90hmiFnb2k5HLWaEVRwEcYz5mB8wNrwrAD5bs0iikUL0Q4TeQ
	oSambvJgV2tMxFcOULpIwNTvOrBuSMTSazmsk6fyBMFNxbjWzu/prbuyWgF9asK2jJXPcNbk4Q0Ta
	q3W1mXo7YaXEVKSxEE/y+4OESCDPBFLl7yGTyjZ9Vt9lhCfI2PfAaMtpPzIdFlqeS/1O4HZNbKdxE
	ryhBnoHHR2mRH5k1gUjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggXBT-00066d-RP; Mon, 07 Jan 2019 15:51:23 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggXBO-000662-Vp
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 15:51:21 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x07Fo7YO000403; Mon, 7 Jan 2019 07:50:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=2ybndNsDGpbaOvXTnFJoHPSMSG679zzu5rzY9NUnw5I=;
 b=LOHgd+04iH+Lrz8Md09Hze+xvmFLC5u3rzckMtq0iMSzbx1fYvh35pDWWKbQPaMj8Slo
 xVswqFDalVdv/8uLXnnUN7PzfOCdr0LeLIOHjr0vSy6Fimn2xWRvNZFrcubRB/fzarCc
 djmkgIz8Ea5kxI5UiP747FoTp02Fkf7L9RqAsyvNWneI1g+tPa+PtdV1eBoByzvPQJ4a
 OMYWWLGrtw7FBxSQmXvDXEhzrFxqKa/VMTlcgE+C0hoAmcFAtJC6U1cQ5Zb0HfULoh15
 Tu90RwnNlTkYWu0Pe4c35bIPvNN92Ab705Dy9fwMBTE6Mn0+ZPISW6bTbIdaAdQ8sea1 Ng== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
 by mx0b-0016f401.pphosted.com with ESMTP id 2pv58srykn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 07 Jan 2019 07:50:43 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 7 Jan
 2019 07:50:41 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server
 (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Jan 2019 07:50:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ybndNsDGpbaOvXTnFJoHPSMSG679zzu5rzY9NUnw5I=;
 b=GZTT1ycz7mjjIu8Nh2ilF/+OMF4YastVMzoRwIsTSFEfd7HC8KH493ufMjNvxyvw0IpI2PwpzYaYHVzYaspL26ugeNQao6+5EUBjkBh3TIYi4cXgYqnAGTvRBxW1mDNEE3APsINC1p4WgmwZKVNyeB1wOeUBGpEMSU1aGedL5GU=
Received: from BYAPR18MB2888.namprd18.prod.outlook.com (20.179.58.203) by
 BYAPR18MB2408.namprd18.prod.outlook.com (20.179.91.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 15:50:37 +0000
Received: from BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65]) by BYAPR18MB2888.namprd18.prod.outlook.com
 ([fe80::c1de:fdbc:577e:ac65%4]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 15:50:37 +0000
From: Yuri Norov <ynorov@marvell.com>
To: Yuri Norov <ynorov@marvell.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Thread-Topic: [PATCH v9 00/24] ILP32 for ARM64
Thread-Index: AQHUhpjH9to/8IYtJ0GO80mU13Jv5KWkNDoA
Date: Mon, 7 Jan 2019 15:50:36 +0000
Message-ID: <20190107155028.GA25178@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0091.eurprd02.prod.outlook.com
 (2603:10a6:7:29::20) To BYAPR18MB2888.namprd18.prod.outlook.com
 (2603:10b6:a03:10d::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.58.114.41]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BYAPR18MB2408;
 20:hvCavFvpsTBjP0+7wMIaFHuejr9TEVtqnkx63pps9AFghRI0YoSu2LlCpjniU9MDWK3mdj2XkJB2s5GKo0OQ5jOaIxiRtyLgqbfGqVc2f/tvtCjb+SmuTubAKCbZrXAoOHR4moqtpNQMsoIgFhHK2BgeNBmjIOk5i+uJAU7g4ko=
x-ms-office365-filtering-correlation-id: 5de2bc98-f36a-4f73-1158-08d674b7dd5b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BYAPR18MB2408; 
x-ms-traffictypediagnostic: BYAPR18MB2408:
x-microsoft-antispam-prvs: <BYAPR18MB240822C65ED35986CEC7674CCB890@BYAPR18MB2408.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(4982022)(52105112)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:BYAPR18MB2408; BCL:0; PCL:0; RULEID:; SRVR:BYAPR18MB2408; 
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(53754006)(199004)(33716001)(99286004)(6862004)(316002)(86362001)(71200400001)(71190400001)(76176011)(966005)(14444005)(54906003)(7736002)(105586002)(6506007)(8936002)(81156014)(386003)(39060400002)(4326008)(33896004)(106356001)(52116002)(5660300001)(256004)(478600001)(8676002)(305945005)(6246003)(25786009)(102836004)(66066001)(26005)(6486002)(6116002)(6436002)(81166006)(14454004)(6200100001)(486006)(7406005)(229853002)(97736004)(68736007)(186003)(476003)(3846002)(33656002)(2906002)(446003)(7416002)(53936002)(6512007)(11346002)(6306002)(9686003)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR18MB2408;
 H:BYAPR18MB2888.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YqO+gW9ESF4sYtOMRRbiD6f/nhl5sLJPa/5R7JHGWJAb+GdMQn8XXg/LoJ+RLxYIMzr6O0hL6Yf/URoz3HB0LozQaG2aaPgZ0XgkJic7SpZ7eQwS9Z2jAzGrjDk51c611LGZ5H4tBR+Wb9XRDHqaGI6SIy+CHX2toIXEE3gM3d2qcKKnt0mcinn4hzwDMWi0e2AdfoUIDpT+EdSBaOyW5FaMZLoJ2q8nT83Cal+cN6xeyLv00Ym2c3Ai7kFDwoGWOIiHG+N0mP42GPLxfBxc8aOsj9hoC74ST0remDi/fhN8yKJubEcKupLTIKmvkh5g
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <36151C2011E12D4E9564E8B1F9DBC757@namprd18.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de2bc98-f36a-4f73-1158-08d674b7dd5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 15:50:37.0540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2408
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-07_07:, , signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_075119_192988_B7BCB5C8 
X-CRM114-Status: GOOD (  19.46  )
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
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Philipp
 Tomsich <philipp.tomsich@theobroma-systems.com>,
 Joseph Myers <joseph@codesourcery.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Steve Ellcey <sellcey@caviumnetworks.com>,
 "yury.norov@gmail.com" <yury.norov@gmail.com>,
 Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
 Andreas Schwab <schwab@suse.de>, Alexander
 Graf <agraf@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Bamvor Zhangjian <bamv2005@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
 Adam Borowski <kilobyte@angband.pl>,
 Manuel Montezelo <manuel.montezelo@gmail.com>,
 James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Pinski <pinskia@gmail.com>,
 Lin Yongting <linyongting@huawei.com>, Alexey Klimov <klimov.linux@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Florian
 Weimer <fweimer@redhat.com>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 Nathan_Lynch <Nathan_Lynch@mentor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 James Morse <james.morse@arm.com>,
 Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Christoph
 Muellner <christoph.muellner@theobroma-systems.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

On Wed, May 16, 2018 at 11:18:45AM +0300, Yury Norov wrote:
> This series enables AARCH64 with ILP32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> This series on github: 
> https://github.com/norov/linux/tree/ilp32-4.16
> Linaro toolchain:
> http://snapshots.linaro.org/components/toolchain/binaries/7.3-2018.04-rc1/aarch64-linux-gnu_ilp32/
> Debian repo:
> http://people.linaro.org/~wookey/ilp32/
> OpenSUSE repo:
> https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32
> 
> Changes:
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: https://lkml.org/lkml/2017/1/9/213
> v8: https://lkml.org/lkml/2017/6/19/624
> v9: - rebased on top of v4.16;
>     - signal subsystem reworked to avoid code duplication, as requested
>       by Dave Martin (patches 18 and 20);
>     - new files introduced in series use SPDX notation for license;
>     - linux-api and linux-arch CCed as the series changes kernel ABI;
>     - checkpatch and other minor fixes.
>     - Zhou Chengming's reported-by for patch 2 and signed-off-by for
>       patch 21 removed because his email became invalid. Zhou, please
>       share your new email.

This is 4.20-based version.
https://github.com/norov/linux/tree/ilp32-4.20

There's no important changes comparing to 4.19, but I would like to remind
that this series contains some generic arch patches that ACKed, but still
not upstreamed:
Yury Norov      asm-generic: Drop getrlimit and setrlimit syscalls from default list
Yury Norov      32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
Yury Norov      compat ABI: use non-compat openat and open_by_handle_at variants
James Morse     ptrace: Add compat PTRACE_{G,S}ETSIGMASK handlers
Dave Martin     arm64: signal: Make parse_user_sigframe() independent of rt_sigframe layout

Please also notice that my email address is changed, from now it's
ynorov@marvell.com

Yury

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
