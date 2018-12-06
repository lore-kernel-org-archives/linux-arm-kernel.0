Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FACC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:50:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF9920868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KgH1KTQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF9920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cfQoc3cuy4t3U5SmGRzGekSx7Dczzdyl0m0Qs0ijpvY=; b=KgH1KTQlSKlsoy
	U3j/WDS+y3dLaA0UUle81d66cvOneF8vndH8xxs5Sd/Ir6dtyhXhzzbeIZB5yFNMQOAske1DAxqrB
	hGyA3l3KxGPQi16FuUho+QHneYY544wWT9IShj1LP8kDt2v8XNeMOy7dRtf2+rZzMsNurKxPC4sDc
	bldMY4LSWVosXTSbMJ+VuulEq1ZhMpS/Q/7i6ajrK81OuIYY1fmTP2yoUjk4wiPyaRFZKAaRI+AE/
	fxn8NDhgUzlQJK/PJB66TA1iD5d56MgFMQsb1iujlIiykDUKhJ2m5eXbUTPit+CeSfHJ9U7wVsdVw
	B89VpuQu7lNXZwW/ZTxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV3P5-0005ZC-H4; Thu, 06 Dec 2018 23:49:59 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV3Oz-0005Od-Hx; Thu, 06 Dec 2018 23:49:57 +0000
Received: by mail-oi1-f195.google.com with SMTP id c206so2008581oib.0;
 Thu, 06 Dec 2018 15:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nvHe7RxPCO8TqXbIaezcqxapqJwp1RbMs5HbkEHmwtE=;
 b=kJyLMD9k71SuU6g4yhI7kEFbqn9B4nXtQnVhcZeqpA7ctLACabOz0wuDSZN17DCToK
 0PZMMoY4urGdzMWRrutQhkASbNx3DNPUVbBEy6uUchcvzMP6oEQgg88BFkAwM7XO1xuj
 61jkzAl4gzaB3GWSrFYkkRt0TnG2L+Cxm1vc7WgViy89ztfpMxRoR+HvyrtAWVgfOMow
 ZnTEMHFzkhVdCnpLV9v+OnEdEr99wkw3KjRlZQWCcDVkil9A1co/RBf3rDFLAJch9Dfy
 noP13apTLhhk9GGrUaUJsL8TJK9u5IMChqZy2U4rw1tfO6BGyiFSPWTLbhPJaPmUc958
 oadg==
X-Gm-Message-State: AA+aEWaRPwgKMEmBu/xX6jBhbLfafFCnv7BJDG+EiaVCag1KXt7bBHT+
 MbORkH/EhuPyQENGFzDoyQ==
X-Google-Smtp-Source: AFSGD/UQOJhN/b32jDo4Dh5mBOF2ptBz7GCwWoXiqkePbDu+EnrAZBdXbZw3BE1tLtTsUsWtfaPgLA==
X-Received: by 2002:aca:acc3:: with SMTP id
 v186mr17662475oie.274.1544140182540; 
 Thu, 06 Dec 2018 15:49:42 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id z18sm664078otp.41.2018.12.06.15.49.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 15:49:41 -0800 (PST)
Date: Thu, 6 Dec 2018 17:49:41 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/5] dt-bindings: nvmem: add binding for Raspberry Pi OTP
Message-ID: <20181206234941.GA6340@bogus>
References: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
 <1542805904-6446-2-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542805904-6446-2-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_154953_597832_37D74775 
X-CRM114-Status: GOOD (  19.77  )
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
 Florian Fainelli <f.fainelli@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Eric Anholt <eric@anholt.net>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 21, 2018 at 02:11:40PM +0100, Stefan Wahren wrote:
> This patch adds the devicetree binding for Raspberry Pi customer OTP
> driver.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../nvmem/raspberrypi,bcm2835-customer-otp.txt     | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt b/Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt
> new file mode 100644
> index 0000000..041ff17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt
> @@ -0,0 +1,22 @@
> +Customer OTP Memory for Raspberry Pi
> +
> +The VC4 firmware exposes a mailbox interface that allows the ARM core
> +to access the customer part of the OTP memory.
> +
> +The OTP node must be a child node of the Raspberry Pi firmware node.
> +
> +Required properties :
> +- compatible     : Should be "raspberrypi,bcm2835-customer-otp"

Why do we need this child node? Can't the parent instantiate this?

Are there OTP fields you want to expose in DT?

> +
> +See nvmem.txt for more information.
> +
> +Example:
> +
> +firmware: firmware-rpi {
> +	compatible = "raspberrypi,bcm2835-firmware";
> +	mboxes = <&mailbox>;
> +
> +	customer_otp: otp {
> +		compatible = "raspberrypi,bcm2835-customer-otp";
> +	};
> +};
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
