Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E90CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:58:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1E02087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lNzjlEra";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XChOxBX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1E02087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mCeJPtwX+jyIRH67d558DUi/kZLHBeXlFlJo1iiu6oY=; b=lNzjlEraFjze51
	DoZ365vicsxWtq8NvEaJptcP5pq9ZfgDLTOHwEfMOnJ1OPGHevXc6qauzNr6OeblqBFO25yUlJwVn
	h7nmc3m8cJChCP4AcozrqVdjfs9ui1SOY96ZGYbpzvi1q3LLSo+c/S5IiuQIyZnkJTMoFqPF68EaT
	fO1/8ooRRUSMkCaD+tAmGyUYXmSyhlXaeprvvECzDEDv482KAL9davcY4qXWCz83tu7jdrdHsME87
	TAmXgKChpWJ2k94cP0uX8mGGwW73yQzI7SzOmApmdPp5eIqJN/AwrytL/K6m/kQPqsqvfcoNYGSl7
	ExFmoeWV3LDIMWSdJY7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfXTf-0003HH-5F; Fri, 04 Jan 2019 21:58:03 +0000
Received: from mail-eopbgr710058.outbound.protection.outlook.com
 ([40.107.71.58] helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfXSa-0002Af-B9
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 21:56:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ+39P9fNqvk8Pg3n33r07LmjupXUEelXDlbhPq0O2s=;
 b=XChOxBX3S3cglBpvLAllNAh/KK5B4N+PHISJ06HsuaB6oCc/8L/lSHXKCh8ESYRErmzoUKlieldVLgwu26OxM6+8OTC2yM0+Z2Ie83zpWBX9QGy8bKVN1zVayEbGwr1FkH0cj4I+wybPyoS3zNAhiXZyOoRiUUE44TVrAaZkhgU=
Received: from BN6PR02CA0025.namprd02.prod.outlook.com (2603:10b6:404:5f::11)
 by DM2PR0201MB0736.namprd02.prod.outlook.com
 (2a01:111:e400:3c06::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.6; Fri, 4 Jan
 2019 21:56:54 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BN6PR02CA0025.outlook.office365.com
 (2603:10b6:404:5f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Fri, 4 Jan 2019 21:56:53 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Fri, 4 Jan 2019 21:56:50 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <jolly.shah@xilinx.com>)
 id 1gfXSS-0005Y3-GC; Fri, 04 Jan 2019 13:56:48 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <jolly.shah@xilinx.com>)
 id 1gfXSN-0005nC-CK; Fri, 04 Jan 2019 13:56:43 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x04LuW1p021614; 
 Fri, 4 Jan 2019 13:56:32 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <jollys@xilinx.com>)
 id 1gfXSC-0005iq-01; Fri, 04 Jan 2019 13:56:32 -0800
From: Jolly Shah <jolly.shah@xilinx.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>
Subject: [PATCH v2 0/4] dt-bindings: Firmware node binding for ZynqMP core
Date: Fri, 4 Jan 2019 13:56:18 -0800
Message-ID: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(396003)(39850400004)(376002)(136003)(346002)(2980300002)(199004)(189003)(106466001)(63266004)(107886003)(81166006)(5660300001)(486006)(8676002)(81156014)(44832011)(8936002)(2616005)(72206003)(9786002)(476003)(478600001)(336012)(126002)(36386004)(426003)(47776003)(77096007)(36756003)(186003)(6666004)(48376002)(50466002)(6346003)(51416003)(26005)(4326008)(305945005)(106002)(356004)(7696005)(110136005)(316002)(2906002)(54906003)(50226002)(16586007)(107986001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM2PR0201MB0736; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02FT063;
 1:iQL6bITUHlwJjKOgenGdm4uj7PYI0YkhJ+fc1yu2bpoV0tm9bYykIi43cpd570ABdlClrt8iaZy8ekUrOZRqiqAY4owAZPp/mV+uKIPko6eZaPG6ldpcy0I0JAR6uMF9
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50c6043b-1919-47c4-06ba-08d6728f8974
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);
 SRVR:DM2PR0201MB0736; 
