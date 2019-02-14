Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDA8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:36:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E07222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QcdK7KKA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MuAv2CDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E07222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ROkXn8JfQ8C9l7LzplihYJL6UgX3W8JYiNkZ5rUZ9c=; b=QcdK7KKAkx6XUU
	SGSaRoXwdkaDLMisbtC+9VmiFQNQeDaAsRtkyM53Z/hK4J1zSoXzyRRCDcMYODfWwGMYqSFbOrbIe
	dBRbutQALCbIRAuoJrr/kqV4ziScGKz6LtsewKT5d4XkhGEtucDYVjt7APOhEsEpg1VkoPEqLeOTQ
	PRIzabNJNoZkl8zV1KZ29dpl3x6wFAjjZ6ve7kTEaeSq5qWtL5IzyJ6dHA7UWFpENPTTpyxbmu3cx
	IaPr5YYzKXrfae2GFIT4M3pQNDGVfBfWP0rXDkKtR2SpzonYJjSaayWuGGfC0/teRUVi0f0jgIYo0
	fyQIc6oQ7qUURvqslbpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guAcy-0005ar-6m; Thu, 14 Feb 2019 06:36:08 +0000
Received: from mail-eopbgr760045.outbound.protection.outlook.com
 ([40.107.76.45] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guAcu-0005aT-7M
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 06:36:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWP6YeXZplIBh0QzyKGmwDvwo6FB3IAF4n+wV7ZP8/8=;
 b=MuAv2CDBwQ1wzHATEiFRNZd3hQLuLVC3e0V/Ai9m6QDCeYatLyCq+eeLKoBvLDkg82dFS25DfVBaYIEWVYRvAMVThJarUJu1+w86xnebgK4IEcBTLZTKqYLCONk2HTce+2xVIYWT2AEI1Y1KlYWBNiulSiU3CoKXhXYm+WFi9w0=
Received: from BN7PR02CA0001.namprd02.prod.outlook.com (2603:10b6:408:20::14)
 by SN1PR02MB2158.namprd02.prod.outlook.com (2a01:111:e400:7a48::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Thu, 14 Feb
 2019 06:36:00 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN7PR02CA0001.outlook.office365.com
 (2603:10b6:408:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 06:36:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; bitwise.fi; dkim=none (message not signed)
 header.d=none;bitwise.fi; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Thu, 14 Feb 2019 06:35:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58933
 helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1guAco-0005I4-Up; Wed, 13 Feb 2019 22:35:58 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1guAcj-0004Ha-QN; Wed, 13 Feb 2019 22:35:53 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1E6Zl7x005751; 
 Wed, 13 Feb 2019 22:35:48 -0800
Received: from [172.30.17.111] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <michals@xilinx.com>)
 id 1guAcd-0004Gz-NA; Wed, 13 Feb 2019 22:35:47 -0800
Subject: Re: [PATCH] serial: uartps: Fix stuck ISR if RX disabled with
 non-empty FIFO
To: Anssi Hannula <anssi.hannula@bitwise.fi>, Michal Simek
 <michal.simek@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190206140813.15349-1-anssi.hannula@bitwise.fi>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <d58d8b99-71ee-d9d4-7217-767cc09989ac@xilinx.com>
Date: Thu, 14 Feb 2019 07:35:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206140813.15349-1-anssi.hannula@bitwise.fi>
Content-Language: en-US
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(39850400004)(396003)(346002)(376002)(136003)(2980300002)(199004)(189003)(76176011)(2486003)(64126003)(23676004)(106466001)(107886003)(6246003)(4326008)(230700001)(486006)(126002)(476003)(2616005)(36756003)(31696002)(31686004)(11346002)(36386004)(44832011)(14444005)(77096007)(26005)(65826007)(63266004)(426003)(336012)(446003)(47776003)(186003)(106002)(229853002)(8676002)(65956001)(305945005)(65806001)(316002)(8936002)(110136005)(54906003)(478600001)(2906002)(81156014)(58126008)(356004)(9786002)(50466002)(81166006)(107986001)(5001870100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR02MB2158; H:xsj-pvapsmtpgw02; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com; A:1; MX:1;
X-Microsoft-Exchange-Diagnostics: 1; BL2NAM02FT018;
 1:BPL/X2co2XiZ7baDcFGa/i5YRppIri70A3tQlZfF6tt+bfehkAnLkXXq81YirtnmBTZpfN1DQemuvFkHioN9otTcPRejjZr6ZLpwMsIlFgBu2Kg4xcADklBGhsg1p6zhslF9kMYz/l5TsUEjMT54eA==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78bd415a-4fa2-4c7c-a112-08d69246aec1
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);
 SRVR:SN1PR02MB2158; 
X-MS-TrafficTypeDiagnostic: SN1PR02MB2158:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1; SN1PR02MB2158;
 20:CNYEaBQt9M2NMR4Ryk7rj3s0WBvKQXVcL88MyowkJZ7VyppQbtgiy7pzVGqQpaGVxcY2iAEih1mJrYMSN7E1Q5VW5JCewXEKnDeztpPZidMGWv44StP7lTouNUvanSajnMaD6PwcE4xFPlfy/RKWPI5GpHEEjYeA6MfeMJ1otowD5wun12d8JukZJwhSD+hlPFsJjwliiZMLqFqmMkGaH32tfGFjdn2i8iFhTCBCDIoLWmIXbo3Az6VLkqWsdWIsFC9tdjZy7Dx4G3DhLEp/pZGpitSZtU6rtydg4rl8wr3U2uZr06xwmyEGD4LN/zUJ4Mv2Z6mCkBvc0lMyGe483O8T+p8AHW5PADPGBKwjSB2O08TaIoFCArv4DCzwfDEwcL2exvvvKBUMLbRepgHLxwAq+kBzp7VgasOrM5a8/Qpm9y23gm5nCFYNR75yIRnwDhbLpnmPRtVcwftxRI662VjzZ5r0TCW19gby5qWvPyn+MbVNyc7Mh9nJqnTcAull
X-Microsoft-Antispam-PRVS: <SN1PR02MB21581EBB507D0F439BC5ECB5C6670@SN1PR02MB2158.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjAyTUIyMTU4OzIzOmdCQ2JFaGhVT1hwSERSaFNITU5FdEJHU3Bp?=
 =?utf-8?B?N09ycngvcStESVJkY3JkNVZKRm5LaGMwOVpjSGFieDh3dkdQTVRsSE9CODI3?=
 =?utf-8?B?MnN2Q1BrdzUzNmVFODB1cUgyQXBRT254L0YrTkdqNU0wbTRXeHVwbzRzVEsx?=
 =?utf-8?B?YldUdS9McjRFaXlMMm9Jck9XY2ZBYmNtOFcvYXF3UUhHVUZKZ3k4WVNSUGlC?=
 =?utf-8?B?Zmh2S0JXZVBSQXlUQmpEUjg0TkVWdTdTR2FMMytyZ09XekIwZ0gvUVdQYU5m?=
 =?utf-8?B?WXRsTGZPTnVEOG4rak5IaU5CZjZ4WmRYNVFySnUxODlMVDJyNEdrREhFRVNJ?=
 =?utf-8?B?c2NreFdKSm8xYmlkRWhuN0VPWDdLNmFLbW9EeEZ6MERFUFdSQjRReUxrdVhW?=
 =?utf-8?B?R0pWM3d6SmgzMzZQN2E1SjhnQk1LdkdwZU1QMnRGK3doTHZVZklUbGYxQWNE?=
 =?utf-8?B?TkdqQi8wSlpDMmpMZy9iRGtOeklKSCtuZXd0dXJZd1dGbEFxYjZwenloS2JO?=
 =?utf-8?B?YXpCczBWZ0hDTDVsQ1FERmF2VCttUHd2d0k4Y1hQT1dFRFg2T3crcWhRenV1?=
 =?utf-8?B?TmZ1YVZhMWNjdmdNenBnNXE4bHczOXFCaUNTR3oyeXUwNlJaWXVCbE1hQ3pK?=
 =?utf-8?B?TFRoaXJiaWdFZmNpRitKZmE5LytIUmtKTXVFVW83cnRUWEZWMDRBeGxkRlFX?=
 =?utf-8?B?eTI3Skcva01qT3lLb0o3ZFJjSEQwTWxNbDVQcUd2UWp5NjZtNnNybzNpMUk5?=
 =?utf-8?B?WEU5T2I2THhBSDdKdzh2NkFDa0Rmb3VBVUliWlFxUVhGNnJxTXhYOVg1aHBI?=
 =?utf-8?B?VTFSNUpZdyt4MUpJYTUrZlFCWHhxVDNqbnBwamZlSCtKaGJXRHFwMjdWVjAy?=
 =?utf-8?B?Rkpmc28xMUJZZURZenNJR0hwZXhnbzlDTGtQaU4rRktCUlI3YjBzQnVkTThC?=
 =?utf-8?B?YUlJcEpyaS94OXlsUC8vdzlIanl1R2x5ZjFoUy9DRFB3Q2V5enJ6K3VRbjBJ?=
 =?utf-8?B?ZGJUVnBrVlNyc05OZ1k4clkxeTkyUWU2K1JZR1FVbzZxTnFGbmp6SmFNSFhi?=
 =?utf-8?B?ME0zQmtDaFpKbkwxQjRKdlpUc1VFU3EzVTlvM2V5QWZSUTR4bW1kVVFIUVE0?=
 =?utf-8?B?WERpSGFFSm5ka045Rm5pK0FKZDF2d1Y3bzRUNVFtSFdxcGJZWll2c3hraXVN?=
 =?utf-8?B?cTdFMmk5RDJ2a0Z1Mjc3UXo5akM0RDBibitzdjl4dEM5ck5PK0haM283YTQv?=
 =?utf-8?B?TXZEa1VpSGxUS2MrYjJCcWxydFFzY3pmMVU3RFAyZlFNRERKenZCblh3ZjV4?=
 =?utf-8?B?MFpiellCYXdra21SRkZWS1QvODhQbVhiUUIrbDdmdWozYlFVQmZya3J6bmFj?=
 =?utf-8?B?WGp3TTZVTWw5RnUzRG56MXJGOEtMdS9SOHB0U1grT2FpVGxhZ0pLT2NidHZr?=
 =?utf-8?B?N0F5ZnpGREp5VEFONDIzbVk5SFkzRm5kbDdGNWVMc3FiVHFyZjdiemkvWHp5?=
 =?utf-8?B?alpVNXVFNEhNb0YydUQvVnVrL2VZMWRPbHhwSFdNYWhIRmVJUzRnRm1TdWNW?=
 =?utf-8?B?UnpBTXFxM3hlVUlVQlNCdnYrN3Q2NEZCNnhYcUowemFSOHpnTjRLZHZwMXAz?=
 =?utf-8?B?ZmVqVmFKczhZdUg2TGlOQ3U4eG9zbU1sSnUxQmQreVN5Sk5Hbkw4S28wZVB3?=
 =?utf-8?Q?BcrFx1zEua6m+O8pPN6gPCamSuDev7aJcqdUNoN?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5PnCXbhPu0R+R0OTYjgJlGPVZPFXQW4dFI8OQduxdGi0p4uV9cN02P/3zHAMDM7QZN0DDU6ZczaUNBbaI0hzWiHX210sJeAGPZo+VwyockXNTJAk1TNFL+CTDZUXimD4o+55e3JPzmBapoB3UI0XtQahhU/T/DkQ2ddXMQ1aXt7HfHvcFj2wWlPYFLLWk1XjLuPNAvqYEP74qe/uXAlHEk/JCg/8D9836Ikrb6sVUZyolR8St+gPL9HIoQhZDSDpa5UaPeyu/EE53QvqSbbEujUgYPLa7ACxZ2vBY2KEL+umdRlSxReXl+gogLOSLJARaumfEWndPGZb5fus0G2diACp/jgzdj6whEtU5dPgOw6C/EnP6U7kRJjDY+lQvdRDF4Cu4+1E8SgOGZC8Kw47kUp2dJfZmbHJCEm/tcl2IXk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 06:35:59.5053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bd415a-4fa2-4c7c-a112-08d69246aec1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.100];
 Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB2158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_223604_620203_5F24C893 
X-CRM114-Status: GOOD (  21.86  )
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
Cc: stable@vger.kernel.org, Shubhrajyoti Datta <shubhraj@xilinx.com>,
 linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+ Shubhrajyoti

On 06. 02. 19 15:08, Anssi Hannula wrote:
> If RX is disabled while there are still unprocessed bytes in RX FIFO,
> cdns_uart_handle_rx() called from interrupt handler will get stuck in
> the receive loop as read bytes will not get removed from the RX FIFO
> and CDNS_UART_SR_RXEMPTY bit will never get set.
> 
> Avoid the stuck handler by checking first if RX is disabled. port->lock
> protects against race with RX-disabling functions.
> 
> This HW behavior was mentioned by Nathan Rossi in 43e98facc4a3 ("tty:
> xuartps: Fix RX hang, and TX corruption in termios call") which fixed a
> similar issue in cdns_uart_set_termios().
> The behavior can also be easily verified by e.g. setting
> CDNS_UART_CR_RX_DIS at the beginning of cdns_uart_handle_rx() - the
> following loop will then get stuck.
> 
> Resetting the FIFO using RXRST would not set RXEMPTY either so simply
> issuing a reset after RX-disable would not work.
> 
> I observe this frequently on a ZynqMP board during heavy RX load at 1M
> baudrate when the reader process exits and thus RX gets disabled.
> 
> Fixes: 61ec9016988f ("tty/serial: add support for Xilinx PS UART")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> Cc: stable@vger.kernel.org
> ---
>  drivers/tty/serial/xilinx_uartps.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 094f2958cb2b..f0c4f59d9314 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -219,6 +219,13 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
>  
>  	is_rxbs_support = cdns_uart->quirks & CDNS_UART_RXBS_SUPPORT;
>  
> +	/*
> +	 * RXEMPTY will never be set if RX is disabled as read bytes
> +	 * will not be removed from the FIFO
> +	 */
> +	if (readl(port->membase + CDNS_UART_CR) & CDNS_UART_CR_RX_DIS)
> +		return;
> +
>  	while ((readl(port->membase + CDNS_UART_SR) &
>  		CDNS_UART_SR_RXEMPTY) != CDNS_UART_SR_RXEMPTY) {
>  		if (is_rxbs_support)
> 


Please review.
M

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
