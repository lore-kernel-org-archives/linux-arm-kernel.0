Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:41:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18CFA21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GH2UkK3H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AzzShvdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CFA21850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BWrb9VI/cEfnh+50EsEPIX0rPRzRn4oSwKKLut72m7Y=; b=GH2UkK3HlUhMWE
	PtQgEzw9WiMlXaYZ1nA9f3ssmGAnscXJWiW6UJrMmVCuD4yAzCnybDLOb++ChIS+vpD4ACqjdm8wS
	TeLzRWmkwhht6XMK+BxITj1PBhQx5w4Nb40I2qf/4+ad/np/hKeYf8O3ea9oUQHbxWdLiamvcSKIt
	a2ZdU85YbxNZYSWdWY+4TdvNGGW4i4X1VYg/ogk5Yo7z4UzUYbqlV7lfkMehjB6T7noUiWACQps0E
	TrenfyZAZWPKtQD+wdH4JjrOtZ6iTidbEAqXlMSjTTW92xULMmkzKmXaikzz/TWx+UyIzEVuiqVn2
	h/6CVioofdClu0rC15gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYLg-0003fT-0J; Wed, 19 Dec 2018 09:41:04 +0000
Received: from mail-eopbgr800070.outbound.protection.outlook.com
 ([40.107.80.70] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYLb-0003du-S4
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 09:41:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9MWN+B3eq53XmrTultv+i0SH5bK8RWQaixp/m/PHFU=;
 b=AzzShvdTuz0tnG4RXKwnYswm+44b9ASNJMWngsXpnrho4rmCVAoDLnEHhk7dy5tWMfJh4c3L1QXeKdvbEg3y2mWp6amadQuXoawaOugOdzB1+5adwXRMZbYYJeudQEXYljCfdzFU/T2Tlk5iWtW9VZDbGn2jgvV/wLqfltdZ3uk=
Received: from MWHPR02CA0025.namprd02.prod.outlook.com (2603:10b6:301:60::14)
 by DM6PR02MB4332.namprd02.prod.outlook.com (2603:10b6:5:2a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1446.17; Wed, 19 Dec
 2018 09:40:46 +0000
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR02CA0025.outlook.office365.com
 (2603:10b6:301:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.17 via Frontend
 Transport; Wed, 19 Dec 2018 09:40:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT029.mail.protection.outlook.com (10.152.75.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Wed, 19 Dec 2018 09:40:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
 id 1gZYLI-0000UF-U8; Wed, 19 Dec 2018 01:40:40 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
 id 1gZYLD-0006nE-Pp; Wed, 19 Dec 2018 01:40:35 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBJ9eXWm003855; 
 Wed, 19 Dec 2018 01:40:33 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
 id 1gZYLA-0006jT-H9; Wed, 19 Dec 2018 01:40:33 -0800
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar
 <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Maruthi Srinivas
 Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <alsa-devel@alsa-project.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ASoC: xlnx: change license header format style
Date: Wed, 19 Dec 2018 15:10:40 +0530
Message-ID: <1545212440-109949-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(189003)(199004)(8936002)(47776003)(81156014)(81166006)(39060400002)(305945005)(8676002)(106466001)(6666004)(63266004)(356004)(36756003)(2616005)(478600001)(7416002)(50226002)(106002)(126002)(36386004)(16586007)(476003)(316002)(5660300001)(110136005)(426003)(336012)(9786002)(48376002)(50466002)(2906002)(26005)(7696005)(77096007)(51416003)(486006)(2201001)(186003)(107986001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB4332; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02FT029;
 1:6ZImL+LFjR9IGkpMx8EVTMQL7nPgajNzXwfyLlwbRNNIc0VmZr0cjxYo8lsNSnuHa215QJt6retZxC0OLsGJm5MQM++k26IWf/yGuhGgK5YfqJhvK5sKFfrsUiTtSlD4
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6187b7b-2337-435a-4ec7-08d665960ccb
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);
 SRVR:DM6PR02MB4332; 
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
 3:a1+MkxrygJliYxGHb8Pk6hylPMIgCTIZkyxFW+y2QqBJhjGTRMLjIJ40TUSKrXys71FcNXcG3tQfm8snJoiuG0dbP4Z2sZ9OlVIIynDdKkrH7BJ5j6p5i8I16dwLgYI7d4L1U6TnVoEV1xtWXLUKu6ivncTTsDONOW2Fygp65lwMcs6YlOi8dRQi2oW3er6DG9G4XxkbSH5Jz5RFqUk5f+CkG0FSWC6C8qxuY9ZuIkEofFLjZC4K5MHFw7xnRT6nR38//+Nl+owmok/kn+NMMhSfgDKm5TML7US8PWT9fKqi38USZWW/Fyp10bGl2UuhbZIz4EUYV/7G2s1TgtS/C81HrPQnKqa94TTFPbGTgIw=;
 25:1fLFPzr6lj/4Jg0gKYbf2yIpD+N1qzDrbU49lJZG45MtsKy97E6nAPGTePVXvwYEdRcqRpPM/PIhLoP+Jhxq/Unyb1KZPwiIrsmo2PNSNyiXNEWCvEKHpV5mVcM8uTP0XYFFVvZxZaPDX//3Mgl9wChvv6nv/S5prTO73MK+McLch7Tbi+DYqJg2smkQb7b1rXJCUuuupa6opFhgoWihKyPmi9w0J6f0wHFGQRrbmRqFI2TSLLhsq+B7EITIVibvKCO49+oZhH/7f/S+u+AiEp0nVXS4i5JbChJ75LaT1wZosS6D4nivnueBbvOIBs6BILZkppoh2Jx6W0XJsryweg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4332:
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
 31:oAkOzxNDRm/TTDFvI/BxXONaaN0rywyOYvaBRHP+29iucQWu20WeqUuJbGbU59nylrnivBfemQIdLz+thJtpWwlQHAQnWnKYmmP0WBQTJh4ZtCbmOhPjtQXH3xSc2gFGr8u1qJ0BB3bC6AUXjTeG8QMPX+JjBujyJpm4Qb+7H/EzQsoUuGUEtuy3QGOeahwlbK6zt6C+7LVs5C5FVyb0nohWeYpJNGbp2xdcrwRxP6o=;
 20:ZLKMgrWsdyUP6cgVdeWMfXpTrnWtAk2AqsR8Lns7E+4mjAoMhNaYynr3jhfpRez9+y6qzlQmrm53Ziey2KAskNakRS1hGK9pXrUa9RifLz2R+LzZ1hoRjke1qw5lQZsMEaWVOpGWcfBU/Gt5ywEsAkcT0t/c1eRovdSKx2eZFtV58VA8I+nxO6DQwlZIo8JfRDzJVLlBu9H18KNA6Kyh1JwV7MCGbaTfs3sNcPbgHhspRs7mz5fETFd/wcXpkukcFpd0V0wxHqsXNs3Srf9FCOd/jPCraFjd1LUcNDHPRh6EI2HmXcvRe8r6B+tm8TaBZOm9aam788LKR9qm78l/J7devfUvI62HzqSQTNIwDg6O7YieYDeOMK4JgEBbfgyT0A39r3Pae7ovdc1fhsMK9KJ+yswA3XBE+8aVQI0A9wfdxYQ+ioLY/qJffx71bBAkbDjodYz1w0PPZnTag7Nw75kATnoV5G8jeieEUv7dLhnyz9EvVpiNIqbbQnqSojOB
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB433215DC9B6EAD3B00396BD8BABE0@DM6PR02MB4332.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:DM6PR02MB4332; BCL:0; PCL:0; RULEID:; SRVR:DM6PR02MB4332; 
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
 4:D1aLtaIKqbRkEpPlxoJapVfwMLMYaYafWm38QIv7aGBCd2TcECOmiXy3lQqdtizHFn42O6rtfwaw9A7rxA7jHFt3IE6fe7Q4fgxN9rbtgNr/1WYwFfIn+OwX+AmeMHE4JO56M0zdGaoRCOxrGf40BdIKqUPHNN+HiWEHwLtCn31u5WYhLUfvL38/oavVmwDQcZq4qEOAmfYQNuB/P4Is2/PVvMGJSstvwpLmrFnowlAH0x6QiBk1H06PnVDOosRT7dLCIheas/q/1smAxfo4Qw==
X-Forefront-PRVS: 0891BC3F3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DM6PR02MB4332;
 23:ImRMxwrZGXQsuXkwIO3y2mbQ/Rr8/QHU/JSPcGaA/?=
 =?us-ascii?Q?E8DSQt1NT25UtPgQyheSnjVoIW+OcMQRedph9L0BIc2rUuuNpWCF55zMxzk4?=
 =?us-ascii?Q?qzsIolWf0GN4Gw9UI+uC4eE2vQ2DP1Ya0wzbgo1mxF+mb9/H5VevdF6ZMqs+?=
 =?us-ascii?Q?9z3Hh2Vns9FVuP7+8SUFRrYy7zRkRJyr+exs6ihSjfw3OHwHNCU+qFTfglk2?=
 =?us-ascii?Q?ljg2rijLFbaUkjPpD59mpttqr+tmMo38vkoK+hoRvobSkulUqsRa1q5KTlI+?=
 =?us-ascii?Q?v734JbXqjSJG7lw56tfx3UWHGPILGq7FYR5WIZK1h80WKSvmVosdYmLu+4iW?=
 =?us-ascii?Q?TlcPY0FQHBF2hg32FJvIheU6q663ut+jnK4b8/NTmHjeNPC5+iXHqCA/4eq+?=
 =?us-ascii?Q?++92cOVZfxehgGMpYlqSbAWVf0JTQq/e0mUsGx8cwltEccH1wITFsWhm+7vK?=
 =?us-ascii?Q?gzhLPAqNNXDMJB2GMgLfC8uI7ZT0UQCT8E67ooNbv0RJZduqCBkb7R8lFRzv?=
 =?us-ascii?Q?1GRxWX5SmiC+we9kjHHYdzuNk/HU6oENUQlQOgtg2SNozd5IO/vKvKLwbiti?=
 =?us-ascii?Q?YE3/IVZdmSnQBX74hoN3PisENK5wZEPHav4pYTiAvW85HHEsvGj0G1/vTXIO?=
 =?us-ascii?Q?n/Y8CIz/D4G437vDV4F0+Ux1Jr9oFbSZ3H3iHlGq7T14/fYwoa1ZzHREDEEz?=
 =?us-ascii?Q?DBcXeJsolEy1smccB0JZOHiFcVDZor78xMqM2cvIrsIbfR/no1uqAktsprM1?=
 =?us-ascii?Q?bnTCelRhpX/o8f3GCJMMoYyovWfEZFfcAlr02W94DacgJrk77vc+wRq5Au3W?=
 =?us-ascii?Q?BwXnkk1X2wk6AfUddUYau8zI3KXtUfIrtSV6guEGioSC6HWDeY8oSieOTrrB?=
 =?us-ascii?Q?GFy/CMkGoP5aq5FNYAGgtBJEyVdjMjRgbY3LVnKa9V3dyfjq1WWl5Gf2q1hu?=
 =?us-ascii?Q?jxtIASvdbyzhddIG1JNKQSDH5CYXLtnu03Lx9wHuU7E0n5518OPQxpKKynqw?=
 =?us-ascii?Q?i9chunn9tgBvSEMUxC9gZeqye/VqTyZHMqwZD3U5/jZFpHd/XAeWG7E1sapQ?=
 =?us-ascii?Q?TUvEBdgqLDKwKmF9wOJvZ5obUnW?=
X-Microsoft-Antispam-Message-Info: 2tNUXrG04TaEWYlfjPvg+YgFkCr2DGL2Eqci28GdzvG9xXN78wzcL1ADr62owGnFnG3S+vYXHHdiKr3WldHue7DpiDxTWZJr7EImapplXovRLzqAQkAf6pr/08wMwJMDGcBBYZWAnaZR0sXjP1GZgV5PwEw1cATHRw488hbonUSe8sL/UaltJHL6tERYOBTaa85xmfYqBcq4+1BomaXpMRS2rHVSouBbJg9Jv42eMcTDpEc6KhNWWtMDOmbfO10YPmSlicPxbgma+ACKaFVg0E2CC2o3BX+ZMHbZGhHlZP6dP9/oh794SX99/p97/jFL
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
 6:aAZ8RjfkkKWc3B3B78vDVezdGNzGUYsaV7iy0NA3lzYoTZMmKEul9ZmRmdfKFEMJ1gglqI+d/7PdkIAp81Miwi7Fwsrqgr0GB94EBsJibvsv4YOL1IWljHcCvPdBH/ej5ooZpPEy9DI1awFs19UWKERvV6cCCL4QKFXoz3M0NLwXgR1Uns/RjDfRr8yLWInz1ZWFlse12p7hBb74fbTch3yuevUZYj9ysDOcAzW3HlYD/PyUa6ngOlaFsqNYxZ/j/jXYwtRXHHDgRqYU0MAEeHilTfaM6iDBMEnmJLm3FaJ4Ew8f332idbd0cECn/MfI9zMt+3z+0V0doz4YAtSB3FnNryxZSA3Parb8LzdyY9iAaaqhPctIZm+eeBMov3+O2MJsPJw5Oh0sA++aXqy54tt5NSAKrn9F+4j+BYUREbUQqzameCXeAcbcP2cBU+yG+U+FdFcASLXqckd4iaiCpw==;
 5:ROWvXJv03j0GY2TxtnCv/CVGpNL8Ag4nP7kwhAyBX41U/POBik/XcAnzWjF8HXj6z/yd8wSe1AJrIy/o25FXtQQ7tbI7vdNCtC5HbmMKnP9jxROthAlO+9Pl18f5hQ1LEUNmqu0skNDHNm8b06o6ViQ3mr6pcZwK0Kk0BvDvpkQ=;
 7:CBQN2sMZaE6ai6qAvL4j9LZjLtu1I3lVYfwGB1bTCALd0+gr7/vGpn3OvPBhktTTJs0wWHebTbbnfZhrUAcFJEcf7kY31+U2YDqVFPvLhse+zsJajpx4FpiNpF2Gd0lZpbh8m7bRw/EVzA7HJ/4fqQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2018 09:40:41.6935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6187b7b-2337-435a-4ec7-08d665960ccb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4332
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_014059_927440_235AB4D3 
X-CRM114-Status: UNSURE (   8.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Changed License header from C to C++ style comment block.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/xilinx/xlnx_i2s.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/xilinx/xlnx_i2s.c b/sound/soc/xilinx/xlnx_i2s.c
index d4ae9ef..8b35316 100644
--- a/sound/soc/xilinx/xlnx_i2s.c
+++ b/sound/soc/xilinx/xlnx_i2s.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Xilinx ASoC I2S audio support
- *
- * Copyright (C) 2018 Xilinx, Inc.
- *
- * Author: Praveen Vuppala <praveenv@xilinx.com>
- * Author: Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>
- */
+//
+// Xilinx ASoC I2S audio support
+//
+// Copyright (C) 2018 Xilinx, Inc.
+//
+// Author: Praveen Vuppala <praveenv@xilinx.com>
+// Author: Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>
 
 #include <linux/io.h>
 #include <linux/module.h>
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
