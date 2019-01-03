Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB86C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:33:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E3921479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GHEY23+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E3921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qfACJoNO9YZVTAqcIM2EQpT59i9aBIqGWen3SRUucHI=; b=GHEY23+L+YDcxB
	bXJ0tI4XjhcYRANYsOM5GNo7jVW3J7LteCDoyRG/GN+LhmVWEUrzJ5V4L1wA6NqwL3KHVlAbpICbh
	t1+0mds3vK3ZLglmcDeK8IoxvhHuWh2sySY+yCjq0WDgdWXJfy8EYDLXTag/kW/U1zCqr98b4vTCD
	svxMDIhY1I9yqL5tqUwiIoBtEsqH1AbbnhjoHqsNuTh+C80oy2ulYJ26dLqErM3CrAP3VTgfpRmyC
	GLrExesmLdLelGvQyz/FpFA03IWAenWdKuBbp369KGaWutzPQWKa1qQJ4c97c1LpiO5i08+gq9qCk
	FiTPcFUnbd6v2LdI3umg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf9fr-0000Dw-2T; Thu, 03 Jan 2019 20:33:03 +0000
Received: from mail-it1-f195.google.com ([209.85.166.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf9fh-0008Tv-Jr
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 20:32:59 +0000
Received: by mail-it1-f195.google.com with SMTP id g76so47015164itg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 12:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wyWKg6QQzd0++yCE9tpTni4D+CKDpBnDQ5Ci3BNJi0Y=;
 b=EwCJy7bwSfcTBiJUZX3hmpVnIHf1qVBXugFP3YfhnNHU59RkCFnmN74DdPrx+8h24u
 PiAjkr5BgdgiPnoZ4m1hKvuSqO8vYfghlYv3tqLxjANHrowD1uzhJV/Ik9jy3NZ5o6yh
 5IA8XXVrfofWUBWopiuBs2Yj8RKF8mHGT2R68qeJYCw+6GkihlQrg8MyOAlc70hfACLq
 nLgz9Na4DvZixQHNsyrpuJ6Y3p9xs6MkJnXnzKPESnpMYCuDbNmVMvuN5SLolOhTYDAj
 YQeUfABpBF+qmG6QIGawUKuQmpGRiuMQK8svFZjYEEdM83zjbs4frCJj/i4r4Kzufgrz
 zWnw==
X-Gm-Message-State: AA+aEWbLCajskYHEwUy5u69160lwdBaAIzMDuwVws/TNKyXjmvhQ9YjI
 guNx8ybXkVMHCnPfWFuDxw==
X-Google-Smtp-Source: AFSGD/UzXtwBazWW5K2Xjqcep1RMKY7loZ0PhnQZmAs35pHtrip8bYTcwIK/qMOb75FEUdWltO46Ug==
X-Received: by 2002:a02:8785:: with SMTP id t5mr33960534jai.73.1546547572332; 
 Thu, 03 Jan 2019 12:32:52 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id d199sm26395152itd.31.2019.01.03.12.32.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 12:32:51 -0800 (PST)
Date: Thu, 3 Jan 2019 14:32:50 -0600
From: Rob Herring <robh@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH 2/3] Documentation: DT: Add entry for DPAA2 console
Message-ID: <20190103203250.GA18731@bogus>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-3-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545406240-3061-3-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_123253_932390_B7E486DE 
X-CRM114-Status: GOOD (  16.29  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 21, 2018 at 03:31:11PM +0000, Ioana Ciornei wrote:
> This patch adds a devicetree binding documentation for
> FSL's DPAA2 console.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  Documentation/devicetree/bindings/misc/dpaa2-console.txt | 11 +++++++++++
>  MAINTAINERS                                              |  1 +
>  2 files changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/dpaa2-console.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/dpaa2-console.txt b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
> new file mode 100644
> index 0000000..f4e16b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
> @@ -0,0 +1,11 @@
> +DPAA2 console support
> +
> +Required properties:
> +
> +    - compatible
> +        Value type: <string>
> +        Definition: Must be "dpaa2-console".
> +    - reg
> +        Value type: <prop-encoded-array>
> +        Definition: A standard property.  Specifies the region where the MCFBA
> +                    (MC firmware base address) register can be found.

What's the relationship between MCFBA and the console? The binding 
should describe the h/w block or firmware interface not the feature you 
want to implement. Are there other functions provided by the MC 
firmware?

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
