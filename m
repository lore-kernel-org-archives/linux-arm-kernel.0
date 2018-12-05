Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEF7C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:49:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1E92133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bL4GkR33";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="2qszNoVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1E92133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kbOgJiePm1eVtd+7ZFXeE2xBCP3AAONrISur9u3h+n8=; b=bL4GkR33oFbr6q
	Tfh6R4PJqC5oK6X/vtHsvm+m2VoerpMXnEIfN11mXa+Klic1MbmR3JiET9dWYOJpEkETFj2ixSPw9
	y3XCIvYWXEr0hgFDBGfn+TfxuJv+pW7Mhz5slO0SgSun29F15fnGbP+9w4CzkABUXts+eNInjAaiU
	pQTBbile5wpb4g/83197v2Qc97W7R58HUE1fz8K9NAqnYBJ9TlWV/wujPxNQtuz8vipUJVaouf19P
	+JNY3/lB9lzMgqfzHHQVuBHj8XcuoG9GJ/LjZPBWN0/kNQjW6P9uW/rATZ3hQYFliJDt9G+P9gxEn
	UP+1sWOxyAijQZsljH/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUTnv-0004MS-AS; Wed, 05 Dec 2018 09:49:15 +0000
Received: from mail-eopbgr810088.outbound.protection.outlook.com
 ([40.107.81.88] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUTno-00047W-FY
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:49:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI7QuX51NDvX2dWyH/+XeF1MSvzHDi5vmG7JpfXRuMI=;
 b=2qszNoVINi2BaUiebz7Wf8j88ep9Q4MT0q+Ly6/1WOHN6tBsh+lETcvGOP19wz36R0M70UELl2q+ogyCKeZjoaq1dm50vWpD9XVLnpWIwCqExu+4PXF+11CqcMWNtrrj3N3nLuP2RWr0udRLYu4obF6+Qkz0582yQ7cl28YsfXA=
Received: from SN4PR0201CA0072.namprd02.prod.outlook.com
 (2603:10b6:803:20::34) by BL0PR02MB4323.namprd02.prod.outlook.com
 (2603:10b6:208:40::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.22; Wed, 5 Dec
 2018 09:48:51 +0000
Received: from SN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by SN4PR0201CA0072.outlook.office365.com
 (2603:10b6:803:20::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1382.22 via Frontend
 Transport; Wed, 5 Dec 2018 09:48:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; socionext.com; dkim=none (message not signed)
 header.d=none;socionext.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT010.mail.protection.outlook.com (10.152.72.86) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.17
 via Frontend Transport; Wed, 5 Dec 2018 09:48:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1gUTnN-0004j9-8I; Wed, 05 Dec 2018 01:48:41 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1gUTnI-0004gG-4U; Wed, 05 Dec 2018 01:48:36 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB59mQJe000437; 
 Wed, 5 Dec 2018 01:48:26 -0800
Received: from [172.30.17.111] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <michals@xilinx.com>)
 id 1gUTn7-0004di-P0; Wed, 05 Dec 2018 01:48:25 -0800
Subject: Re: Moving ARM dts files
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring
 <robh@kernel.org>
References: <20181204183649.GA5716@bogus>
 <CAK7LNAQ-O0Xnkb3egp-B8+0hFaeBM_pzn0f0XQJ3+FLgBwNCaQ@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <f6c266ad-6279-a8cd-0d77-df5a0f834038@xilinx.com>
Date: Wed, 5 Dec 2018 10:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ-O0Xnkb3egp-B8+0hFaeBM_pzn0f0XQJ3+FLgBwNCaQ@mail.gmail.com>
Content-Language: en-US
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(199004)(189003)(65806001)(31696002)(229853002)(6246003)(63266004)(65956001)(2906002)(47776003)(50466002)(446003)(11346002)(426003)(39060400002)(186003)(107886003)(31686004)(476003)(77096007)(26005)(2616005)(44832011)(486006)(305945005)(7416002)(126002)(14444005)(106002)(5660300001)(336012)(478600001)(36756003)(36386004)(53546011)(65826007)(356004)(316002)(106466001)(76176011)(54906003)(110136005)(23676004)(2486003)(58126008)(8936002)(81156014)(64126003)(6666004)(81166006)(4326008)(230700001)(9786002)(8676002)(3480700005)(107986001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR02MB4323; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
X-Microsoft-Exchange-Diagnostics: 1; SN1NAM02FT010;
 1:XirKi8u1DklIfrnxYRkkUMnxZeyBnJcNx1Ke6k2iQ6Gtde+yfpxebhRuEezL5JvS6Z0L3pzDM+xci4+6XimyXXndH89WVptaR1uWNJs22UEAEqMOcoLrOZBEEFnrTw/f
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 294f1ec3-37c5-4eef-abee-08d65a96dc53
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);
 SRVR:BL0PR02MB4323; 
X-Microsoft-Exchange-Diagnostics: 1; BL0PR02MB4323;
 3:mOFpk2fWgvCnooLXlVcdDZGx+cF7q/+cVFhbZyv1484PCeNxZmHmwRMfIWLizpnGFscteVYNEDC6hf2s5vCHt0XB3k3uonKYDLk1lJcVtvt7VHjE4qxtV1kXxbafibBhwJlOU5f9cAethEo6CCZX8gQ9eGp6tD1ENXJN6cK0LyVj0TUofibQEyfRl+JqpUvR2APTLidheUk4dcPfwexeJ1lA7j5JlDcOvZk7oIynrBcYMW6+61rWNXHcde3CKsom8m+5wvY8Vk/qLJK1HWg84e6AJi6YeDkT4vET3J4KQDurVoJ1lmBLn88l1bViwWNwyN92wL4EHDAHqfp5qHmfVY6CxibqZyzdDdh5ancFPQE=;
 25:aH9fcsghWTeFB0uTYiE8G6YH7+5WhO9K3Si4/MyURAjlXY4znBcfIr9N1EEL6JKpUuHrQIOcDKfwVRSJdmOJYLzD8LHK53+JP+jAZy1ugdvnnBZGIiTFTgmrZL2Td4mcQADPaceNYmGt+Zqfx3k3EwLxCxH9dGO/U7cX+UcL7LNrAdUMthaJpOSbCSHFOR/qjgG/Yo7ZiITDIK/ZsFUxO8A3pHog+oDn/cpTSJ8hSAf7BUEVySMjEbDdjvYvLrEqene7hdJPX2ULFHEk7BT8W5uG3CmcahNv8HVgHhvhTBN4Pww0vZ9XtxhopwznAzXOAIkFWquxu2yDpoqjJuruXA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4323:
X-Microsoft-Exchange-Diagnostics: 1; BL0PR02MB4323;
 31:2m2rwEiyKc9NEyYkNQp0bpsVpdBcX6UVpxEQdgGHheXSayxLn9TPLz09IOdqw0tc7mr+bR/OKXLsI2m1h/6F6KdoeNnMQjZAGBKENcHej0dIN0qriPqR/au8KqVfgozp+XjOVpoGOpxyYnwkM4VOMo+BHrH1fUnssIDbOUFFIr5bzB2C8JjGbsoROHoY0salRNaWFLyhcdK2ewQzHOAyeiXwLBzEvcVytzLu5+bfeRE=;
 20:fnLatoDbchyU2yxdPHfHuLDFzoQmIXCkoYzm//eSupGYI6vkgT/Iiy1JgbEpWpnwfyESzEQytr6FFwFyKieOJjj2IGND8PxbfyiFeUgQvIsILTzbUWM91hSvr2gW07U7VGnBW8GitGcfk83Mj2Jc2GDwmAu7l0BkJNBgdEkYabqSbXp69OGOT8rBI6D5M7+xuY7KDTw4qN/WiRRKxVOBmmqScooM0cInFtPl7Te+CWzx8UXK+bUYUK1Qg/6tvVQf9fVqJxtoCSZHh8IaIycPqrzEcWdXwMvNof8nPt6PWoU96S5FltfBKMlrMTXZjjwLw07vbXoDMENQYikVNB4GAiF53+vjeb3naQn8sEeZ5a8M/GnJBq8JRyeN5V/vlXVXlyhBeco4pEL4uq3nKZvzNF1DWRdptGfipSl6OvMfCgUPz7dcB2uRrTIfolnGwrL8ODf3lZRgUZYIUHuX1dv3LtlHrS1abwRzGk7i/CcjS2TF8a1TOCnHenkdjVKrdyyR
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB43235CA4A93676D403B6A8B5C6A80@BL0PR02MB4323.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93004095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:BL0PR02MB4323; BCL:0; PCL:0; RULEID:; SRVR:BL0PR02MB4323; 
X-Microsoft-Exchange-Diagnostics: 1; BL0PR02MB4323;
 4:JdmB0c6XFPUYIVEtE3bURA5LyOAFCLueo0n2LGUgXBmeIQWcTN0VHf+0I8BVL36SixyR/gHLUU7rmM2pMOE+PgV0JGwdjNit48DzuipDBBb0KDlAMztnP61jLcePHgVdY2teR69HSprEfgH5wI3yAhkyiNWcLh2r3yzdmDVM6SUALEzzd7KtCQbgGiNnhjfdf/EWKB6CF83fCkpo4JnIp4yE40adVRFDNyrGu24fvqsL6Vc/A8kJcIPD0+dpcNGCU1kCf1gBGeCKmYQc9GpG1g==
X-Forefront-PRVS: 08770259B4
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0MzIzOzIzOkxnZmZib0ZQcTdOQi9mYnduQmZ3NzIxTXF5?=
 =?utf-8?B?VXNlbHA1SEMxRkVBcUhXRFJqL3JmZERlc1ZTdmdsdDdwWW9BSVdjT1dsQTVm?=
 =?utf-8?B?YVZVeDBuQmJ6MjRBSmVGQ3p2bVZiWkxpZk1qN1NZK25mNVAxb0NOMnpRMmpL?=
 =?utf-8?B?UG9BQWtxd2JMV1hKZ3RxOEhHcVZyc2w4cktmZXZyYXUyUkxXeEVGOVQvL1Fa?=
 =?utf-8?B?L3VueE9YQ0c3TEtGTlk5dDZYSHZoZ2RCK0gvSXJHQ3ViNnZZeVRqTkYrSnlZ?=
 =?utf-8?B?alNLblFqOXNiZ0ZEUjdpck0razF6dXZSUWtzbS9ZM1FvdVJMNUpDVEo2eFl6?=
 =?utf-8?B?N2Q4bHNMcUc3VFhEeGhKR2VDWjZtNC9jY2R4SHREMUZuam9XbkxucWl0aVc0?=
 =?utf-8?B?Z0VYbXZQQXgrYTEyanY1ZDBSUWtyTHc2Y2x1ZnkwQzBjN0JkUVhxTzRkWTRZ?=
 =?utf-8?B?TmNDa2JLbnU5Zjgrak0xMnNoOG5TRWZCVmVheUlZb0dXSGlDUjdYekV3emlM?=
 =?utf-8?B?UXNaemkrWDlBTTd5TTU5dnRjNW1MSmlQS1F2akw3S3cxaWsweEtRSjFhUzJQ?=
 =?utf-8?B?d1BDUDFNZ3ZKb1N1dU5wb0lTZVdmVzZOekdsRUdYK0xvdU1NSlREWTZ3RDNw?=
 =?utf-8?B?WXIwcW1IeWtPY2t6akRmSHJKSXZVMnpIbHZySW9JWFhPQlF2WEptckZOWjFr?=
 =?utf-8?B?V3FGNk9kUkJ6UVNqMkgzQ0RJT280YXpkMmZlUjRYaXVJYUtQR0hZTXpBVExK?=
 =?utf-8?B?WWNTeFlsUjB3OXMrMlVyYUVpQmM2aTBHcFlRVVJKb2tZNjczR2pPMDlSdU5Y?=
 =?utf-8?B?aW5CYnZVQVhORFZvcC8xS09MWElGZjdBL3ZGNU1wcTJibXkvVzdrM24vb001?=
 =?utf-8?B?WXlueDRGZXBKTE4wYXhKZGZ2VEZjNW1Bb2llVENValEybDV0Y1FTUVNXYnRn?=
 =?utf-8?B?ZmpJWUk2d1FtbWY1TWZUMmxUUHo1L01LM3FoNW1RYWsvdjRpc1VpUEx2a3VO?=
 =?utf-8?B?WGFxQytrZ2tCTXBsbTNGTUtTenhwUFdPMHdjQVVoSEF4c25YcnhaSHU0eVhY?=
 =?utf-8?B?VWRBNDBsUUhKTktONERLQTRoZEI0SHU3NHdZeDdJV1BkL01RVnFjNEFXUkla?=
 =?utf-8?B?SmJYUldJYlcxaGtmdXJucCtFNWxxRENKM1l5Z3g1RVdpWU9NNjRmOW81VFlZ?=
 =?utf-8?B?RGJMdUNnejIzWDNKbjl0SThsUm5qdVNFT2dGa3RRQ0ZDRGpyUTBYendoUW0w?=
 =?utf-8?B?RnVhd1I1SHBsaFpydUYrMHZGaWsramdVTWgvOWlBaUcwQVJBck01QzBaayti?=
 =?utf-8?B?SlhpSkpzaHU4NmhZUHJJckNNM0FvVlpna2MyRldHTWs0WnNNN2NLRGxORHM0?=
 =?utf-8?B?V3hOb281SW14QUczL3pSVTFoSUdIdWZnTEV2UzNwYVBUVjVmVm1YNkhhc25r?=
 =?utf-8?B?T3lMdVcxeDR5cHlwN3pXNkFBOXY3UEVublUxTnIzM0wxZDlJQ2kvQnF1aVZm?=
 =?utf-8?B?cXlaSy9NaVR2dHhpd3dwYUNiNkVBUXFXdXE1ZWNWY2VFRndrS0I5SkhtVTdm?=
 =?utf-8?B?ZVZ4SkJOdmFXdExLT2RGUkFaVFRob2lhTW1acFQ1aDA3L1luamdDdXc5M3Br?=
 =?utf-8?B?bzBOWkNuUDRoSlJ6NzJVRVpzUUVhaGRCM1VIMXN2Ym1zeUpzUEtTV01DTXdB?=
 =?utf-8?B?cXVoWi9MTFNuUDhaaFVadElVNHhVZnlyeWg2L0pBM0c3b0Y2VFczTUg0ZHAr?=
 =?utf-8?B?cVFadnBESzk5eUsvY3NtMGUzWXBmdGpYdzdhMzlGTUZ0bTdSZFhsclFyVEl5?=
 =?utf-8?B?SWFQZ01DZlVBbmppdVJZUVpkSHEyNXo4VG9DMXdWaFU4bEltL0NwcDRGQ1NH?=
 =?utf-8?Q?CKq6BmHx7JQ=3D?=
X-Microsoft-Antispam-Message-Info: K4CrWWNUcLwS0srFr1+BEwZTRpxqR6KAJFoy6n0KJBkh8ukK/s+uAIluE4O+Qri+onXKzmKXi6augEPaFXAVv9J4hZkjTbXoo7eS4TtomyThK3eqfi1rKYemKukoFjv/75gL1Yo7ggtfNAhGdZIdjvpXM4a08Yv05KkLE496v5Xbav+CCFbw5072m8gcZVkbN8vI87KGero85MtSmIQz6Aj7mFrurloPfHch48e+syCkaHOAaLrZC5TryjF1SQh5ZoOA664ucfqGqBODE0joDdzKea9k+aiZTtXNhWRZK9ugIrk8Pt/qEaGWDO3v7KnQwIJq2DKRWwSARAGJkZ0vmCPpec//fKJcbeD0jdsKpQc=
X-Microsoft-Exchange-Diagnostics: 1; BL0PR02MB4323;
 6:q1DQS496Jd+/ThC5ZfbSPqQIQs7WsJjlzh3d94LiLwrTUzJygMNZR2eAqI+FHtxX7LMS+j7lgQH3bkZW3YNsWKFZApBS/lb084FfSO/VmERofXWn3RF5mE0Ah61usQM79bmHv76+1dVpa+/3vrXi6SJ8qSEA9AbiekLBTBs+9Q/uvovJctHKDOiY12zLdwZqOgJ3v2JnuUc8SpOuBWhQsYhW24XmNvVm0H5BrkIZF2jePcOG51prC0Zf/O1GFaYu1zdxDz9nePtO7Fdp0nL+Lw/wiRL/XargGd98sCLy12CRWAnKgKE7kJAIqSZ/E5pOAl/JOSW5lg7Ql2DuhlmmeG/gTgPXo92smWadZGnPuabBzd9Ii5urCdV2fYlIKsW+VJ2oWDa1spmmSia/tuMkm03K4hAyKZKB0Qe2702nZq1eRsze4sr7Rk/dGr/miwraopQ/zQifMeF4eirzDt8Q5Q==;
 5:uXGwopuUCMIXb1PzoYOon2yNzrDvQVt9JeSZEl6DPy5p1qhSl1Ive0Utj23LJgKoJF1FqTcBd/lH//d9xSluCFM7EKQgrNJ1Q9hzb6Q055WvfBvaJSzLhW8zjIqmAAQaCbKQRkZn1G8Oz5iKUoiw8VTwBjbI1m3T/3yAEJtFVn4=;
 7:LkJglZlht/VUb5/NvoDyWOxuHrwcTo+ph+pze1b5e/QOPoKlRy507W6x4xtoOH0w9zzeYPYC+Pl6tPMwiHoX20jL2RSOpYYN4zoV70doeQjbV1JDcnyvGoaiiIH55uFm2HR5Jqhof1h0D6KIoWCyBA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2018 09:48:42.0222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294f1ec3-37c5-4eef-abee-08d65a96dc53
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4323
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_014909_386566_143EE9FB 
X-CRM114-Status: GOOD (  19.05  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 gregory.clement@bootlin.com, Michal Simek <michal.simek@xilinx.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, arm-soc <arm@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andy Gross <andy.gross@linaro.org>,
 DTML <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05. 12. 18 5:18, Masahiro Yamada wrote:
> On Wed, Dec 5, 2018 at 3:37 AM Rob Herring <robh@kernel.org> wrote:
>>
>> Olof, Arnd,
>>
>> I've put together a script to move the dts files and update the
>> makefiles. It doesn't handle files not following a common prefix which
>> isn't many and some includes within the dts files will need some fixups
>> by hand.
>>
>> MAINTAINERS will also need updating.
>>
>> A few questions:
>>
>> Do we want to move absolutely everything to subdirs? There's quite a
>> few platforms with only 1-2 platforms. I haven't added these to the
>> list yet, but can.
>>
>> Do any vendors need another level of directories? davinci, omap, nspire,
>> etc. for TI for example.
>>
>> What to do with armv7m.dtsi? I guess it should remain and we just fixup
>> the include. There may be a few other cross vendor things.
>>
>>
>> Sub-arch maintainers,
>> 'vendor_map' below is the mapping of file prefix to new subdirectory
>> (the SoC vendor prefix). Please comment if there are any issues.
>>
>> Rob
>>
>> 8<-----------------------------------------------------------
>> #!/usr/bin/env python3
>>
>> import os
>> import re
>> from git import Git
>> import glob
>>
>> vendor_map = {
>>     'imx': 'fsl',
>>     'ls': 'fsl',
>>     'vf': 'fsl',
>>     'qcom': 'qcom',
>>     'am3' : 'ti',
>>     'am4' : 'ti',
>>     'am5' : 'ti',
>>     'da' : 'ti',
>>     'dm' : 'ti',
>>     'dra' : 'ti',
>>     'keystone' : 'ti',
>>     'omap' : 'ti',
>>     'nspire' : 'ti',
>>     'armada' : 'marvell',
>>     'berlin' : 'marvell',
>>     'dove' : 'marvell',
>>     'kirkwood' : 'marvell',
>>     'orion' : 'marvell',
>>     'pxa' : 'marvell',
>>     'mvebu' : 'marvell',
>>     'mmp2' : 'marvell',
>>     'arm-' : 'arm',
>>     'integ' : 'arm',
>>     've' : 'arm',
>>     'aspeed' : 'aspeed',
>>     'at91' : 'atmel',
>>     'sama' : 'atmel',
>>     'bcm' : 'brcm',
>>     'exynos' : 'samsung',
>>     's3c' : 'samsung',
>>     's5p' : 'samsung',
>>     'gemini' : 'cortina',
>>     'hi3' : 'hisilicon',
>>     'hip' : 'hisilicon',
>>     'hisi' : 'hisilicon',
>>     'mt' : 'mediatek',
>>     'meson' : 'amlogic',
>>     'owl' : 'actions',
>>     'r7' : 'renesas',
>>     'r8' : 'renesas',
>>     'r9' : 'renesas',
>>     'rk' : 'rockchip',
>>     'socfpga' : 'altera',
>>     'st' : 'st',
>>     'spear' : 'st',
>>     'sun' : 'allwinner',
>>     'tegra' : 'nvidia',
>>     'zynq' : 'xilinx',
>>     'wm' : 'wm',
>>     'uniph' : 'socionext',
> 
> 
> I tested this script, and
> I confirmed all of my DT files were moved to the socionext subdirectory.
> 
> However, this would break arm64 build
> because some of my arm64 DT files include arm32 ones.
> 
> I think it is common to share base platform boards between arm and arm64.

+1

Just a note here that for Zynq and ZynqMP there should be doable to run
Microblaze in programmable logic with reusing fixed IPs.
There could be also other soft core CPUs which could do this on Xilinx
devices.

It means maybe moving this out of arm/arm64 to more generic location
would be one more step to consider as the part of this move.

Thanks,
Michal



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
