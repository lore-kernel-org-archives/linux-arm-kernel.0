Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAD_ENC_HEADER,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99579C37124
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:13:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676DB217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GaQ4O/SG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mLVHU3wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676DB217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k5MNRhzX2ZE9A+yWOeGi6nTAHnCsL1kto5CyaLc8ooE=; b=GaQ4O/SG57iJxz
	QB/aiVdU6wB+6zNCrTKRGN0679oobgM2q2J+mzJMuBeCKQw+KlIe/kzbMjKufGl4PqpBRuNzGhqZb
	hoxVdKfbG6zY8m9MpAnk63g/AlkDBpl2XPfoOu1PA2ruSvkC9WbfukZ8ZTYu8aAStB+E0+FHHFoPb
	cWNy2BjlRAhFQApnffPcZx9EtRqII7WemJM4/rZAj1nwlK4BKBd4xuupVLFKNjuUjfFqYEOGXTPGI
	M+Z6Ux5KVXVkl47CWEqh4pZUTNz+9Sl72jSFe5GMJUx+k6lfJs+QFxetlOPwhTn6alrYefS45dGJu
	ycioOJpjYN65+riEKGrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glkdY-0007cV-GB; Tue, 22 Jan 2019 01:13:56 +0000
Received: from mail-by2nam01on061a.outbound.protection.outlook.com
 ([2a01:111:f400:fe42::61a]
 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glkdL-0007Rs-KR
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 01:13:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViLx5/KYrfMhvF5ovod79twx4wQR/DWSjVKJSEEU7rs=;
 b=mLVHU3wlKpIqTGgShUf1VVHuhQA+ckupxQ10zzh3shQchQGsWMTF7fVlU3qO7QE1TCxY4Wl0qac/GRrMb23qOcFDHDuoYA0ajdeWisOEDUGTlhq6sKbHHvWs4P5wYAJomQNxhx2eGkpKvTCRZ6XQ6hbcS7ihJHEbKyT457pGaJA=
Received: from MWHPR0201CA0094.namprd02.prod.outlook.com
 (2603:10b6:301:75::35) by BL0PR02MB4324.namprd02.prod.outlook.com
 (2603:10b6:208:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.29; Tue, 22 Jan
 2019 01:13:40 +0000
Received: from SN1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR0201CA0094.outlook.office365.com
 (2603:10b6:301:75::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.29 via Frontend
 Transport; Tue, 22 Jan 2019 01:13:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT041.mail.protection.outlook.com (10.152.72.217) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Tue, 22 Jan 2019 01:13:39 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <hyun.kwon@xilinx.com>)
 id 1glkdG-0008E4-My; Mon, 21 Jan 2019 17:13:38 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <hyun.kwon@xilinx.com>)
 id 1glkdB-0002Cu-Hx; Mon, 21 Jan 2019 17:13:33 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0M1DWbi005655; 
 Mon, 21 Jan 2019 17:13:32 -0800
Received: from [172.19.2.244] (helo=xsjhyunkubuntu)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <hyunk@smtp.xilinx.com>)
 id 1glkdA-0002CZ-NY; Mon, 21 Jan 2019 17:13:32 -0800
Received: by xsjhyunkubuntu (Postfix, from userid 13638)
 id 26B5D2C73A0; Mon, 21 Jan 2019 17:12:42 -0800 (PST)