X-Microsoft-Exchange-Diagnostics: 1; DM2PR0201MB0736;
 3:C8dBQst5I2suy/7ba1FpDnYo/fRcGfzLnH2VqgVJ4ISkaoDJt1wi9v/Hgu5oxk5HlbRD/IN8Btvgoipdl25zL1aEkbbbm9ewdmNIMWxDvHwS9KO/lfgl0+r5YLD7xw+rp7bAeyzTpNeGDGhqQ8vu/3vIZuJQ1DNu0A6iYRWwFBJR1ZBX7TXvaESDiodnSbxQh1QXuCs+EGZ84tK/rWS5q8fDpstyD8FwBpWj/8eC/0Wjkxo9X8gNtBbckSuawbkuD+VrMefvO1vcP/VNz35AvEpl5B3KhoalTTX0Fvu9E6yCzKGPtQV5uIV0fwb/GR6TPSO7w87UWUwV9v105Ao8ezh9GubjqAp206Of8laPtSx5Ft8mAy9ioBK37MYNqCwC;
 25:/C+AJLlr+PXszKwlKv3W5m3UEIL9+UxgRd03zyFXQDzIcX6Mzzf7KP7SvKGaaKWPIa0zmQJDpJexoc57V4F5CUZRlspZjT53jsiylo4lYQ95r4+7H9KdmEx+WlTBxmUYN1aIAYHdWexj1F7OESbnHBcUCxUkbanh5u1oxoiT38yxkAU0sCHDBmJqo4aonI7DKbD6iaXg/TbSyfP//gjbMmKpyylK9XTnCzihJbw826YA7E5jB5kteSnrQGSVXPwCDKuHa3InsX9Gult9UsyS4L659Uww2BxuX4n9uTH/HgANvqlRU0fBUGP0pIHrK+bcvpW6U78YTTQjQhTs6WYsyw==
X-MS-TrafficTypeDiagnostic: DM2PR0201MB0736:
X-Microsoft-Exchange-Diagnostics: 1; DM2PR0201MB0736;
 31:1rKuAHH41dPGHuo76h5F7evfhGfbZ473sW0a1I1kC8/HDDgAPS7Ix9Dchw5H/6vgy5rIIxefJEoEEGMsqYUSS/bUthujA16Ze7H6KqzBQRmeCD5bPgv90ifjcFuOj4Eso1VRVlGa9rrz2VQj4Y4GopCzJiO1QPz+Ik/CGaVLjT5bMOasCnDJ0scE31OFmcPxSsvWw6Fh11BKPJHP+1Wm8X5hgC08IjMjpZK72BZREMM=;
 20:onMYQBVSL4oqY+bYozUpTdK7zV9GJqb0/Tev1Apl9H1tbf9NqVXtcnu7YGRjNXJpyN6sZxeVeeePWhqbN31wTIDKRngAX+ehdmyfKEKDWfInRgpTKQBEckR41B8UZLrY57J6nkXyegV5E95dICzyBAmEVnK6XxKQ2lnHA/8saDB0LPea3+JpJaf4bTwfnOPOi02T5x4A+9p0ZAy/+C3OBTNelQF5C7qUyi/6ysY5hZtOUKA8f/rUbI9ZpwFpoIv7jh3ZUhZoZOsLaxxYn0elZrmX+n8l7dG+4Yonh8n2L7KQmHVfWwboHacJDrQga9e2hVq0S8PLok1M+H1PMFxGde5nAG93RAlGvA8yiX4DrsuZ8gnOftyZNLxBv7tNSe7ufW+sJz8f3blxy+oOivltksOt84eD7H5hqriyF2Tppyo7DtO5vsHLSFF798/IFORDyUVL6mbwh7kDelttPjiggBA87NNZeGD6JYCzFlqKhZWFikNT9JiLr9pCrrRni35i
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM2PR0201MB07362FD7C15C720E50222EB8B88E0@DM2PR0201MB0736.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93004095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:DM2PR0201MB0736; BCL:0; PCL:0; RULEID:; SRVR:DM2PR0201MB0736; 
X-Microsoft-Exchange-Diagnostics: 1; DM2PR0201MB0736;
 4:WSd0J6GMFX1m/AaB/oOrqsnO+755f8wy2Vwm0nI3g7yDpQHVjEox22Yt34Xcuqg4dI0EZQNHM+oQcVKdrmy7pszLitUJiulitiAdtad0sdWpORjfjTlwvuNnMO/Ct6h0KWT457mdybYc6rgD7NPYphSBvB8oTmsr4pgkBHs4VGuDqL1ai2hW1mj9ojzFdVg6Zo5NnLZY2S7QEnt/w8aWSPcZIOnkmxsh9L0HBl3zd/1a8zUBgh63Ses0uZ7Pvf93waQJDea113lgNvZDCb0DbDo9vUBnJrdBjrtWPW5+KOckDdpyjVvqjm3R9rw22QQ3
