Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29165C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:50:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF412073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gUClRquy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GOh0dOTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF412073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6j03JP/c+w3VkVblbkcT219Ns+DAh/C/hvawh4cqqYs=; b=gUClRquyJBigtx
	SD47sIXtlDdjW5kS6rPXdQP2RVwDYkQbYfNqlL4UfjlLn+1/qlexBuuaeEFtLGikD2t2dmhFQdaYZ
	GY7XRppiZiCAPEpWAuNSFA4B4S/0cMl4i45tZo5kU3KD4Ros5wzfQb3dOBjbSALuw0xeXBM9SW891
	Qd7qy0E9oDJODyzBYPS/meifGHcdGTBGlpfVOuF1wby3mR3AaMO7zR8nGHV70Rb4QM5Cy78p3E9QC
	gR+N7ALYKWG/lFJ7esn1HP5XLZlfBNVf9Up87XBCAD56n1yFcfPfY6eLA30i85ykK0YKNQAi4Mf1N
	wqtNs21k9RZaEH7SNQaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf0aL-0002nq-IU; Thu, 03 Jan 2019 10:50:45 +0000
Received: from mail-eopbgr760079.outbound.protection.outlook.com
 ([40.107.76.79] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf0aI-0002n5-7W
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 10:50:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWLDwjpV9wNYmHRKKA4tvBO1VchWR88D9nwxz3qMoeY=;
 b=GOh0dOTV2LvSj+DE5DxfA7FWsA6g28HnsM+OZd9lp7SvV2oTRPjcpPyTO7othXf1CWcySePsec2xeCbGrcNGixBFt4AqGDudY450GiitmE3uwqnooltaXj9YTO9GNtNJkTFJ9HxISLLGU/x0k1mWFO8nl9jzkz9w0a+/FUs7ioQ=
Received: from SN4PR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:803:2e::34) by BY2PR0201MB0728.namprd02.prod.outlook.com
 (2a01:111:e400:2c8a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1471.20; Thu, 3 Jan
 2019 10:50:36 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by SN4PR0201CA0048.outlook.office365.com
 (2603:10b6:803:2e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Thu, 3 Jan 2019 10:50:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 3 Jan 2019 10:50:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:41401
 helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1gf0a7-0006ps-D8; Thu, 03 Jan 2019 02:50:31 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1gf0a2-0004iZ-9h; Thu, 03 Jan 2019 02:50:26 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x03AoFYW003304; 
 Thu, 3 Jan 2019 02:50:15 -0800
Received: from [172.30.17.111] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <michals@xilinx.com>)
 id 1gf0Zr-0004Wx-AO; Thu, 03 Jan 2019 02:50:15 -0800
Subject: Re: [PATCH] ARM: dts: zynqmp: replace gpio-key,wakeup with
 wakeup-source property
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>
References: <20181221181213.6812-1-sudeep.holla@arm.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <63f7ded1-8f1c-6aa7-9397-75c1c2d194b8@xilinx.com>
Date: Thu, 3 Jan 2019 11:50:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221181213.6812-1-sudeep.holla@arm.com>
Content-Language: en-US
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(3190300001)(199004)(189003)(106002)(58126008)(305945005)(106466001)(230700001)(8676002)(4326008)(31686004)(6246003)(2906002)(107886003)(229853002)(54906003)(316002)(23676004)(81166006)(81156014)(47776003)(63266004)(2486003)(110136005)(8936002)(50466002)(64126003)(76176011)(2616005)(36756003)(26005)(77096007)(426003)(446003)(65806001)(476003)(65826007)(65956001)(14444005)(186003)(31696002)(44832011)(9786002)(486006)(126002)(478600001)(356004)(11346002)(5660300001)(336012)(36386004)(142933001)(107986001)(5001870100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR0201MB0728; H:xsj-pvapsmtpgw02; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com; A:1; MX:1;
X-Microsoft-Exchange-Diagnostics: 1; BL2NAM02FT030;
 1:pADk3x5zCfCSkvIADd5jL32wjYjPSNY9PxweaiFnq5B1vMohaEyqUlkf1zok080JWla4mkTbwIArcKQ/zrFazqMNEvZeWouQUimLd1/rcvmGRObN2psKsz8nvBN3N3JZ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8c8da9d-ceb1-4eaa-8a8f-08d671694a75
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);
 SRVR:BY2PR0201MB0728; 
X-Microsoft-Exchange-Diagnostics: 1; BY2PR0201MB0728;
 3:mxZ2u5GN9evXQ7fW+7Mzpbu+8huwYmSeifezI4qtdXk3yDHCb975N2lsEsJGfechmpOYL7+o9951CIRNICp0Eot9KbVwW6FOOIhDc7QF/RN6SLxFMZVGN4CN6CuavVBNJZpximq2+FgG4zrcnsWn0lR4c/y2veabbo+Eq0jV9dq7DOX36toYz2JvjqVeL8Izl0xd2xBOO8lMRxLjfnZN932T0bmzp/0tz15uo3tQZCQBaMK3ms9c8ktWoGDZkaF4p+4eHCEpD2beaOqF3PYuKayMJAtTlkAqdmPVyY4mOjVTnfIfI3eVCen+rE65mPmA+JEXKw2Aj2sOatKCq7jv2QvxUZMu5STvPeHBzR1pnWs=;
 25:kLyf1pwvh0wQbDQgbcf2UORaAAKBSnVXp+jKwvvpjyXhFVvh0u3QFDOYasgXflWEpfefRcvbAKBhW7xuL1ZSrIPgy8iithQ5nsN4WTNeXlRXwAy+gUUSTCPYW40mHwPJCyDZL9wY7J13zIyoog0QnxskWGfxXR7bMkDd3Lw90glRz7V61buAkfLi0oLNet1oVgtSJtr3B8WVJdfdshKDbWr4SBLJ2AL3vFLQyK5rdXNUUPSd9cWYLw+NGSySpGOVQAWn1bWiYVH+UqTRFrnzt3xKJVUXJKNSCuo53pf8x3WoGRgGnsU1ZFx9YEKL87OkQuanO9bb4tcFzvEUFvdP4A==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB0728:
X-Microsoft-Exchange-Diagnostics: 1; BY2PR0201MB0728;
 31:G9BRfqt9znjZuHvwPYsubw4TvWq5lupT1OHt+OTATrAq2befrU6dnq10/bVLvpzidDZGjeg2wU413k16lhg3W+ZvFFwU8Fc7IVVYRBc+IxTv4/ORwKTmiJ9RSiTpfVNYWfzPWywWraeSr3IhnZtURLp8iHpwkkyXFnpScNE7fRS/0cD5OtOvKEhqpyuMwxVlKXwpzhZkjxDQbYLSK4svEyyu3rH0dAXw+ADHiYFDvZ8=;
 20:uLKy6czUe14xfLFvOFEluNc49Y3DDQSP3/dftQzRo5BhaajfFv0t59dJF4bXFRlT4o1dpGs4XoDgdn0Uy4PfcdUYKPfqkof9bbMcxxMSxY8kYR7uN9YwIXscrAz0ShqTyjmm7X8VtyNGgWXnzL1hUBrpFbJQiePNPjZWK9S3ByDeuasufopPTCeVH++ETVyYlR7jU4Qm3aTZmFtizIFvC2MBvp6W7EckA4PyejBUq3Pl25UBK1NTeRYeyL8v4u8VY5Onsi0HHg/Ydo6eTQWD0/jlnEDdmi+tVHGi3v4CS01ekTEPsoJdzKT/Jpn1HVTaWG8KG2qUwqX7U9qYy6pFu3bntcWw/V/8Ugr19qDyn8nw4mIC8L4N8x89+cnBgu4+blAZbj4duY3AUZhjfpMjskMcZLvO7/7Wq5Q2CM5D/2undXlz7K9ksblrFpat+q6UT5goziuJUuqQ+5ES8cv09b4zOWdQowdkSYmVIecw+457AeQxIP0H1jE9TJQSDeET
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB07280068301CB544E17EC0ACC68D0@BY2PR0201MB0728.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93004095)(10201501046)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR0201MB0728; BCL:0; PCL:0; RULEID:; SRVR:BY2PR0201MB0728; 
X-Microsoft-Exchange-Diagnostics: 1; BY2PR0201MB0728;
 4:7JTOH3mv3wbmsY6JJZvnzEsg2aYAZ3/pSl9s2tvOyuKPocENEI0KIegtLPji0pA0HjOvs0++74O2Ph2OKsNAAEFIFoeo4mJn4VaMk4aabSJiaTFN8Air4FDDJZSQBJOocETJGEe29+DQEqALaXUxNEIZRNmYSesLuQNkYxUsle2yIx/L2iFPv+LjuxdhV9ZRXqUypriVOTtWgsd4iUC3H58xXGggDGa1QAxNZfD/9HBn1yFKJWWy7zApBUVF6CSw4A5M7YWE3czgBxFD+FDb/w==
