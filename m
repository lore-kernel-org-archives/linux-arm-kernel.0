Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA813C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:29:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74BC2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J7Lj8nv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74BC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lC5XwS2aj7RdCK/k5IC6NxHgSi6S6iZHHySZjvk3n1U=; b=J7Lj8nv7JyRDNq
	goDAcDicVWbumdpaMQrvdzvh41laAn3Wa4jQssfx5g7MtpWELcB/L3QCV+7ljOddo2wxDxo/3yg3J
	WKA5uwQkvIbUPwhTyJiQPbwGZnr5+orfI3gyEgMlRRyawDnpa4UI6kSmDNRsCyvreK9yEY1LWslzY
	i/dXvn/xnQapAnGCL/8PFAgahaFlon7FU3gX1AYsqXRvM5IYajujjWVg8RCN12Wsxp2ta6X6hyYXK
	qpPnLw4NfemcO3qvNCx6VeO4RNZFOSD30jTY4ffVyX17G5YprVLhIfzoW+/lk8iVORemO9H2gLwsQ
	MSvh6jkb2E6EjWPimxYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWU2u-0004LC-Md; Mon, 10 Dec 2018 22:29:00 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWU2r-0004Jx-Pw
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:28:59 +0000
Received: by mail-oi1-f195.google.com with SMTP id h25so10438160oig.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=x52jxDVnYyc/nJ0TF5Uu7Cb+36Wn0tQj02hikO5MTiU=;
 b=jMOnw6Hi/dKIa1wbB6hM7eUS4+juBw823rZ8EDl4yNbBIZIciNmEmBxCS0AYXGmuUx
 At9dqPaApvLxzQfVj31p1lF5WVoBfl4dVMh2doecNlxAP3v/aMHaLWBcbfI/CzG2JFiK
 oLS2sdH0xl74tA6Ei+rqJ8ZePddALR2P1pOK/ZkE+DoYYYR4IhXwfYKmUZ6tjkgQ1g9J
 2GBJNQqHIkFElXT/UwvH4rD0WHy60QmhBNZnC1OXDy6nw7PQNTrHpLvmBSnfgA5t74/T
 4derP3NxRMTGDRA2MSaXm+/tjTlnIntwGcCiGFXfpPL+qVNBooIUUrU+Ym5uDa7VsVoG
 Li5g==
X-Gm-Message-State: AA+aEWYq2fI1XUHXYSuIUVAy62NhtpoUv5yEj3ryY5qjNwKit8tW937/
 O8fHxBfLplGKxtzMmzW9qg==
X-Google-Smtp-Source: AFSGD/VnCsnT+TV5aLn5Geh7vnUYfpffkIxR11UO/EDRv+HVIqSxSrLPfHiESwGWhEdOwH1c75hfdA==
X-Received: by 2002:aca:7581:: with SMTP id q123mr8792160oic.176.1544480926946; 
 Mon, 10 Dec 2018 14:28:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id z191sm8133883oig.3.2018.12.10.14.28.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:28:46 -0800 (PST)
Date: Mon, 10 Dec 2018 16:28:45 -0600
From: Rob Herring <robh@kernel.org>
To: Andrei.Stefanescu@microchip.com
Subject: Re: [PATCH v3 1/3] regulator: dt-bindings: add MCP16502 regulator
 bindings
Message-ID: <20181210222845.GA9114@bogus>
References: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
 <1543917126-32572-2-git-send-email-andrei.stefanescu@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543917126-32572-2-git-send-email-andrei.stefanescu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_142857_843099_3520FE34 
X-CRM114-Status: GOOD (  13.36  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 Andrei.Stefanescu@microchip.com, Claudiu.Beznea@microchip.com,
 Cristian.Birsan@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 4 Dec 2018 09:52:28 +0000, <Andrei.Stefanescu@microchip.com> wrote:
> This patch describes the compatible and the device tree
> bindings necessary for the MCP16502 PMIC.
> 
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
> ---
>  .../bindings/regulator/mcp16502-regulator.txt      | 143 +++++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