X-Forefront-PRVS: 0907F58A24
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DM2PR0201MB0736;
 23:SMuCNDXwDPTvX3vMQG581/pEGGhsdaN75QyLz7k?=
 =?us-ascii?Q?P2tardE1AIiQkTTZ8q98XPjZKeyLi81tjr2N/7P3qqORVm2j4VN0QjRCJnlV?=
 =?us-ascii?Q?OhtpUYPFBV81OYTUcKrMyXZ5itzmYFaEOprvvr/lWOzuQwT2Ts2DB2hVaQW2?=
 =?us-ascii?Q?EYTAlvsBsqLui02+d3aGHd4wbt1DAtlR4SXKoClwAoRyP3xTTwzepwNaLEf1?=
 =?us-ascii?Q?F69dEF70/MeyEHYd2MRG5Ocurtr7IndjSUPoHZHlLs8Yn+8LAV+xrWzAR+Eb?=
 =?us-ascii?Q?/mmjs8HP0yksg6+7oPzmDA5fA1cHZrn0Hy5ElDqGRSedxkqI35BDejyukhx9?=
 =?us-ascii?Q?gHH4PTzKxNKmca0baZUxqcFpMlMFqDDDoqlkw6jiOH2S75EHNFafkXnX2WAE?=
 =?us-ascii?Q?rC0d/Dj18zanQWnxdSPqpmu6agVeAQErqPmiuPKipMxXohr/7IzZtLifx238?=
 =?us-ascii?Q?BmvVc7T7t/DCqgl9E3xIBzWIVXjlmb9ps7A9tm0VGsojPQP2Ze/YzADYNXxI?=
 =?us-ascii?Q?9hbbXx5f5KuWg9LIzZTCCDehr5xxAPlBdM77oDGB4JVNWnqNk3o1AKCnKX0j?=
 =?us-ascii?Q?i4O8B5WXFDaU5YsmKSyKtoiewpWC2MRYDkWs6dXahWSwTuixltlvXfH1EQ5O?=
 =?us-ascii?Q?So9PQk7zNpZkrEttsduPaieXGioWaJF0Fpded7BqghqO81fY/xtlqNFLLy2D?=
 =?us-ascii?Q?LfvzVRn4tse22vt/uLmFKxusF+UccLaVwvbq08bUhAwarbThAjXkElJeGeOp?=
 =?us-ascii?Q?GhMoaTyXCjOnjmxBkv/h4acZWlsnh/aFYroBnhuom/3fLkgkqWYktQiq4zIT?=
 =?us-ascii?Q?rRXMk0WJddqI5G/Of/L3AwSmUMApsb95c8R4cStz0LKMRDXQYudhUZADJsOO?=
 =?us-ascii?Q?w9oKvn2wUDIapO1Bx273QK8VX4GtycfctlUuWnoYCnre0YdJuC37b6Sr7BKQ?=
 =?us-ascii?Q?vibIYcLNsFiGBXTuOtra0AHjrR6S1mNkbmoCWiPUNtJVwsqdxWm7r6rZ8U0K?=
 =?us-ascii?Q?rAYFRMDV2eFzzHIDt/wbMLaulovRiOC2IhaomnWdKT0Z8u08x694CVUfJBuF?=
 =?us-ascii?Q?Ge+l6sz3Ft2u/i3lclJFll9RhQ4JketvNyx0LjEf5Ex7KdxnnAA=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 665HctotLwZZeer14KEhvM2sjoCjz3UeTgqDJ+QpnmmVdtH7DTqw67jG+1EQ6qq81sg6Fk3XQDfWrSZl8O+JPkTHPPFjyM1xU3ttq+dXLepe7b23QHnxoUs29bkM7TZgkzqYdjO5oLZ8+WZUj75KVnRBQ/R5bEYxGGsjA88MlxkpwALc1DVvRr2w0hOYYyubg+cbynTQCC5ujab/Hx425HDVewnIvfJkagK+GFh+nTNlvi7n+ms3kRISVA2LbmHTgvMPqq2Xzl0q8+iLPaj/KXwaEd6PZWOowMaUpseVaA3AbvOB7McbPTBDn76YW50g