X-Forefront-PRVS: 0906E83A25
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyMDFNQjA3Mjg7MjM6cWdaTEtzOCswU1lrUzRqdDB3OWxmRlhZ?=
 =?utf-8?B?NnNiaVp1amh3cFZLMnRFWmUwcG1QQUZycHVzc1JJZ0k3bU8xNnEvODlDT0hm?=
 =?utf-8?B?TkozdGZpd25KcFFobGZXSmZDeUUvK1VqM1B0SnNIZForZE82VEtNSlkySDRF?=
 =?utf-8?B?WFRZL0phb1plU2ZnNVZXcVNtdFAwakhQdENxZ3gxQ2FtYjhRV2pzRVF6RjF1?=
 =?utf-8?B?WXdmRHd0YzhDQzVDMTY2eEF5OEtKeEJkTmVncHZvd3pzS0M4Vjc0dEM3aEJy?=
 =?utf-8?B?SHJta3dvdDZoamNNM0hVa2c4bWpmNzdESHBkaHdFM1YwUEx2VU03SW1lSU01?=
 =?utf-8?B?T2cvZlNWYktuTmlZYzEwbVJtMEFSbG5BUVVzQzFjOWREQU5sWmdNZ0lKb1Qw?=
 =?utf-8?B?RUJPOWhxcCs5SWVpb0g0b1pDYnRJWW5NdG1lWmR3TnE1L0lGYUU2SGRiUlRq?=
 =?utf-8?B?cUc4MEE4TTgyMnJwTHRvYnNDS0MrVGlaRW9ENU5mSGhabkV1UkU1UkY5S3hw?=
 =?utf-8?B?d0dES0JhdjNZdCs5WUdhay9DdytwUzRnNVJ5SEJkZHRTY09rcHVId3owcnFu?=
 =?utf-8?B?b1BMWENzMEZYc3Nyc0N3UUFXQmE2Z3Q0ZmtLSm1oaWVTZVR5dEdqN1ZIcXFy?=
 =?utf-8?B?NGZ6KzFjY0pqWHU3cHNITktMV2FUUERpeGgvYUd0bWlkRVhaclErU09Mc3Jl?=
 =?utf-8?B?TUpBL2xORWEwVHFzWGo4aE8zOElxbDdFdVpjRmRDYjBsRTFXNFhUcU9OelpE?=
 =?utf-8?B?ZVJSWUdjb3MwZ296d3o1VVlCY0VGbGg2elF2ZFVFZFAyM1hZNUU5SE9vTW1w?=
 =?utf-8?B?K2hqamVmSm1MNktwTkhLTWI1UDBMU1ViN1JKeW5BV2ZSYk51R0xNcEk3SGF5?=
 =?utf-8?B?ZkVnWDFLZFBQaXFDdXpIUHNZWG0xVDJSR0hCRGFHZkpPZkNYYy9NZHNJQm8x?=
 =?utf-8?B?Z2pKV05IS2xIUjFUTEY3N0Irb2d2b0J1S2RuVWZYVDhVN1YyUmFTOU9ZNEdz?=
 =?utf-8?B?dXhPeHVtWUVBOXNPNlNpbDVVMVczYU1Rcmh6N0xWenVRTFpiTXNmZkxIWVdm?=
 =?utf-8?B?aUJlbE56NmxaelFucWhobU5PV1dPM2Z6cEMxS3FBdCt1dnRFemtrODNtOE5C?=
 =?utf-8?B?UmVqTVkvZVR1RGlnb0hMNTRaVnhubkZYOHcwSndOWjBKYUh3UHdkNHdsVHFW?=
 =?utf-8?B?US82MHgwTXMwRnE2Z0ZCQjJ5eE8zdWMvOFlIdXpiR3JGWWJoS1VoTjFwaEVn?=
 =?utf-8?B?T1N3SXJBY0plbVA5czlRVHVSdW5PZko1Wm5CSVR5NENIdHYvcE8wb3VqTm5U?=
 =?utf-8?B?eUlQcGNCTzk2OU0zeFhPcHpuUm9YSmxWSjE5RlNuVXZQM2xLQ2NsaVY1SHFk?=
 =?utf-8?B?eEpVRG9uRHJlaUpHcDRKbDJJUVlhOXJEUFkxRExFYTRqVkgvaGp1bGo4YWI4?=
 =?utf-8?B?T1htUHpmRE5ITmFhbDBSWnN3V2UyNkM1ZEsvaVBRUkVBS01NQXJ6cWNQQ1RR?=
 =?utf-8?B?cW1MT3BQWUNPczRkalAvQlNJUHptbUk5Z202amI1QkxqQWRLMVUydG5IZDBq?=
 =?utf-8?B?OXZENWFoY1RiMzk5R0t0anF1N2pFOXJSNVNlYkhyWWtJUmpaWE9RU1lXN0Ev?=
 =?utf-8?B?T2RGMHZPcVlqTjVzdFVaV2hudVg2ZHV4OURPblBzWTZUSWxnU3B5SzdtTGNR?=
 =?utf-8?B?aGpDSVdGVmVTc2lTNnJtcUZIYkwvR2xWSzRGVkR2ZU5yU1JxTjZGUjUxaC9x?=
 =?utf-8?B?M2Z6elFpdVlIOTBmcndRWVYwbUIvZ0ppWThtNVEwQURGNTMyclduRVBMclpp?=
 =?utf-8?Q?qACqGX+NvLyMVuH?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /vtaqWf7qfMkOLLm7qzUG2biuA7XoUNo0+LlMqCQFVQpnTVSdTxuNaocstliLZOYbt82oCes7N6z9kYrrjskezhnK5wdgb4Gf8bAs7ubn+Oo1Uc3hMGE+Uetf/Lwc3v3LPCqNGmse+vU+myUxVODetVhGLpvdK4yQv2bzrm1VwzGxJDXapj2DnV2S625RPIgMoELEi2KHjlhSfJgae5zYIoaglTZq9rCJBFxBcWDiwayoZ9O11xyT6S0O84aNlvhp6Q6wiZV0Gxsp2+HlMgecABz0SDDW4R4AeufIxi4KYEHC6RytUaee7zBb6rO7ArM