From: Hyun Kwon <hyun.kwon@xilinx.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Michal Simek <michal.simek@xilinx.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] uio: Add the UIO driver for Xilinx AI Engine
Date: Mon, 21 Jan 2019 17:12:17 -0800
Message-ID: <1548119537-1788-2-git-send-email-hyun.kwon@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548119537-1788-1-git-send-email-hyun.kwon@xilinx.com>
References: <1548119537-1788-1-git-send-email-hyun.kwon@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(199004)(189003)(316002)(478600001)(6266002)(426003)(16586007)(186003)(42186006)(107886003)(486006)(126002)(50466002)(6666004)(336012)(356004)(47776003)(106002)(476003)(44832011)(4326008)(11346002)(446003)(103686004)(2616005)(110136005)(52956003)(106466001)(14444005)(2906002)(90966002)(48376002)(8676002)(81166006)(50226002)(305945005)(51416003)(8936002)(36756003)(26005)(63266004)(81156014)(2201001)(76176011)(107986001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR02MB4324; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
X-Microsoft-Exchange-Diagnostics: 1; SN1NAM02FT041;
 1:lqS9z51qv+UUOFF1w9cC/billkcA1P1NbeTFTmbZM651NE2gsj5wUBp+m8R8n/AezYEBwgsEBzo0ifWUez/hkQV8ZPIyFIX02xYYlrSGSK7MeGRBFSdl/NYCPfCPhPpeEqPQP79ibBMP4P8xWGUHsQ==
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8905efa8-7e4c-4eed-4721-08d68006d78c
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);
 SRVR:BL0PR02MB4324; 
X-Microsoft-Exchange-Diagnostics: 1; BL0PR02MB4324;
 3:p1mDPkBMg69WNmF4QylL6UqMadFIL5H3sRpcfQImvmpOhZaE3vlaaNB3dl0oscOpls7jDSxtMMDlrd6WALAtTxhULlfL2ZZswLrNKviJbk1t8k7MNeMTWzruh/YW7P5I52pj4biKuTlK86N2bJoruvul2v5apvY0KXdDkJOrQqlyWfsS8bXWxAmCOxljfCOX/Y0gCQ2Bz+/bRqDWt9cTtX8O4k27AnTOdlw70KUP+yaexssSEsWH/6PqvEjnVHORKUVy0iz+7wACvpnykbZtjEO05+5IZpZ0LIP1KGnuphOMSZbfqQeDfNQzDPwJhF6cDFRJtHihq7BQEol6Jk86hpUbuPzeNVR17uzW8KliLJknHWBoxpY39gP9MYoLqowe;
 25:sbhXqLbNPeswxNynpJWTRaMfkVK1RPnGcdLlpqI2X9XqBf3B2UB1vuVuPMpq3kBTJGygbOxWTnYTxNn1fdt9GFeCG3jFHGNxEKAsIqBYckYlDKFUUoN6ndd6ZjjYxgHFp8qdG5YkqFdKdtQRJLZLGzhgA8iAgIY8u7hYgop7DYCZWmLSRlEFtXtI/LPt9lJMi0r00wVmRTFPakyOV1JhLZb/t/r+6wLG3UJ1mu/t17aoCgu7aW84tGjh9oISsob/vd69D04zDPSn8Vw0TUAHNGEiP7gdLbBfqc8q+G9BRXE3zdfoSZusRAqvlCYRUYUntR0eYkZk160AEhWzkLpwzg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Exchange-Diagnostics: 1; BL0PR02MB4324;
 31:ic7vMfpTXpqBC5Z7cq9rIVLctOJMP5LjZRq87R1/YomuOANscZpn2Wpa4r/vwQydoF/TVJ10EV7IJg7kLtPKFgRSARtSCz4+Nu9TwbVcXXkC+AX0kx9zPB9DB53uk1pW76SBD8UF+TTBBwn2mIRsxaNVpl+FA9lSioLok6MKqVNoHCvSmCPkPS1nwwmsrw6LRGZLyQfGCBmq+Vgdwal1KCmD09QzoOqPGk/CfcUL0Mg=;
 20:atseji836JVdzdK0Yr0g4VkGRwM4BS3XSxEoC72sqli/zYCQvLCLHMOveZcUzL28W9P2MpZwrEJlTy3s2QKxGIlBJxj/uO9/g7XdaDQGz2IjMoRDo6gCCVlJv9BdV8/XCkzJ4VR0d5HhYzEgvF1mWhZC1ItHMlX9bLDm0o9S1OctLFimW2kXXkqJ+/j4vARHBU0VCYsvxgdMj3O/SQ9YeygKxe0GlBzSO2zo7aGrluPEuiMwXtvp21IBCpuk83IOMdN3opdZdojb2AVC9NUVRgrYav0pGnPB+tzdk7gWX7AL3vg77nooPzFv8r5lLZxdVoyLOoMl5i5zQVugb9yUL6yqjI8YnVGCDCWjrYh2DS8T3Lq5xHUCgqRTZUTiJg0JE17F2L/HyhFt+id/pSTfvnGVwteJ01sTSna4gu5J7jJzoAgn7EMZsINgIzSw8yujcbNpRATluS7Nz1ACo3AblSPI6Hd8cZQR95XahZ+HFV1Kfr11+d3N8doi7zzsWZyE
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4324575AD5B259D77F1CBD06D6980@BL0PR02MB4324.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1; BL0PR02MB4324;
 4:MmWKeIVKYi8st6cEbKMH+JC7gmL/N9BojhftfXmVwLcohdffHGJM/HeFmxfZdQZQcBnltcI6sacPVCMDvvv/4Kx5w5UUxDbfUr+DLx3oeH1DMe//WdKEhU50aDTUuuTPn78VpjS7ZeVcF6wBiz14bcPAWfMXoe365xLCBmWm3DxU979QFaT9WugAZhpdmzHIB2OWqxI823p7nT26j0aW1Zk19ttivJ8ItMXAiaXP1dGqMwuw515ES5X4diujr94crx2MKSgH+D8qOephfEe+M/S6DuaU9puBpW2N3iSr2g1Sv25fQfRRmPE7TfKmMsiP