X-Microsoft-Exchange-Diagnostics: 1; DM2PR0201MB0736;
 6:crLDpho4ALctP0Zt2R1IWifR9K9020gRaChf3zLiyIZtXa5SHKDrg8UipI8BaM6nKUFZ8SwHLzRei/glFqLdZ/4mnre/okDTwUCtBLo+oOkQLX1XsTKcdPKq4DMjr6/5n7dwNCW1wsTIktGbWE6HYMN0IJFMC/U9QdGpWnucmiOgXGtd50x/FwycHdWyq08KLuRg1561GYJqz/ksSKSJqOH8bMC74SQ794K56FgD4R2J1eH1RRtt9zddRR8od1gsxzhQX0u/e9K8MLBFJIH234hFzXhUVbnXTMAZscHvSxvD2FR1/0PPzqQdkMv0HNzyqqqBgkH69+KjCOKJ1/9ma+/K1fNz3NJPv4huc7fJSwRjIkp0qA5bKmTr3NXJ0NThVfmVAW8rvkwNPycxC0Yyca97coX9n5DGch9RaYrDiUOyNXWTSubq/7tLd8mAHcvBjStBXOkrMWxLWywa+b9XWw==;
 5:OneRCqbeGUPcH9dcnXQDROh574Xi90paZ5fsjaOKfS3BqUGvX+BgPc3Q2PdEfIzHtoZUpXetsfzqAC6SGKCJskbTVlA9AaRG2cBhkfebu4uk1ekcP0fkmzmZ8hUzsSs1BvOXF4MS9gRoduZW50CGvpoaUnkdDq04VqJAFu/hlgxYpbWaPW/+zCbAiX/i458rOXwzU/tOeqoCHHCYPOk5JA==;
 7:XjW1Shqf5T5WUUYZpNAB1R15gKvhvkRZZt4cSyx061MEfkJxB1zT9eAq+MQHkGypecxJlMZbal2sF8ftPlt+HYjhoKXAre/oyjNz8V7SBKjSFqBEglzfgFNs15liWRAe4vseGksdPXKYQEXU6Lia+Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2019 21:56:50.3038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c6043b-1919-47c4-06ba-08d6728f8974
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0736
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_135656_474808_190D39DA 
X-CRM114-Status: UNSURE (   8.59  )
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
Cc: devicetree@vger.kernel.org, nava.manne@xilinx.com, michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org, Jolly Shah <jollys@xilinx.com>,
 rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Base firmware node and clock child node binding are part of mainline kernel. This patchset adds documentation to describe rest of the firmware child node bindings. 
Complete firmware DT node example is shown below for ease of understanding:

firmware {
	zynqmp_firmware: zynqmp-firmware {
		compatible = "xlnx,zynqmp-firmware";
		method = "smc";
		#power-domain-cells = <1>;
		#reset-cells = <1>;

		zynqmp_clk: clock-controller {
			#clock-cells = <1>;
			compatible = "xlnx,zynqmp-clk";
			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
		};

		zynqmp_power: zynqmp-power {
			compatible = "xlnx,zynqmp-power";
			interrupts = <0 35 4>;
		};
		
		pinctrl0: pinctrl@ff180000 {
			compatible = "xlnx,zynqmp-pinctrl";

			pinctrl_uart1_default: uart1-default {
				mux {
					groups = "uart0_4_grp";
					function = "uart0";
				};
	
				conf {
					groups = "uart0_4_grp";
					slew-rate = <SLEW_RATE_SLOW>;
					io-standard = <IO_STANDARD_LVCMOS18>;
				};
	
				conf-rx {
					pins = "MIO18";
					bias-high-impedance;
				};
	
				conf-tx {
					pins = "MIO19";
					bias-disable;
					schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
				};
			};
		};
	};
};
Nava kishore Manne (1):
  dt-bindings: reset: Add bindings for ZynqMP reset driver

Rajan Vaja (3):
  dt-bindings: power: Add ZynqMP power domain bindings
  dt-bindings: soc: Add ZynqMP PM bindings
  dt-bindings: pinctrl: Add ZynqMP pin controller bindings

 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.txt       | 275 +++++++++++++++++++++
 .../bindings/power/reset/xlnx,zynqmp-power.txt     |  25 ++
 .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 +++
 .../bindings/reset/xlnx,zynqmp-reset.txt           | 148 +++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 +++
 5 files changed, 521 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
