Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1D0C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:35:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5A720837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZcivJL+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5A720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uvLF0RJQ/X+Ask+LoieNe6DStGGfpwMAPPcscjCVGOU=; b=ZcivJL+0IPvVrQ
	8WqxrYBLw+h40vrBmuOeyVmtw+vpX52CV7H8UZPfUa5J7CT2vhKIqaaN+vrm5IwbNSISPK3NH7kWz
	NfGvGi6NhSxndPV+5bc+BHfH2IBPO+gvYPKlo/mO2jZt369cseCOL1Dfs/PEkfmeGn7llkunFlLRR
	SDIZAe0foE6TPPB+8Rt8c71iXkfXuJnYUpDfcceTKrSeOabs8b9KoBTxZ8JlRYFrLBDKSg9jx8T7x
	dRqbv+8HizJ+kOtRfYDuk0THJbXwT/KBDhMaPTT+AQy2oui11zIQ8zQ0R1twzYnXRsPyjGUM83wiG
	Qr1ewkt2Nja1rc+3VQmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPeY-0002qJ-N8; Fri, 07 Dec 2018 23:35:26 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPeV-0002pR-VR
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 23:35:25 +0000
Received: by mail-oi1-f195.google.com with SMTP id y1so2976177oie.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 15:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=q2bWIH9ihGljoH/IISkUNN2ujkG0eAQg9/dnWXuF6sU=;
 b=bDXAnu6SNAACnvSaZN67RMi/R5DwzL+O9h2aj/XwuamBLCl/hg0S6lkmyd10H1BdUi
 xfALn5VHW7eoLBNcDndhsKYK0rAcBFG/CxEYR0Em4KYQXzGy5iLcR8WyEVcE9+GqkTA3
 /Cnc3Zv9gFRjgLKoaiM6PQVG93hGG+fK1R08E3+cVhOHo+THvcksEUgN0v9nLFlsoE3q
 ikyd9Pz7qqn3mN2sArhO1r9wB109BGUy5Rr7fu7wmGgaMgAkf/JVxhixjRgqjHvdj59A
 kktoHWLgz6p7D3V11CRgApftkL5kn738+PFYUZZZWe0G5NpGxryUXvU7C8+N3HBB87FI
 WwDA==
X-Gm-Message-State: AA+aEWa8APktLIy4pZgSXAOKlZpr9rfLd3aP5QI2br2rfd4OEfK6hFqv
 +YFzX5wU4Lg9ExlRgjOhnQ==
X-Google-Smtp-Source: AFSGD/UhqK6lbTif8lqNVTBVRcGPbMX9PRvNiI7/GZWewBDEXpkPcxsFRSskeEAXgqYMAfyWEfGEPA==
X-Received: by 2002:aca:ed48:: with SMTP id l69mr2549441oih.31.1544225712984; 
 Fri, 07 Dec 2018 15:35:12 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id w108sm819066otb.6.2018.12.07.15.35.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 15:35:12 -0800 (PST)
Date: Fri, 7 Dec 2018 17:35:11 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 01/15] dt-bindings: Add RDA Micro vendor prefix
Message-ID: <20181207233511.GA9313@bogus>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128135106.9255-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_153524_011727_22FE48C0 
X-CRM114-Status: GOOD (  10.32  )
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
Cc: devicetree@vger.kernel.org, jason@lakedaemon.net, arnd@arndb.de,
 marc.zyngier@arm.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, robh+dt@kernel.org, linux-serial@vger.kernel.org,
 jslaby@suse.com, olof@lixom.net, tglx@linutronix.de, overseas.sales@unisoc.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 28 Nov 2018 19:20:52 +0530, Manivannan Sadhasivam wrote:
> From: Andreas F=E4rber <afaerber@suse.de>
> =

> Add vendor prefix for RDA Micro which now merged into Unisoc
> Communications Inc.
> =

> Cc: overseas.sales@unisoc.com
> Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> =


Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