X-Forefront-PRVS: 0925081676
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; BL0PR02MB4324;
 23:gsNZdvRwCKmvLF7IMrnmeI3U2zf31lOgOUXNKoyQy?=
 =?us-ascii?Q?QRqfyOr63bCmIu3HMpZAx2DdPb+bYV06GNPqXJWm3KyCbUBJHuGe6OFbxZSA?=
 =?us-ascii?Q?fvOExPCTWKHBFGFBYwWb69D22aitB1u7DfJ6ErPIvHVfMizDRy3keiuMIu0i?=
 =?us-ascii?Q?BLRTfmHALoYlf1E9lmmZTYuOk1BmxNC4ZCp6T7zBZsVrTij+MlvD7k6v7CJC?=
 =?us-ascii?Q?0hvVYRNtsHbBvZl0im0OZkItY0aRYjqFlzpLwAHPQ3fLGo4dmrk4FswQCiZ8?=
 =?us-ascii?Q?qtya8zEO5w4KyYdGr0uipeEj+NZzFF0sEfZvnp2i6PsbfWbMe1/27/zVzeou?=
 =?us-ascii?Q?HO1Ga64iVbG2AOC/aeqp9Dryxa585ntuusCKoh19Fv+SVSaCpAcd5PJxUbcj?=
 =?us-ascii?Q?cDC0tcv1q8YSONlhK6846LFNwJDG3tcFwuvvmCB9DQ3L/BOFGHHoHSO4FAwt?=
 =?us-ascii?Q?BYyrGEIXUwk0yJnOWv87iCKPI8MbH4O2B3mHSJliEZT6m+BEdVXtzERDfC7t?=
 =?us-ascii?Q?cq7bwCLOzQao/R51n7Nd8RdUm/Nrkx0avWibxDEQ+LVD0cC+lM9Ahi4javVZ?=
 =?us-ascii?Q?aTwMnQlUScYtEtMDro172A4VlfLHoQxKETg+OvjOSOO9omT/DHFZ9utZSU4X?=
 =?us-ascii?Q?e/iu/bNDMfdmA3+30Bux3wAS7YNCDN4z4CD9zPYrJWghKSHO8Bj10AkuVlpE?=
 =?us-ascii?Q?5yxUh1r43tsCclpsTpxwRIACk0EG8pHGhRWfO1+rseDcT3oDDEZtvGmc1HaD?=
 =?us-ascii?Q?UOB0webGGDnqPAlLgAVFi8IBIkAi1lS1/DELOW1J7416nABI5+z4hSO8Nwa/?=
 =?us-ascii?Q?sMZoWoRKUO3y/3h81jAQoofT+56kILses1jGCYZ3now/EdhZxXrQ9j2QV2qV?=
 =?us-ascii?Q?kXVFouFrZIwBhbGWDeJXIGv9fa8cubfxjkXy4iatJ/uylIRO+Wr08CweZ8uq?=
 =?us-ascii?Q?c+J+uLjOLiqDIwLfb9r09y59vdSeqeJhm8gQiABMIu5ILLbcVqMY13nJsWxX?=
 =?us-ascii?Q?PndZMMQ+IjDfGj7FXWNo0lFhaEkWPcEbLuTvj9XW5xuJOW+gmKer/tzlpWcJ?=
 =?us-ascii?Q?+YLSB7PRYX5Ag34zNJ1QUmR38cfodeVX+M5zmwLAAVpttcOjffntOdXLHWb2?=
 =?us-ascii?Q?RbjTRoi18Q=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0BM94U6axsJu6r18XWZtsqyy1zOqi/hWuiE6+Hoce3oBPCSiTQyifsLG3EI5dPbfnLpkvU7F7TN0is59pERXNWI5zg/3q09sblmY+IYbvnK3vJdtb0YuOjE5tAz7UoZEkMv7vEkotp/+lBkRPGiXr8EwMgu6UvHVtbonMUqAYjDGMq2KQ6qL6OzCNclIbOxuHeDUrGPVeQx6T6/+cnOUutycVotRQPezQR0iPmSI4Kg5XuwlZf7e8fxb3E4TlgPmDjfKg6+weJ7bw0uokPhxhDbCrTZPW3V1nJDhMOfJ2841V6BInGfZUAHGWO5CVrSvwcP13Qhcx8xTtONuNu+Uz53b/CTBl2PZQUEcqSGJFjsuWFczQdaNvP9JxjoIUA/DlefluUI9483pOcIowryr0jS0JaumTC1ZZx8ik80aqNg=
