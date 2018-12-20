Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4BBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:37:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDAA218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kgh8PDVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDAA218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VZA/dkPapS6Z1wVNXAKNinFflgY6WrzFGS7BOAr3UkQ=; b=kgh8PDVeIVJVEP
	ZSkpz5R6CINVunCnBP0KO3RhnrnWcapFyEKNRGjLhtJRCHR08NN1Qbo2fy6q15SSRKprzdS7DK9tm
	vDBmAoufOBtoUQ0A+sz+okmxYkLRyrCt0Yzfouaf2QmOqj3aK4DevPhrBL3iremRblXcv36zLWHkE
	zWgnOaruCEhJNp+2qdFx4eBOWeH5kIr4JAgYhfR+g1rnBVic75PpnarlXht848wIsX0LBiDcttk26
	Ws0Ad+xWODF0dp0gkb3Rc6WiwnS5sXony0hnihcPCRT8q5WyFESZDYTjr5gaK32wwTyVOgBkSX2LA
	ejeuwjFdqvOlfNQk/I+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga60a-000861-KI; Thu, 20 Dec 2018 21:37:32 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga60X-000852-Mx
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 21:37:30 +0000
Received: by mail-oi1-f195.google.com with SMTP id c206so3158956oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 13:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AxaU7zrSWX0fc6SAAGFXliyhUgi/Gs4msHYZMlxcnWk=;
 b=o7xppHft2htILV5xRQYRlntT/jtnfn42n6HD1J4AvKUtkcU/4rBeuboL2NQJtqoOG/
 GU/s9MaJ0+tJ9abOmbXWL3Y3qEk0WSqtnfKeSB9isDJs6xlmJuI+EbiUWNINKUumh1Bh
 FOuTtlHqbZnwAvHKyYzU6ZTVNTYgiuRzpCoIY5hpinc+YPF0vEMmoj0ptpvx9cNZiyNr
 IrNVMb/6mxKPO01UPB65/ZZxsTku9FnXYmKH0OW+vdQkkunN2X2fZfXMMqOh0d/ahtpR
 Hk3suvWQhGtYSZlpuoj6MsH3mOKL+z7e7MTMsSQt9JVPkjHsJFVLBHTb1wFcXdd6bJTi
 Kb+Q==
X-Gm-Message-State: AA+aEWYJHZtU6RYf4VkArXtiwlSOE16axRFSotrdCzCfg8gbCUtXx0j7
 ZtQjdYj06e+LHXyWU0AsGQ==
X-Google-Smtp-Source: AFSGD/Vf/DktaMqCOXHukHpteFCFgM10KmSvObZxBOJ6Y5xehWpYzXb4iUuipNfn5aGRnBWKemZqtQ==
X-Received: by 2002:aca:52d4:: with SMTP id g203mr305385oib.14.1545341838608; 
 Thu, 20 Dec 2018 13:37:18 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id n185sm10461267oih.18.2018.12.20.13.37.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 13:37:17 -0800 (PST)
Date: Thu, 20 Dec 2018 15:37:14 -0600
From: Rob Herring <robh@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 04/13] dt-bindings: mailbox: qcom: Add clock-name
 optional property
Message-ID: <20181220213714.GA8965@bogus>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545039990-19984-5-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_133729_747208_700C31F1 
X-CRM114-Status: GOOD (  13.60  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, bjorn.andersson@linaro.org, david.brown@linaro.org,
 linux-clk@vger.kernel.org, jassisinghbrar@gmail.com,
 jagan@amarulasolutions.com, andy.gross@linaro.org, sibis@codeaurora.org,
 devicetree@vger.kernel.org, arnd@arndb.de, niklas.cassel@linaro.org,
 robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, olof@lixom.net, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, jorge.ramirez-ortiz@linaro.org,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 17 Dec 2018 10:46:21 +0100, Jorge Ramirez-Ortiz wrote:
> When the APCS clock is registered (platform dependent), it retrieves
> its parent names from hardcoded values in the driver.
> 
> The following commit allows the DT node to provide such clock names to
> the platform data based clock driver therefore avoiding having to
> explicitly embed those names in the clock driver source code.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/mailbox/qcom,apcs-kpss-global.txt      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
