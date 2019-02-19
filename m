Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C542C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:57:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A582086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IQt6g37f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bz+zCpw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A582086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RG2Z8cpb39K9MFptSd1HTrUtyr3KL5xfNUVsS3cf+pQ=; b=IQt6g37fx0PmGz
	0IDs7VVUcSdFhGbiBs9NPlGwsUzh/A0EfiO8jNM/sBYdKL9NbjVf6uYYIfLMfrWxEeCxaxy5k75HF
	iZuEgzOaIp4mcCGWffBZQZYiBT+xHqdR+KcLMJ58T/MAkvBOss5UFUtfK/7wH9beRrhJ7c0t+SQ7a
	Y+6nEAA0MZbNiJEukfyxa8A7lqnlA8iwMhk4mnACvuZ2zW3xyAdc0ONgDaMSLJGJj88CEpHxXtyfq
	bAHtU6Td8bJB246zwMIOEHvr0etTTHY99Kk1OIsWl77QODbuarD5Uk4hVHg9/fO6+06BRjCnGPLXG
	jP0KBVR4lCL1HOuZdxBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwCRs-0005jE-4U; Tue, 19 Feb 2019 20:57:04 +0000
Received: from mail-eopbgr150053.outbound.protection.outlook.com
 ([40.107.15.53] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwCRp-0005in-1T
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 20:57:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJvXE1OAldgE/q05edyO+x86sKSIOeHiiflBlLPr7m0=;
 b=Bz+zCpw6xcyTDeHosSh+e26ULxwtcEzvjOCHEb6ykCxx6aJRnabWSuXbAbe7tNEstzi0Mtx2l2zx0mXMPVJFTg52aPufAFw9AH3cwqdSxbSuJT9L0dsWr+78w7NRaL4RUfoaV1qg9av88LMgTdCbcErrg4Wdbvx95fmrGegjtgk=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB4133.eurprd04.prod.outlook.com (52.135.166.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 20:56:56 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948%5]) with mapi id 15.20.1643.014; Tue, 19 Feb 2019
 20:56:56 +0000
From: Leo Li <leoyang.li@nxp.com>
To: Colin King <colin.king@canonical.com>, Roy Pledge <roy.pledge@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH][next] soc: fsl: dpio: fix memory leak of a struct qbman
 on error exit path
Thread-Topic: [PATCH][next] soc: fsl: dpio: fix memory leak of a struct qbman
 on error exit path
Thread-Index: AQHUyFwq50clv2b/DU6TNIT7uzPh/aXnmm0Q
Date: Tue, 19 Feb 2019 20:56:56 +0000
Message-ID: <AM6PR04MB586338893C089939732092468F7C0@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20190219140517.10709-1-colin.king@canonical.com>
In-Reply-To: <20190219140517.10709-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14c6c7e8-1dbd-4fe4-1a9b-08d696acc89d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4133; 
x-ms-traffictypediagnostic: AM6PR04MB4133:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0MTMzOzIzOnM1QUxXK2h3SERwQmQxRXVwMCtrOFgycTFD?=
 =?utf-8?B?VnZnbVc0aWQ2QkhvQWl1cldmWHN3TTByNnZwNWd6aThYODRzS1UrT2lnUHFy?=
 =?utf-8?B?NDRLNjJTV3o5cytTWElsblBMT3k4UWNieXU3ZlV1b1lPWGxDTXROdWlHaFVv?=
 =?utf-8?B?M0NYdldBRm04cmdwMWVjRDB4QVY3WU1FVHBRK1ZrYWVTZzNScU8rL2pvT1pE?=
 =?utf-8?B?VVFKWWJWdlMydWtUWjZZcE96cnhibkRmRU90Z3psS0dXSFdLOHoxelFMMXF2?=
 =?utf-8?B?QXh2WVpLamJocGdrcVRrRlAvNXB3YkZUdmRrdXNXUU5wUXdDVVk2YjAxZWQz?=
 =?utf-8?B?VzNHZ3VucUZmMlVUVVFqSFVKMWRaNUtQMk9JbTF1QmJYNndlV3crY3Fsa0RQ?=
 =?utf-8?B?RnhjYUEwTDNQNS94WjhTaUpEcGNrc0RQR1hPMzVIV2xyV1NQRVIzZE4rSEJ5?=
 =?utf-8?B?eHhzUkpjd1B3OHY5VVNqT09ldisxd3NadmFnZ3NtcUpxQjYwQTdGczREd3lo?=
 =?utf-8?B?QXlmdmFDTEgwZEdCUTBibEFBdkxDY0R6VCtGcGFpWFRpZ1FUVXhXcXBRRFF5?=
 =?utf-8?B?ZmFBSWRRTjdvR1dUZSt3VjJFT0tUQVNid2RoR3ZwT0trb0FtYXk2U2wxU3B1?=
 =?utf-8?B?WXdsNGNrVWJOOWhjTjJISy90L2pzRVkwQjVVNk9XQmZXMVZTZkE1U0dXbHhx?=
 =?utf-8?B?azc4ZnFOYm9oZTJxZVJYeHdDUk81QTZSV0pSQlJpOW11c0JaUnNjQnlDWmdp?=
 =?utf-8?B?eUVuYVBIaUZwVlhGQlpqRGMyWHp5Z0E3RmlReHhQTG5IemY2ejJYQmRXRjRR?=
 =?utf-8?B?amg2QlpKbjRGRlFzWHVIWFlOWDNUbnVLbjQ5WVRGalNPMFR4T2JHYUhyczFX?=
 =?utf-8?B?Y1RiZ1F6Q3ZsOU1WWEl6Zk1vbGdWMXR5bEswSVR5NG1QRkFTcVBqVUprTW9v?=
 =?utf-8?B?Vm04bGtMbjJ1ejdjREJhQnhoZUdLcGw2WXVXV1BFSTVPWEhSaEZBQ1p6SVB1?=
 =?utf-8?B?TjVQTXYrcEFSbkxRYjBuSzFrSGlSWTBKMmNZdVpxenl0NE9kMXlkeU1JRWx4?=
 =?utf-8?B?bFdtbDRLMWRCZER2czA5M042YVV3ejc0dGo2K1BheTNsaHVVQXV4eWQwTng1?=
 =?utf-8?B?TXM1VGNLUVkyc1cwbG9FM0dZRlphOVJQdHVkYVJxMUpwMVRjaWpudnc4T01a?=
 =?utf-8?B?SnJwOVlGN29YZlE0U0VjcDJ6NHVEbWN3Qy8wS01vQ3J4VnN0VDV4VEhnbi9T?=
 =?utf-8?B?cFNacU5hRU5zOGFHOUNWSmVSNWVpNzZKWmlVZlV6VDQ3Vmp4NmhFbUw1L2xs?=
 =?utf-8?B?RFFBczRjUUpwTEdBeHZXTHVDcDJuMHFCTjA0dE15b2FPQ1I4MU92M1Y2dnZh?=
 =?utf-8?B?TENCcy9tUk1QdHdFaWJxTGNmaGFUVXZ6MThnK2t4a3NIdlczVnNYSncvWmNm?=
 =?utf-8?B?Mm05WW9XdEQ5Q21GVTJDQ0w1RVhhTWRZM1pqVEF3cmNhZjhkVmtNU1VyblZY?=
 =?utf-8?B?SFJjSnFzbGJXSkpmNHNkTUpOTm01UThnTldiSzZkSlIyUTZmbklOS09jbGlT?=
 =?utf-8?B?UVBOUXJQRFlPUGhJRkZSUjBueDJKWVdYQUg2UnY4NVFQakRSWjAyQWNwdjFT?=
 =?utf-8?B?aE41dnd1ZnVpZUQxTkJZSFRpSS9vRWVCdllBSXhMZ1lOSXBJRW1yTHRlNUhW?=
 =?utf-8?Q?gPT6EOXsvyQE0SBxJEu+p27mj6ZWAILyl5/MWhO?=