X-Microsoft-Exchange-Diagnostics: 1; BL0PR02MB4324;
 6:q6Ct+pM+lJlPTTzIkcZaV1ElXG7KT1OiI2AgtoNjiFtY4ZwkarV8LOkDqLMR6t8ZcTegbxcJiztI+Qiog1ES2KQXDuMqEBqC1qU6smDY4BcdhcsV5AjLMxsbk17GvQDTR3EU+WtnnTSDqqtnLduicBNe9ApQP71CGMeZtTY/ZNDbxawCmtaZu1SY/FEYxYUDP3I/NQCZDC/1YIDCuCESTKMVhnAUMSe1oks8RJAA3rY3d6M9585M4ZMW4w4npkqMNpFXlbjLiHmROxpgb1qGBhC08fmMTHZLNaZkUKiyI4DM7CB3cG1Nx0+nc/5it5vB+DCYR6wwDf5i1P8qX8qOvWV2pnpcRp8Gy497buA4POd+aaQ+Cgr7V8WoQknvcdyhPX5ffE23doO2/7lWa4kZ3TRjTxbKcwPOgaPF4dkRWNWLGW5Bu2NLRZLXIx41qNt/2p1GCeYkyOjVFulokSaSkA==;
 5:JUrZPmbdYVRCVfMQl9E8+kKFr0x57rpnHjfj+QWtJV9CqMfO7UVTay9/bszZ/Jcho89VFH0msodnt+4enp0i741fQuSzSqll0jD0XQrQ0TusO8DFeOCmaLche+aWvyuQp+iULY/9YalZsKTI2AS4ucFFa339fvxQfhCboAIlxGnuUJIQYOyAD6lawK4EpnJ0qFROUwt5554W2czTsaOHFw==;
 7:gOK0hywZCEjEuSFa2BvyivH4+6n0MpQVa2XE77ZwOVI4CrQm6hrZ7lLYfH09n6FSc34UeFPc5H1+D7zZ9Vro2A9ucRm5yHuyoWpEMsgKD1k/9sijQzf3JTv2QbNF/z/WQUBl4KlUDC2D5taIR9ROPw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2019 01:13:39.0832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8905efa8-7e4c-4eed-4721-08d68006d78c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_171343_829916_49B13536 
X-CRM114-Status: GOOD (  23.24  )
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
Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the UIO driver for Xilinx AI Engine. The driver is
more or less a simple wrapper that enables the UIO dmem genirq
with some required configurations, because the UIO dmem driver
is not probed through DT compatible string. This driver initializes
the UIO dmem by adding it as a child device.

