Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FADC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:46:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A552229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ecvdEfVH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="r2OgGNSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A552229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fsKUPZBRjC+MpyTKFEH60pqt6EjUR8h+JB2T7qYuHYY=; b=ecvdEfVHpJKWbq
	1F7jUfhMgbG1CeB2SgU+BZ+mP5/Et8ZZM8hDhzhUlNrfQ3uYcA546enogFQsswHHrlElUMx+RsVvS
	mh18mXsai0SHYHh4htj1/F3byuf8tJ8WsFUl9VZT2f6XbXLqLsyHg/vonksJuUZasL0p9RpkVD9f+
	QKfrxgc63H57cKEVt1WWfPvngOFcNp4ntdCKczoL+MBIED7dQ0xALx3+ImFGHpoj2KpTH4khVF+AF
	6WNujyRW4w+n8x5kFes3tiz17ZUGK3e0bYNpRF5VfEPIKp5auoKSF3MPfUJfXuxVDENFX5EKXZsHf
	2OOpaiBgFE2q9DsKTQtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guAnB-00016M-IV; Thu, 14 Feb 2019 06:46:41 +0000
Received: from mail-eopbgr700072.outbound.protection.outlook.com
 ([40.107.70.72] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guAn7-00015z-Ru
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 06:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJ6EM9kIx4GmxskcuPTvxAz2iinfTJQ1EZKhXuD8+/E=;
 b=r2OgGNSK+IRpiauDV24o4tF70ZrGptmniPXUxxXVlSjMIf2xGncRzGEo2cqI2QhBR+0Cx6meBvk083GAiHE10ELGLqQrblkA5v8oD57L6U0Q1Os2njhVbdYQTxnq4i1lN2OXYkGV3STjl7EpB5xrB+Ch/8dVDzdejQGt8ZEblR8=
Received: from BL0PR02MB4915.namprd02.prod.outlook.com (52.132.14.88) by
 BL0PR02MB5650.namprd02.prod.outlook.com (20.177.241.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 06:46:33 +0000
Received: from BL0PR02MB4915.namprd02.prod.outlook.com
 ([fe80::748b:306f:c718:fef3]) by BL0PR02MB4915.namprd02.prod.outlook.com
 ([fe80::748b:306f:c718:fef3%3]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 06:46:33 +0000
From: Shubhrajyoti Datta <shubhraj@xilinx.com>
To: Michal Simek <michals@xilinx.com>, Anssi Hannula
 <anssi.hannula@bitwise.fi>, Michal Simek <michals@xilinx.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] serial: uartps: Fix stuck ISR if RX disabled with
 non-empty FIFO
Thread-Topic: [PATCH] serial: uartps: Fix stuck ISR if RX disabled with
 non-empty FIFO
Thread-Index: AQHUxC+EUWJfgmi20EimzoUqpZ0uAKXe1t9Q
Date: Thu, 14 Feb 2019 06:46:32 +0000
Message-ID: <BL0PR02MB491508D8FDFECD3211BF1943AA670@BL0PR02MB4915.namprd02.prod.outlook.com>
References: <20190206140813.15349-1-anssi.hannula@bitwise.fi>
 <d58d8b99-71ee-d9d4-7217-767cc09989ac@xilinx.com>
In-Reply-To: <d58d8b99-71ee-d9d4-7217-767cc09989ac@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shubhraj@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71abb34c-b6d6-413c-98b2-08d692482848
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:BL0PR02MB5650; 
x-ms-traffictypediagnostic: BL0PR02MB5650:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI1NjUwOzIzOmdHV3Jib1dpSTh3Z2IzUy9EU05LV3hZL0pI?=
 =?utf-8?B?MXQxMG9zSnhLSkNla0ZTNzZjWGRiWE5BdFIrQ1htOHFXdDgycXFrYzFRMHl4?=
 =?utf-8?B?VDkwUy9VcWtaNGFWT29PV3o1d0FNT3dBOHd5emZnM1Zna2VtdGw3a3NsbEc5?=
 =?utf-8?B?dnlEbnI3ZXljOFkzcFlWK1grZXg1N1pCa2VWcytvajhGRFNxTFl4L2xTTkhw?=
 =?utf-8?B?emNkWnltcnlGRmhWOE96eitwOHA0eGVQVXFaR21MaGFSdjc1ZkVVdW5QYm5V?=
 =?utf-8?B?bUZYVnNWajNrcERvUzhYTlR6ejlhZk1qdFc5TE0wS0lmcmtKc282UHZhQ21R?=
 =?utf-8?B?Y3UrYm9ZaWo2WDVmUTRaTzRPOGpQTjJYRzFzRlFUUTI1Nm0rK3gzdEMrU1lQ?=
 =?utf-8?B?OXkxdmZYTk92OGgxNTRURWRncTJuOCtsSkFVem0rY0RwY05WeG9yRmZhUCtO?=
 =?utf-8?B?RkhzMDhNVHFRQVoyRTlVQW5mT2tRNlkrNVpBRXZaVmxGOS9GdVFOSHI3MC9o?=
 =?utf-8?B?OVlYeXRQaGdZSTVSWmxqNWF1VHYveVRRTkRwNnRSNVVJdTdTaFkyTW42SmRi?=
 =?utf-8?B?allDbElwMXdqd1NjSUVzTnlQdnl4OXlPREdOaTNBWFRCWnhaRjlNSFNNRjBY?=
 =?utf-8?B?V1M3OWFYSjVFaUZJVVNTQ2gySGlnRU9NWEpjZVMwbWloMzNtOGdQZlNZNVpJ?=
 =?utf-8?B?cG5rY1N3M0h6Mng1WEZUSUdKa1NvRnhCMk9KN3NDVjlCaWxUbHFhZmZhcGV2?=
 =?utf-8?B?YzVuTkVTUFRLVEgzeHhlbmZneG9veUtKNldGTnVZeGZ1a1pPM05Bd2pCbkNZ?=
 =?utf-8?B?QXE3SWZmOTR1d1FLVVIxS1RmT1hyQkJVTDI4cUx2QVd1VzEzaU9SMHlvZFMw?=
 =?utf-8?B?MmJyUmR3aTF1TDFPNHVwVkRvdHhEM25iKy9uQkkrbEpKcVByandOUjJvN2xu?=
 =?utf-8?B?ZXVwUWtmdE9sL0djeGhIemY3Q1ZLZWVIbDNjWUgrbFcvSkhSeVQ3THdXdXpS?=
 =?utf-8?B?K05PeVZ5Z1lIUVBTKzdNQTVQUFIvWUhINmpFSmx4TUdxOERCbnI4S2NGUUJN?=
 =?utf-8?B?QURIQjVtbFlUaUI2RXZQb0pOUkIrWEJJczVBYlBUV1puQURaYU84OHpodUxx?=
 =?utf-8?B?a3JYdUFXcUNFeXU0Y0Z0VkY1U1BOSDIxQ1pWOFRwR3VRT2JPV1E5SXphR1ZJ?=
 =?utf-8?B?WkpYQTBwSHNiOHNQM0RubTJ5ZnNiOERSN2NNVTBBZit1eGl3M3d1Y2FaTmhj?=
 =?utf-8?B?WWtWcnd4YkEyTmdJREdJWmYrV1F1YzUvSmNhRC9TSlJ3M05HV0ZoN0JaUzBa?=
 =?utf-8?B?RzlqVjVPU1YvUTdoYW85MXpHWG1BcWNUUUZaTEtBcG4weXNCZ1JmUHhvYVVV?=
 =?utf-8?B?MUxBcDdxMWJQRFhTNDJHS051blZuZEcyMUFrcDBpT0wrQzRzMjJ6eHFxanRL?=
 =?utf-8?B?clJ6VXp2Y3NmUi9rVndRME9Jd21EQUM5OEtPWksyUzZLQ2R2cmhrdXQ4NFIw?=
 =?utf-8?B?dXZYZDdxRVJ1L1VBaVBzSkt0TXFyMUZTVC9INzArczBPc01tOTBUMFNram9P?=
 =?utf-8?B?ckhPMFNVdFRPVHFzUVJUWTNWUXhLWXRBZVEvYnJVeGJJZDRCUkhGbTNKc1lm?=
 =?utf-8?B?cHdSSHB2QWhjNFZSanlwakVBdC9Cd1JQa0RmWEt1OFFHcVU3ZWg5d0l5Q1cw?=
 =?utf-8?Q?h0jLg8NyHQhyH6j9Gs=3D?=
x-microsoft-antispam-prvs: <BL0PR02MB5650AE04BB33F969542E7C40AA670@BL0PR02MB5650.namprd02.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(199004)(189003)(51914003)(13464003)(14444005)(66066001)(8676002)(25786009)(256004)(81156014)(81166006)(55016002)(97736004)(6246003)(76176011)(486006)(186003)(7696005)(71200400001)(71190400001)(8936002)(9686003)(110136005)(7736002)(54906003)(86362001)(53936002)(4326008)(229853002)(316002)(305945005)(6436002)(478600001)(74316002)(14454004)(6116002)(3846002)(33656002)(99286004)(26005)(6506007)(476003)(11346002)(53546011)(68736007)(106356001)(2906002)(446003)(105586002)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR02MB5650;
 H:BL0PR02MB4915.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K60ikd139iYeKws7e2vkrWBuj9ZK8N5cSMNORW16cxErjyMeEWDMi37vuntJzVveRYRUxIlnm/MqoMTRjLiMEdVamzbkOGmcfCR0WlW2hm3X3jc3JTxAT7nxUGLCos7E0uLXNKZyL46IjZwd19B9mWPepubHjZpjdyO6lHw4FB7RZMBaCrtx3cWbw3Z7RYANfpp48Kz0fo7Cj3PrgyuezycEmmDXwU7wIoAE6sZcpJ+iOqJrZv1Jif4i0Yl58oElK2b/FMBWogvmVH07qo7f9C1cvBflUE+x0b6/R6Q8IrubhyS7DpeFXqhllq3c3JUsRgWx+axu2auhzquDUZtpEsnd7B+HRGilTw+tLCIp+Z87HTkmb8IJxUuuY05Hx1YjQ9rVzBNMo4H/gN5WGYUj/6tP8gJ0hTX1X87whSXwO6w=
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71abb34c-b6d6-413c-98b2-08d692482848
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 06:46:32.8018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5650
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_224637_917477_A4F19AA9 
X-CRM114-Status: GOOD (  21.36  )
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
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi  Anssi,

Thanks for the patch.

Minor nit below.
The call to the cdns_uart_handle_rx could be prevented in  cdns_uart_isr 

> -----Original Message-----
> From: Michal Simek [mailto:michal.simek@xilinx.com]
> Sent: Thursday, February 14, 2019 12:06 PM
> To: Anssi Hannula <anssi.hannula@bitwise.fi>; Michal Simek
> <michals@xilinx.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>; linux-serial@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; stable@vger.kernel.org; Shubhrajyoti Datta
> <shubhraj@xilinx.com>
> Subject: Re: [PATCH] serial: uartps: Fix stuck ISR if RX disabled with non-
> empty FIFO
> 
> + Shubhrajyoti
> 
> On 06. 02. 19 15:08, Anssi Hannula wrote:
> > If RX is disabled while there are still unprocessed bytes in RX FIFO,
> > cdns_uart_handle_rx() called from interrupt handler will get stuck in
> > the receive loop as read bytes will not get removed from the RX FIFO
> > and CDNS_UART_SR_RXEMPTY bit will never get set.
> >
> > Avoid the stuck handler by checking first if RX is disabled.
> > port->lock protects against race with RX-disabling functions.
> >
> > This HW behavior was mentioned by Nathan Rossi in 43e98facc4a3 ("tty:
> > xuartps: Fix RX hang, and TX corruption in termios call") which fixed
> > a similar issue in cdns_uart_set_termios().
> > The behavior can also be easily verified by e.g. setting
> > CDNS_UART_CR_RX_DIS at the beginning of cdns_uart_handle_rx() - the
> > following loop will then get stuck.
> >
> > Resetting the FIFO using RXRST would not set RXEMPTY either so simply
> > issuing a reset after RX-disable would not work.
> >
> > I observe this frequently on a ZynqMP board during heavy RX load at 1M
> > baudrate when the reader process exits and thus RX gets disabled.
> >
Reviewed-by: Shubhrajyoti Datta <shubhrajyori.datta@xilinx.com>
> > Fixes: 61ec9016988f ("tty/serial: add support for Xilinx PS UART")
> > Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c
> > b/drivers/tty/serial/xilinx_uartps.c
> > index 094f2958cb2b..f0c4f59d9314 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -219,6 +219,13 @@ static void cdns_uart_handle_rx(void *dev_id,
> > unsigned int isrstatus)
> >
> >  	is_rxbs_support = cdns_uart->quirks & CDNS_UART_RXBS_SUPPORT;
> >
> > +	/*
> > +	 * RXEMPTY will never be set if RX is disabled as read bytes
> > +	 * will not be removed from the FIFO
> > +	 */
> > +	if (readl(port->membase + CDNS_UART_CR) &
> CDNS_UART_CR_RX_DIS)
> > +		return;
> > +
> >  	while ((readl(port->membase + CDNS_UART_SR) &
> >  		CDNS_UART_SR_RXEMPTY) != CDNS_UART_SR_RXEMPTY) {
> >  		if (is_rxbs_support)
> >
> 
> 
> Please review.
> M
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
