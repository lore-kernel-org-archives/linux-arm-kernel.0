Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE49C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:11:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEECC208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fIyvtHgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEECC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FapMsHbsQKPpH0wKJBpIDHNxOwJNZ46Y34o9QDR3GtE=; b=fIyvtHgCAR9UMg
	7CpFRKy9MfB1TN/QXQtB5Fc5llOpeYn6KNGyTQnOXZ684cmhzASXh8ZGcwiJX0RBXfLZGmXTIzfF0
	b6d76evBAMfTn+Uxuu6JhCurOSgiFrpL1HmNsezQK+qyv6jkhCT3Cdl1/lDPAiwcX/jHH3c1t0bFJ
	rKCUP07eGJnRtUJq1bfG+L5D+7CMLnQseYowuC7IjG5a/dAzZVQopC2i91l0gd2JT4CJ9LXbXVnFv
	nc2W0oaQsYQbyRM6cXX6RRvosod6QsBqJ2Ir6do2uc4A48TkcMOdJeP2F2+mRobACqq5HhXqfv9Ry
	XXI2E3KsHDHl1OiIZogg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU5nb-0007tL-6J; Tue, 04 Dec 2018 08:11:19 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU5nX-0007sv-Jt
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:11:17 +0000
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB486Fm3014091; Tue, 4 Dec 2018 09:10:54 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2p3uhmpc8e-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 04 Dec 2018 09:10:54 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2ED633A;
 Tue,  4 Dec 2018 08:10:53 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ECB42253F;
 Tue,  4 Dec 2018 08:10:52 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 4 Dec
 2018 09:10:52 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 4 Dec 2018 09:10:52 +0100
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Rob Herring <robh@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 29/34] dt-bindings: arm: Convert ST STi board/soc
 bindings to json-schema
Thread-Topic: [PATCH v2 29/34] dt-bindings: arm: Convert ST STi board/soc
 bindings to json-schema
Thread-Index: AQHUi0/Fl0DVGNx0wECLP1s4jzgjA6VuKlsA
Date: Tue, 4 Dec 2018 08:10:52 +0000
Message-ID: <158f1163-3489-3a02-3a37-0ef54148ac59@st.com>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-30-robh@kernel.org>
In-Reply-To: <20181203213223.16986-30-robh@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-ID: <C6D86D7874CABE4FAA6CEA8DA4BD5091@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-04_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_001115_949181_CEE984FE 
X-CRM114-Status: GOOD (  14.76  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar
 Gala <kumar.gala@linaro.org>, "arm@kernel.org" <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Grant Likely <grant.likely@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob

On 12/3/18 10:32 PM, Rob Herring wrote:
> Convert ST STi SoC bindings to DT schema format using json-schema.
> 
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/sti.txt | 23 -------------------
>  .../devicetree/bindings/arm/sti.yaml          | 23 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/sti.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/sti.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/sti.txt b/Documentation/devicetree/bindings/arm/sti.txt
> deleted file mode 100644
> index 8d27f6b084c7..000000000000
> --- a/Documentation/devicetree/bindings/arm/sti.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -ST STi Platforms Device Tree Bindings
> ----------------------------------------
> -
> -Boards with the ST STiH415 SoC shall have the following properties:
> -Required root node property:
> -compatible = "st,stih415";
> -
> -Boards with the ST STiH416 SoC shall have the following properties:
> -Required root node property:
> -compatible = "st,stih416";
> -
> -Boards with the ST STiH407 SoC shall have the following properties:
> -Required root node property:
> -compatible = "st,stih407";
> -
> -Boards with the ST STiH410 SoC shall have the following properties:
> -Required root node property:
> -compatible = "st,stih410";
> -
> -Boards with the ST STiH418 SoC shall have the following properties:
> -Required root node property:
> -compatible = "st,stih418";
> -
> diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
> new file mode 100644
> index 000000000000..47f9b8eebaa0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sti.yaml
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/sti.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST STi Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@st.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    items:
> +      - enum:
> +          - st,stih415
> +          - st,stih416
> +          - st,stih407
> +          - st,stih410
> +          - st,stih418
> +...
> 

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
