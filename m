Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C10AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:34:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BE62147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JQ7qyIXJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UGHTtww2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BE62147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=vKJe/pVcafsIsO8dUaIc1Frd/hL7egtrAXHYoXHAoY4=; b=JQ7qyIXJ8y2gzd
	X5YPKcCbpqwfsN/Hdxcg8rKJUM3/cuvhDYwNfVu5cLnrzs5ZLYf8d2i7MNHWF0MKtDkxU81azSr4v
	mfyw5m7ETSt60Mf3Xv1sa46b5qSxBwU+RpmHkWsYRbtedxhbmb5d6u9x/HmJOGO5D0aSatER3AdmO
	0kgSpqEL29mMhkXsrBTmNWhWT7m/31iwMXPcT1G4C0zdimlWYUe4vqNN2lOiUuvFpDRmh+0etMxrO
	QYujCZmGJKMOWIrpvbLoU2uqVJgqfFHYwA6E/czd4VnPZbtBrqRCUog91myWqEnran9eqvowR5kgq
	5ARa/mZ4c4NICQ5SgNpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwisW-0003mW-Jq; Thu, 21 Feb 2019 07:34:44 +0000
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]
 helo=smtprelay.synopsys.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwisT-0003lz-Aq
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 07:34:42 +0000
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com
 [10.13.135.209])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtprelay.synopsys.com (Postfix) with ESMTPS id A4B2410C1A4C;
 Wed, 20 Feb 2019 23:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1550734477; bh=uokFOuv6tBtdBlUiH3P/CjqI5s7Ma/vqrhbGl+A9UkM=;
 h=From:To:CC:Subject:Date:References:From;
 b=UGHTtww2UgXOr5dIsGI+yRCAbS6yBbloxc7AIxvSrr76nzSUyIleIb/hG0jGwDAJq
 gC1yoyFw8arOsbOvjOXAqT3P6W5yqa8MMAGbAZzszrDf0QsU/F2Y1sRZ/1VVcdwaL2
 YS4dfODftopCbRkh3BZx7kcHNygKPF1PETqv7dylEnl2WODIexb6WplHIevOy2ImUB
 NtX5KkvOO2aXiO/T+iBNc0njm9NroFyBRaViBKFKvukJ8K7q6yfm2/G7+rjl9ettDE
 ZwVTKUPj7HD5H3EBJ8FU5rpcp8li8fphG3pMWB1yEXTV8/UaodWknl+n4ktI9CWuZy
 t5mlr/rC87YGw==
Received: from US01WEHTC2.internal.synopsys.com
 (us01wehtc2.internal.synopsys.com [10.12.239.237])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mailhost.synopsys.com (Postfix) with ESMTPS id 5C4ABA005D;
 Thu, 21 Feb 2019 07:34:36 +0000 (UTC)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 20 Feb 2019 23:34:36 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id
 14.03.0415.000; Thu, 21 Feb 2019 11:34:32 +0400
From: Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: dwc2: suppress confusing warnings on BCM2835
Thread-Topic: [PATCH] usb: dwc2: suppress confusing warnings on BCM2835
Thread-Index: AQHUyIA5UYjkxWU/hUaCTTb8E2c/Vg==
Date: Thu, 21 Feb 2019 07:34:31 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7DF40C@am04wembxa.internal.synopsys.com>
References: <1550600574-3674-1-git-send-email-stefan.wahren@i2se.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.132]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_233441_422018_5BBBF359 
X-CRM114-Status: GOOD (  12.36  )
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
Cc: Felipe Balbi <balbi@kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stefan,

On 2/19/2019 10:23 PM, Stefan Wahren wrote:
> According to the BCM2835 datasheet the used Synopsys IP isn't a LPM-capable
> core. So disable these features and suppress these confusing warnings:
> 
> dwc2 3f980000.usb: dwc2_check_params: Invalid parameter lpm=1
> dwc2 3f980000.usb: dwc2_check_params: Invalid parameter lpm_clock_gating=1
> dwc2 3f980000.usb: dwc2_check_params: Invalid parameter besl=1
> dwc2 3f980000.usb: dwc2_check_params: Invalid parameter hird_threshold_en=1
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>   drivers/usb/dwc2/params.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 24ff5f2..a158abb 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -47,6 +47,10 @@ static void dwc2_set_bcm_params(struct dwc2_hsotg *hsotg)
>   	p->max_transfer_size = 65535;
>   	p->max_packet_count = 511;
>   	p->ahbcfg = 0x10;
> +	p->lpm = false;
> +	p->lpm_clock_gating = false;
> +	p->besl = false;
> +	p->hird_threshold_en = false;
>   }
>   
>   static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
> 

What about to apply below patch:


diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index c1912627a032..6b86aa42f003 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -303,11 +303,17 @@ static void dwc2_set_default_params(struct 
dwc2_hsotg *hsotg)
         p->reload_ctl = (hw->snpsid >= DWC2_CORE_REV_2_92a);
         p->uframe_sched = true;
         p->external_id_pin_ctl = false;
-       p->lpm = true;
-       p->lpm_clock_gating = true;
-       p->besl = true;
-       p->hird_threshold_en = true;
-       p->hird_threshold = 4;
+       p->lpm = hw->lpm_mode;
+       if (p->lpm) {
+               p->lpm_clock_gating = true;
+               p->besl = true;
+               p->hird_threshold_en = true;
+               p->hird_threshold = 4;
+       } else {
+               p->lpm_clock_gating = false;
+               p->besl = false;
+               p->hird_threshold_en = false;
+       }
         p->ipg_isoc_en = false;
         p->service_interval = false;
         p->max_packet_count = hw->max_packet_count;



Thanks,
Minas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