x-microsoft-antispam-prvs: <AM6PR04MB413334EA38A138B88F28ABD08F7C0@AM6PR04MB4133.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(13464003)(199004)(189003)(86362001)(2201001)(68736007)(186003)(102836004)(3846002)(76176011)(26005)(305945005)(55016002)(97736004)(6246003)(53936002)(5660300002)(8676002)(66066001)(229853002)(7736002)(81166006)(81156014)(74316002)(4326008)(14454004)(99286004)(256004)(6436002)(33656002)(110136005)(316002)(8936002)(54906003)(2906002)(7696005)(476003)(9686003)(478600001)(25786009)(106356001)(11346002)(105586002)(446003)(2501003)(6506007)(6116002)(53546011)(71200400001)(486006)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4133;
 H:AM6PR04MB5863.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jVzGEMKau2jiKD0q8TS3S7SCavfV2yhr+Gkx0sT4SsC6TeWX1SG3lNZn8MSS0vZcPICM4Yh1a+K7QU54lfKKAGCn6KB3QbBbwxxkUKj92OtRSuvQoV/8VpxmPmHg8+JR7lGbZ50PWF76yNkciKFKdeTsOAra7IDGqca+2G+p+v3pYVwitdpBSjOY2H+BVtVHZVDF9zNFW/i1w2eeYxAUEZWmdLSgZvtGeNfCZbRRuI5A5iz3rELhAB+M1RIrEE/pIuXJHy5wgCqvQ0C1mY2WGKcU6UqY9E/Kr//eaIWo6Aj6ybm5oxst9XV9B7/pDuRtS8lwUzxBBflNkSCxIlLL/ImdiyAdcr54TwvkP7/gbYMkqT5buPt6allrV7E4hTT17qk3gGgNd2sR1bDF4PB2SThPThUOhe7eTCK23OA329k=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c6c7e8-1dbd-4fe4-1a9b-08d696acc89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:56:56.2823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_125701_086912_E513F1C0 
X-CRM114-Status: GOOD (  16.02  )
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
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Colin King <colin.king@canonical.com>
> Sent: Tuesday, February 19, 2019 8:05 AM
> To: Roy Pledge <roy.pledge@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH][next] soc: fsl: dpio: fix memory leak of a struct qbman on
> error exit path
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the error check for a null reg leaks a struct qbman that was
> allocated earlier. Fix this by kfree'ing p on the error exit path.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next.  Thanks.

> ---
>  drivers/soc/fsl/dpio/qbman-portal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/fsl/dpio/qbman-portal.c
> b/drivers/soc/fsl/dpio/qbman-portal.c
> index 0bddb85c0ae5..5a73397ae79e 100644
> --- a/drivers/soc/fsl/dpio/qbman-portal.c
> +++ b/drivers/soc/fsl/dpio/qbman-portal.c
> @@ -180,6 +180,7 @@ struct qbman_swp *qbman_swp_init(const struct
> qbman_swp_desc *d)
>  	reg = qbman_read_register(p, QBMAN_CINH_SWP_CFG);
>  	if (!reg) {
>  		pr_err("qbman: the portal is not enabled!\n");
> +		kfree(p);
>  		return NULL;
>  	}
> 
> --
> 2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