X-Microsoft-Exchange-Diagnostics: 1; BY2PR0201MB0728;
 6:XGGwFcaXa7P3KQE0oEuhgQe5zI+O7yKyuRd2fjCKJ8dVSlS2kR6dYlMg9YZAAPR03iIy27nVuECZTaVi8ZuXbUpJa28OtW++sDezqlqt6RhsfS183GpNR5P/QXXjZXr8f9Uc15qFXJcaf5Zpt8ej+mzyFyaRgf7WlEG0b6XoyORhwskPyNR/9RKxjcCJvBhSse2f6NdlhYFbzpdVte7jPsOhPiyT9LDM1VMVBRpLfViqYjQC2Qiylw8E4gmvAOP4rXQ+3A4Ryg57smQxKnd5bZGcGvdhJKKRnQYMMxy+FdZOk6zXWQbPgkYKyPJbEUWNpsj8SxmcxHAI2J+eQjwZUA6PazLvawXDw4VtnPl+vZn9MMbnRiCp/qPOVvAXlxKhgKv8Oouu7AUjdJqGfMH014itZrD836r1yMRo8V1U7dQPfXon/kkziHFyDCYzlhHxDI0e/An7E5RyUUe4QAUgFg==;
 5:oMHiNP6tlGGc02UbIfXEif4HD7GyM24HcZy/4TzR/PeQveJjFYpVSWdTm/Pim2W+sqZmRbKfqftqSoFp6EE9TSsKUvAPuyOqrHe268oTXF7mh0EwRZbGRHeNPTMAgOFUFdHacTdZQUjRp3P4I5JypwnEhOwfoLEZs0OsdOZjpnA=;
 7:dg0QpnqcBpyK4T9aFKppIsVzBOkIGAMuwf7v3vdmgBUXOfj4fkVZf6iK2ZRjitpWzffGZRM+yuo8kESsJRMtUgGSHRFMJ/azN26H0ORC/DuoKpvAU3ZaHdHQfmYEpREEU2Hs11RUGBCmz9rE17ujLw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2019 10:50:34.2037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c8da9d-ceb1-4eaa-8a8f-08d671694a75
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.100];
 Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB0728
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_025042_329980_3C13C5DA 
X-CRM114-Status: GOOD (  17.36  )
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
Cc: devicetree@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 21. 12. 18 19:12, Sudeep Holla wrote:
> Most of the legacy "gpio-key,wakeup" boolean property is already
> replaced with "wakeup-source". However few occurrences of old property
> has popped up again, probably from the remnants in downstream trees.
> 
> Replace the legacy properties with the unified "wakeup-source"
> property introduced in the commit 700a38b27eef ("Input: gpio_keys -
> switch to using generic device properties")
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/zynq-zturn.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi Michal,
> 
> Olof requested to slipt the patch and send it via platform maintainers.
> I totally forgot to follow up on this. You had acked this previously but
> please pick this up and submit via your tree to ARM SoC. Sorry for the
> confusion.
> 
> Regards,
> Sudeep
> 
> diff --git a/arch/arm/boot/dts/zynq-zturn.dts b/arch/arm/boot/dts/zynq-zturn.dts
> index b38704657960..5ec616ebca08 100644
> --- a/arch/arm/boot/dts/zynq-zturn.dts
> +++ b/arch/arm/boot/dts/zynq-zturn.dts
> @@ -54,7 +54,7 @@
>  			label = "K1";
>  			gpios = <&gpio0 0x32 0x1>;
>  			linux,code = <0x66>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  			autorepeat;
>  		};
>  	};
> --
> 2.17.1
> 

Applied.

Thanks,
Michal

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
