Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157FAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:56:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C524206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GPELlp+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C524206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=loPRlfKyRtB7oQR6qD694wI2T8XaVDcrkwKBrWMKRB8=; b=GPELlp+lXMfnF4YsjEnNfdbW5
	75uQPX/VOA0LHAfp7opTU1V9OBavjO1v+pDBT85lO3u33d6hTcxQWMq/OqCCwoyCEbERHXkx0mV9f
	tru4HrSG/I8QqkOYJmURo0k2mcy10vk2Dcd+EmazFP5r79mqZNpeOfArrUW8aoQJPsbu15inDgdlc
	WESaPXktPpHATyJJwU11pKSMtqJQ+E4xONjLJHYvBr2y5h7W9eUYSQ0Wdmfo5t4hPvreDXAbOJZD7
	p4EcGktBa6WrGnLj6EBIi63s+yI40rM3dMzjsqtYjfltgVf0bXRSThqBvesCdn9zgc3nLIIzErqfA
	dDC44hRdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXuVe-00074R-IZ; Fri, 14 Dec 2018 20:56:34 +0000
Received: from gateway22.websitewelcome.com ([192.185.47.163])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXuVa-00073j-Tn
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 20:56:32 +0000
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway22.websitewelcome.com (Postfix) with ESMTP id C01273F28
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 14:56:04 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id XuVAgGF5odnCeXuVAgR2WK; Fri, 14 Dec 2018 14:56:04 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=51702 helo=[192.168.43.131])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gXuV7-001GHR-4D; Fri, 14 Dec 2018 14:56:01 -0600
Subject: Re: [PATCH v2 3/3] PCI: imx: Add support for i.MX8MQ
To: Bjorn Helgaas <helgaas@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206073545.10967-4-andrew.smirnov@gmail.com>
 <20181214203042.GC20725@google.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <aacb613f-ad8b-8db9-1c63-a346ac62c772@embeddedor.com>
Date: Fri, 14 Dec 2018 14:55:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214203042.GC20725@google.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gXuV7-001GHR-4D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.106.44]:51702
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_125631_006958_482114CB 
X-CRM114-Status: GOOD (  17.62  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 12/14/18 2:30 PM, Bjorn Helgaas wrote:
> [+cc Gustavo for fallthrough annotation]

> 
>> @@ -301,6 +312,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>>   
>>   	switch (imx6_pcie->variant) {
>>   	case IMX7D:
>> +	case IMX8MQ: /* FALLTHROUGH */
>>   		reset_control_assert(imx6_pcie->pciephy_reset);
>>   		reset_control_assert(imx6_pcie->apps_reset);
>>   		break;
> 
> I'm not an expert on fallthrough annotation (Gustavo, cc'd, is), but
> this looks wrong.  It's the IMX7D case that falls through, not the
> IMX8MQ case.
> 

Correct.

> The recent annotations added by Gustavo are at the point where the
> "break" would normally be, e.g.,
> 
>    case IMX7D:
>      /* fall through */                    <--- annotation
>    case IMX8MQ:
>      <code>
>      break;
> 
> But in this case there's actually no IMX7D-specific *code* there, so I
> suspect the annotation is unnecessary.  It's obvious that IMX7D and
> IMX8MQ are handled the same, so there's really no opportunity for the
> "forgotten break" mistake -Wimplicit-fallthrough is trying to find.
> 

Yep. That's correct. There is no need for those annotations in this patch.

> If we *do* want this annotation, we should spell it the same as
> Gustavo has been, i.e., "fall through".
> 

This is a matter of style. For -Wimplicit-fallthrough, "FALLTHROUGH" is 
as valid a "fall through".

Although, currently, there are 1997 instances of "fall through" vs 235 
of "FALLTHROUGH" in linux-next.

Thanks
--
Gustavo


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