While doing it, any resources in this driver DT node is mirroed to
the child node so that those resources can be accessed by UIO
if needed. As a part of it, the child device is set up with parent
node DMA configuration.

In addition, this driver specifies some information that the UIO dmem
driver expects, which includes,
     - uioinfo: version, name, irq type, mem offsets,,,
     - memory allocation information: size and number of chunks

Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
---
 MAINTAINERS                        |   1 +
 drivers/uio/Kconfig                |  10 +++
 drivers/uio/Makefile               |   1 +
 drivers/uio/uio_xilinx_ai_engine.c | 176 +++++++++++++++++++++++++++++++++++++
 4 files changed, 188 insertions(+)
 create mode 100644 drivers/uio/uio_xilinx_ai_engine.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d119d1d..bced6f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16044,6 +16044,7 @@ USERSPACE I/O (UIO) DRIVER FOR XILINX AI ENGINE
 M:	Hyun Kwon <hyun.kwon@xilinx.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
+F:	drivers/uio/uio_xilinx_ai_engine.c
 
 UTIL-LINUX PACKAGE
 M:	Karel Zak <kzak@redhat.com>
diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 7e8dc78..5a25241 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -164,4 +164,14 @@ config UIO_HV_GENERIC
 	  to network and storage devices from userspace.
 
 	  If you compile this as a module, it will be called uio_hv_generic.
+
+config UIO_XILINX_AI_ENGINE
+	tristate "Xilinx AI Engine driver"
+	select UIO_DMEM_GENIRQ
+	help
+	  The driver for Xilinx AI Engine that utilizes the uio_dmem_genirq.
+	  The userspace library will use this to interact with the AI Engine
+	  hardware, as well as for the memory allocation.
+	  Say 'y' only for platforms with the MathEngine IP.
+
 endif
diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
index c285dd2..26b2739 100644
--- a/drivers/uio/Makefile
+++ b/drivers/uio/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
 obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
 obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
 obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
