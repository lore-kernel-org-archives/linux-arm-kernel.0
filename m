Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90D5C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:50:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99274218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fNt4yIdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99274218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UXyNUDmQZ3gETUT30fF/FzIgAiqt++S3Jd+PsLxzFz8=; b=fNt4yIdHc7OCM0
	qgAVFPlzgtV5HDa1S1v34dsm6+VC+rlcI92WyshWZnhGr1JDFVhHj3/nV7s7rZeHywvKAeC7Dn6Db
	CNQppdnr0AcDNrLOjykzYZPMBeEW5xBRnWbzeKwkZaqRfK5tgb43hRiCK0jHllCPtP/dlBXN9P3ZX
	qBS5SQRaqPkOVJrRchyXpRV27puddCM431bMIDoQZeKqbxdxcuhu6RvltlbHvUTXr2oWtuICkHEgM
	ZLSsg60gt0YFvfg0dpz44DhcS36RyekeUn/plXGxBtUINOY7+B6M1483MZhWBwg6Bb+zs21ws/+i4
	PL5KGf8wt0VEzLk0G5Gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gos8N-0005tV-2k; Wed, 30 Jan 2019 15:50:39 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gos83-00051N-7L; Wed, 30 Jan 2019 15:50:27 +0000
Received: by mail-oi1-f194.google.com with SMTP id m6so19539435oig.11;
 Wed, 30 Jan 2019 07:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=P2qq8+E4g/m+cCmMeaSfpaPEUpdAovlDLmemICtL6O4=;
 b=tcM+vgLB+xuq2YHhK67h3a2mmnXHaQJ6mlJ+DKneMqRyv7CRW/ok+IDMs7yzPoqlIO
 DmTzK4+A6Vh6QMHsPxUb4dF+mTxxZsS9wS8MM4YCqZZibzFCCrgroyQh9SnuySk1Gcyk
 Py/fs5EHtq+9oyOR3FhlHxvu/wQyNnR82fw6meVXSxXZ+g9VoHAd/lkdS0MEhNRhs7y+
 AnZ8juuuoJSKexokN/F02d+xQ5HyK5uN+l1vJUwSGWSh9eHZA+4QI6gfhPU+ZDPmt+CT
 hKIDGa2zsWw5ryzI3ruPgsbFXMPWJ5gI/PmM936QZlFWg7MnrZpQI48gkrAU+dY9HPUU
 Hjew==
X-Gm-Message-State: AJcUukdhOjm5ceQ0/VKyCN7McGk/mYcVB/3jxgo7t+jjk1QTKwAQvhuW
 pp6GsI3yQi1sBdSusIeUqA==
X-Google-Smtp-Source: ALg8bN7YUdJsKMpCX953MaNa6vxwhOhFB2rvS6C+vX5gSNPtizkLZmOQ0v4ZTva+YKvus3IQry/J6A==
X-Received: by 2002:aca:ba02:: with SMTP id k2mr13254932oif.177.1548863417913; 
 Wed, 30 Jan 2019 07:50:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t201sm751720oie.37.2019.01.30.07.50.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 07:50:17 -0800 (PST)
Date: Wed, 30 Jan 2019 09:50:16 -0600
From: Rob Herring <robh@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190130155016.GA26536@bogus>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
 <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548693481-1162-3-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_075019_757055_FB787686 
X-CRM114-Status: GOOD (  16.75  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 05:37:59PM +0100, Loys Ollivier wrote:
> Add binding for Mediatek-based GNSS receivers.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v3:
> Removed the I2C and SPI interfaces references.
> Removed the "mediatek,mt3339" compatible line.
> Added the optional propertied (reset, fix)
> Added the pin names for the optional properties.
> 
> v2:
> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> Moved current-speed as an optional propertie.
> Removed the status line in the example.
> Added "mediatek,mt3339" compatible.
> 
>  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> 
> diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
> new file mode 100644
> index 000000000000..00650d81c5c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> @@ -0,0 +1,37 @@
> +Mediatek-based GNSS Receiver DT binding
> +
> +Mediatek chipsets are used in GNSS-receiver modules produced by several
> +vendors and can use an UART interface.
> +
> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> +properties.
> +
> +Required properties:
> +
> +- compatible	: Must be
> +
> +			"globaltop,pa6h"
> +
> +- vcc-supply	: Main voltage regulator (pin name: VCC)
> +
> +Optional properties:
> +
> +- gtop,reset-gpios	: GPIO used to reset the device
> +  			  (pin name: RESET, NRESET)

reset-gpios is the standard name.

> +- gtop,fix-gpios	: GPIO used to determine device position fix state
> +			  (pin name: FIX, 3D_FIX)
> +- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
> +- v-bckp-supply		: Backup voltage regulator
> +  			  (pin name: VBAT, VBACKUP)
> +- current-speed		: Default UART baud rate
> +
> +Example:
> +
> +serial@1234 {
> +	compatible = "ns16550a";
> +
> +	gnss {
> +		compatible = "globaltop,pa6h";
> +		vcc-supply = <&vcc_3v3>;
> +	};
> +};
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
