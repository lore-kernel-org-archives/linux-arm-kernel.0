Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16312C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:11:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA39D2077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vs4VbLP9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="krq4tu2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA39D2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FDoHIQNUuGgiCjgnq2BzsU6NMKTttMK+TylxCnFpiRQ=; b=Vs4VbLP92lF7Rl
	WcDejObvHNpgtcu4mbrxMqOj55PBiqF63HkPJ3F20tsVia3sq4R6CI9xFZZchWOqK5WHzS1dc23l0
	HJeUjCAEDxI6WSWyDgdXB9nn7cz12VAnlhgONsf6wzVUWUOGIrwBMjTNzQ3CQttpWVuWd94HYSZDv
	P3yKeM4hHbueHUfHcBnuGZ6WMaSm/6+q31/iBPx/QCwun1f0i6NzuVATfn9Uk3ojcpUruqU8k6PNu
	JXNd9s+GKfsOiHFiDouhf1SrnOmrFrmCVXh1AoRmvIzmkPCPKSuMxQhwa0mke92iOZBXPONK4uot3
	uYmVCnZu1r4VhNAh6gvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvkZS-00074R-Sz; Mon, 18 Feb 2019 15:11:02 +0000
Received: from mail-eopbgr780077.outbound.protection.outlook.com
 ([40.107.78.77] helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvkZP-000743-SP
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:11:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqqF+wPPuZzTXb5mfRDBTenpkdYnISVrrMkyrTHKXEQ=;
 b=krq4tu2bQ9iXNLLm/3OLuSwybxo6WapPMQSd/OXwuQKzVYuZkL16gcAei/A90phl8VaoOjgT6qAFyFcwpUNx96FyyrKzF6mybnB7W6WOIAuMO/l1qzdPTZzujVyhFMPZrIi24LOBMRYd0ZiPyTiaChNiZREJ8LSeZpnN8ZVkP80=
Received: from BN6PR02CA0088.namprd02.prod.outlook.com (2603:10b6:405:60::29)
 by BYAPR02MB4376.namprd02.prod.outlook.com (2603:10b6:a03:58::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.18; Mon, 18 Feb
 2019 15:10:58 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN6PR02CA0088.outlook.office365.com
 (2603:10b6:405:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Mon, 18 Feb 2019 15:10:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Mon, 18 Feb 2019 15:10:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46168
 helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1gvkZM-0002k0-C1; Mon, 18 Feb 2019 07:10:56 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1gvkZH-0007L5-7L; Mon, 18 Feb 2019 07:10:51 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1IFAjRI016824; 
 Mon, 18 Feb 2019 07:10:45 -0800
Received: from [172.30.17.111] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <michals@xilinx.com>)
 id 1gvkZA-0007In-Pb; Mon, 18 Feb 2019 07:10:44 -0800
Subject: Re: [PATCH] i2c: cadence: Fix the driver in interrupt flurry case
To: <shubhrajyoti.datta@gmail.com>, <linux-i2c@vger.kernel.org>
References: <1550232196-6567-1-git-send-email-shubhrajyoti.datta@gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <fb0df818-7267-b8f5-4968-8a57db1905e6@xilinx.com>
Date: Mon, 18 Feb 2019 16:10:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550232196-6567-1-git-send-email-shubhrajyoti.datta@gmail.com>
Content-Language: en-US
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(346002)(136003)(376002)(39850400004)(396003)(2980300002)(189003)(199004)(77096007)(8936002)(81156014)(23676004)(478600001)(2486003)(9786002)(63266004)(50466002)(81166006)(76176011)(8676002)(186003)(26005)(316002)(229853002)(31686004)(305945005)(58126008)(65826007)(106002)(110136005)(36386004)(54906003)(2906002)(64126003)(230700001)(5660300002)(356004)(36756003)(336012)(126002)(476003)(2616005)(106466001)(486006)(44832011)(107886003)(6246003)(426003)(446003)(11346002)(14444005)(4326008)(31696002)(65956001)(65806001)(47776003)(107986001)(5001870100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB4376; H:xsj-pvapsmtpgw02; FPR:;
 SPF:Pass; LANG:en; PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com; MX:1; A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d280e62-2c98-4fe6-44b2-08d695b348ca
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);
 SRVR:BYAPR02MB4376; 
X-MS-TrafficTypeDiagnostic: BYAPR02MB4376:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1; BYAPR02MB4376;
 20:RalxtI2TKhS3axS0BjQKA2L2KugKdyBEr4MM/yN6wJkNzOp1s9qiInQDjpOwwcIuE5j6MDQvyboIYHiKpeq3zsxJ7YtFcxBNjacJe1JKUevANJThlOSohh6zVBJYWsGWw0C5IOJWyMSt6WaQzLeYiMPACQaK5UFru8LnFFhlVdX5xPD1jHLV0btpUtrEyDp4HTvFg7tawE8bqBj3C8wROMDEkVM61n5k6sXRB7zPUE5JPWlssM1g6zpsEp3TlDkQasMj02PydTJ2hLJ833FPXQ2J8EjQro9hB91IVp5q/KQRDs/nMgjXumg/Rmrb+gmzaTpdqG+nvOJbAbhfMwuyLbS1bT9LGhL5PdRtA/ipMvlH7dyUCbj8Y7PTn2A8IDVHu415I1mqcK9fu/3h+46XhFdQVRrC1USD63aHaIo3KJneV0D1coLTRdSW396hElmxdsfC9/Llc1l+e1F70VguCgx6jSIVnLH3Rl8Ob8pkzUcIJ6T49g+dq5CByirU/s3z
X-Microsoft-Antispam-PRVS: <BYAPR02MB43762BC8A73D47D301687275C6630@BYAPR02MB4376.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09525C61DB
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0Mzc2OzIzOlJoS2pkTXd5dFV4VnQyY1dac09IWjhmNjNJ?=
 =?utf-8?B?Y1NyS29uSlE3NlR5OU9rbW5jTUNNZmJIaEJWdE1hWTdTZDNMNVBkOGxmK3d1?=
 =?utf-8?B?YU5zWHcxRVVxQTRMS2hJT1V5Q3dtOE12SkJYVitaN1grWThlME1VVjJueVJU?=
 =?utf-8?B?NmpNaTc4MzA3emtDN2ZPY0E2KzJqR3JYdHJTejRsSDU2bDJQTFkzbDlGR2lO?=
 =?utf-8?B?VWRsWVdwcFBtMGJZVEdGYTViMmI3RForWFJqOEtvbVZoYWtCT2E3RkFpWE9L?=
 =?utf-8?B?RTE1TUpJS1Fxc0FieXhUMEdHSnNKU1ZVdnp5ZC9pZGJramNzdUZhMTZ2REtl?=
 =?utf-8?B?OG5iLzloQXpIQ1BhenpURXkrSmpGaXRsL1NFMm9UaHg0N2dhaDd2VHBCTTBh?=
 =?utf-8?B?Qi9aWVJJVHU3VmFuVHFQRUt3cnNDejg4Q3FGMXpNc1dRaXFIRHFVQUNHZUUy?=
 =?utf-8?B?dy9JT0RseGQ2am5KVXprQWJXSFNSRjhQeG9vNmZmTFdSMmdVQkFOamsydXps?=
 =?utf-8?B?OGpWSGM1clFjcnNZenpBOFBieFNKZWxySHFINUlZZ0hIRDJNYnk2VmJpc1pl?=
 =?utf-8?B?Z0Y5ckN5ckZuUVcwcFR4Vitoc3VXcUJjSmtqYnlEeFRIWmM4N1FseHM5QzRx?=
 =?utf-8?B?VzU1ZFA5TXZ1ZHYxWmtTQVQ0dUlvbGtPRkxZenU1dmNyTit0Y1Q3NzZQOWUw?=
 =?utf-8?B?U1I4QVZ3c1B6dnZ4UkVUdjcybkpZZlNVWHc3UWNrVzRsTGdIVkZQQkI2QWoy?=
 =?utf-8?B?NXlPc2lPZlhWc0IzK1c3TTJJdGpLRGt1QldVNElkUk9uR3lsTDA4OG13TzNi?=
 =?utf-8?B?d0JQQVpua01MY05hc2paaDEvcTJvWVJDdEZ5aTl0MmFvVFFJU1FBNVFHbmRN?=
 =?utf-8?B?ODFFQ0JhL0xqM0ErN0NmMDVkTGJ0V043V1lOc04zN0JVNnpZL3hURkVjMmh0?=
 =?utf-8?B?SGVrcnl2VlZPY0N2aEZYTjIzRnlSUnNnSG5QeTVEU3ljanRCZlVOYWZyOWJl?=
 =?utf-8?B?aWs4WHN1OGp6REp2NDV3WHlPWkxzWDNPc01aRzVacURjaS95cGh2NzJ6dERU?=
 =?utf-8?B?QnlzTkR5WVNjQklITkViU3MzSFpVSldtcEJCc0w1bHU4dk9KTHcwa1BibU1O?=
 =?utf-8?B?bU5OYmhaZmszVEpTeXN1ZFFkeG81Y2tQZmxoekkrN2liaTZRc2JRb28yR0ds?=
 =?utf-8?B?OWlrL3AvSGtrLzl3T2NRcHd5Z0ViejB4QTVUaHBsdXZHWDJCWnJ0ZzFlOVhB?=
 =?utf-8?B?L1hsZ3NsSlFXbnlqWEo1NjdUa2pDOE9sRTkyaDJoTU9SNy9SUzJJU3hOdDVD?=
 =?utf-8?B?Rldyc1EzVk1yL21SdDh2eEpwS01nVGdxcExZblJwWncydWtmVlpGZHRxaURi?=
 =?utf-8?B?SGhwT3g4VTA3OGxBMlc0RVUrc0t4Ym1vZnBsdm01QVlmK2x2QXRxRUJMRFpW?=
 =?utf-8?B?enY0bmdUOThKTzVUQmtTeFNOdUFmeDRhVTI3YTFlWWh6VlFqZXhueG9mZlpk?=
 =?utf-8?B?SW9RV2F6TGgwWVp3OXcveVd2cTZnUUVUTWdXWWt0TUxkV1FIa1pQa1BTamQz?=
 =?utf-8?B?U1h1c1doU29BRDRVNi9jM0VqVVRsVjNUME5wMHdsRFBrbkY5YUNlNFZPRjVL?=
 =?utf-8?B?aE1SU01IWmFydzVIbEE0aG1NbHcwWEF0RE1qeHB6cEUwYjZuVGpmYVNFekRq?=
 =?utf-8?B?dWNaYWdDOEw3ZU1lWTZYdFhWT295SUlFYkJUOE03R0ZkT1AzV3pOaHFaaDdN?=
 =?utf-8?B?TXNnRmZQelNOUHp2YVB6Zz09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: uW1MXsBlC8Pj4d4VSyqJObEUm2RTMyZDowFXMvDkCQmlYdoan8r32ekbhtBmQCBD1HYHrpFoOeaDYCBFvMFEQUIyZ+Luf5u1oZpx8/m5IxxLv7h+JLb/Jg91zbMOdXtO3/90DTYfg4p1ODaAf+0WfTqt8YJhRCncbtpJEoE3LCtYLHQftEUJy0titMmqRrXxAlRHh8q5sz8zCqOTOiy40CfMiOJdZtDNWzHmyHA/a331TE2UOcdmOqbx3e4WNp6ZyeUyxcWN+5QgRLQNF7Pyua2+nxCCYCbbEzYLPb3baBB/UcyICNHtbqiDkI2+9IVY+c/i0v5GPjZtJskep8qr7dGqncChd58shcZQYDESfaaHqP6QJk00Qgp6ACbtyo5G6iRKDWEJZRBavsmveuhMI1yok9j3Mvrh3nzMCvcP1eQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2019 15:10:57.0652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d280e62-2c98-4fe6-44b2-08d695b348ca
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.100];
 Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4376
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_071059_969907_87FEE1E1 
X-CRM114-Status: GOOD (  14.44  )
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
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 15. 02. 19 13:03, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> In case there are a lot of interrupts then the hold bit is not
> released protect the code by making it atomic by disabling interrupts.

There are two sentences in one.

Isn't it "released. Protect"?

> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/i2c/busses/i2c-cadence.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index b136057..92829be 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -365,6 +365,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
>  {
>  	unsigned int ctrl_reg;
>  	unsigned int isr_status;
> +	unsigned long flags;
>  
>  	id->p_recv_buf = id->p_msg->buf;
>  	id->recv_count = id->p_msg->len;
> @@ -405,6 +406,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
>  		cdns_i2c_writereg(id->recv_count, CDNS_I2C_XFER_SIZE_OFFSET);
>  	}
>  
> +	local_irq_save(flags);
>  	/* Set the slave address in address register - triggers operation */
>  	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
>  						CDNS_I2C_ADDR_OFFSET);
> @@ -413,6 +415,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
>  		((id->p_msg->flags & I2C_M_RECV_LEN) != I2C_M_RECV_LEN) &&
>  		(id->recv_count <= CDNS_I2C_FIFO_DEPTH))
>  			cdns_i2c_clear_bus_hold(id);
> +	local_irq_restore(flags);
>  	cdns_i2c_writereg(CDNS_I2C_ENABLED_INTR_MASK, CDNS_I2C_IER_OFFSET);
>  }
>  
> 

The rest looks good.
M

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