+obj-$(CONFIG_UIO_XILINX_AI_ENGINE) += uio_xilinx_ai_engine.o
diff --git a/drivers/uio/uio_xilinx_ai_engine.c b/drivers/uio/uio_xilinx_ai_engine.c
new file mode 100644
index 0000000..65dc99c
--- /dev/null
+++ b/drivers/uio/uio_xilinx_ai_engine.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx UIO driver for AI Engine
+ *
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ * Author: Hyun Woo Kwon <hyun.kwon@xilinx.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_data/uio_dmem_genirq.h>
+#include <linux/platform_device.h>
+#include <linux/uio_driver.h>
+
+#define DRIVER_NAME "xilinx-aiengine"
+
+static uint xilinx_ai_engine_mem_cnt = 1;
+module_param_named(mem_cnt, xilinx_ai_engine_mem_cnt, uint, 0444);
+MODULE_PARM_DESC(mem_cnt, "Dynamic memory allocation count (default: 1)");
+
+static uint xilinx_ai_engine_mem_size = 32 * 1024 * 1024;
+module_param_named(mem_size, xilinx_ai_engine_mem_size, uint, 0444);
+MODULE_PARM_DESC(mem_size,
+		 "Dynamic memory allocation size in bytes (default: 32 MB)");
+
+static int xilinx_ai_engine_mem_index(struct uio_info *info,
+				      struct vm_area_struct *vma)
+{
+	if (vma->vm_pgoff < MAX_UIO_MAPS) {
+		if (info->mem[vma->vm_pgoff].size == 0)
+			return -1;
+		return (int)vma->vm_pgoff;
+	}
+	return -1;
+}
+
+static const struct vm_operations_struct xilinx_ai_engine_vm_ops = {
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+	.access = generic_access_phys,
+#endif
+};
+
+static int xilinx_ai_engine_mmap(struct uio_info *info,
+				 struct vm_area_struct *vma)
+{
+	int mi = xilinx_ai_engine_mem_index(info, vma);
+	struct uio_mem *mem;
+
+	if (mi < 0)
+		return -EINVAL;
+	mem = info->mem + mi;
+
+	if (mem->addr & ~PAGE_MASK)
+		return -ENODEV;
+	if (vma->vm_end - vma->vm_start > mem->size)
+		return -EINVAL;
+
+	vma->vm_ops = &xilinx_ai_engine_vm_ops;
+	/*
+	 * Make the dynamic memory mapping as write-combined. Only first one
+	 * will be the mmio region, which will be mapped as noncached.
+	 */
+	if (mi < 1)
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+
+	/*
+	 * We cannot use the vm_iomap_memory() helper here,
+	 * because vma->vm_pgoff is the map index we looked
+	 * up above in uio_find_mem_index(), rather than an
+	 * actual page offset into the mmap.
+	 *
+	 * So we just do the physical mmap without a page
+	 * offset.
+	 */
+	return remap_pfn_range(vma,
+			       vma->vm_start,
+			       mem->addr >> PAGE_SHIFT,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot);
+}
+
+static int xilinx_ai_engine_probe(struct platform_device *pdev)
+{
+	struct platform_device *uio;
+	struct uio_dmem_genirq_pdata *pdata;
+	unsigned int i;
+	int ret;
+
+	uio = platform_device_alloc(DRIVER_NAME, PLATFORM_DEVID_NONE);
+	if (!uio)
+		return -ENOMEM;
+	uio->driver_override = "uio_dmem_genirq";
+	uio->dev.parent = &pdev->dev;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	pdata->num_dynamic_regions = xilinx_ai_engine_mem_cnt;
+	pdata->dynamic_region_sizes = &xilinx_ai_engine_mem_size;
+	pdata->uioinfo.name = DRIVER_NAME;
+	pdata->uioinfo.version = "devicetree";
+	pdata->uioinfo.irq = UIO_IRQ_CUSTOM;
+	pdata->uioinfo.mmap = xilinx_ai_engine_mmap;
+	/* Set the offset value as it's map index for each memory */
+	for (i = 0; i < MAX_UIO_MAPS; i++)
+		pdata->uioinfo.mem[i].offs = i << PAGE_SHIFT;
+	ret = platform_device_add_data(uio, pdata, sizeof(*pdata));
+	if (ret)
+		goto err_out;
+
+	/* Mirror the parent device resource to uio device */
+	ret = platform_device_add_resources(uio, pdev->resource,
+					    pdev->num_resources);
+	if (ret)
+		goto err_out;
+
+	/* Configure the dma for uio device using the parent of_node */
+	uio->dev.bus = &platform_bus_type;
+	ret = of_dma_configure(&uio->dev, of_node_get(pdev->dev.of_node), true);
+	of_node_put(pdev->dev.of_node);
+	if (ret)
+		goto err_out;
+
+	ret = platform_device_add(uio);
+	if (ret)
+		goto err_out;
+	platform_set_drvdata(uio, pdata);
+
+	dev_info(&pdev->dev, "Xilinx AI Engine UIO driver probed");
+	return 0;
+
+err_out:
+	platform_device_put(pdev);
+	dev_err(&pdev->dev,
+		"failed to probe Xilinx AI Engine UIO driver");
+	return ret;
+}
+
+static int xilinx_ai_engine_remove(struct platform_device *pdev)
+{
+	struct platform_device *uio = platform_get_drvdata(pdev);
+
+	platform_device_unregister(uio);
+	of_node_put(pdev->dev.of_node);
+
+	return 0;
+}
+
+static const struct of_device_id xilinx_ai_engine_of_match[] = {
+	{ .compatible = "xlnx,ai_engine", },
+	{ .compatible = "xlnx,mathengine", },
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, xilinx_ai_engine_of_match);
+
+static struct platform_driver xilinx_ai_engine_driver = {
+	.probe			= xilinx_ai_engine_probe,
+	.remove			= xilinx_ai_engine_remove,
+	.driver			= {
+		.name		= DRIVER_NAME,
+		.of_match_table	= xilinx_ai_engine_of_match,
+	},
+};
+
+module_platform_driver(xilinx_ai_engine_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
