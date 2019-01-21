Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46760C2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:51:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA82020989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uKOhewam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA82020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NrVwfxg+BG/KkW60HrjA6ZL2UkyrXL7ViwTVOiMT7do=; b=uKOhewamnVOjjU
	U0YXZQ5kyHiZQplpC/Sp+gKMZIV8ppwT+Pp36zK2//chT4ngEfMgKDviXL/8Og0rIxG3aX+tXeC4E
	yxgGxdqaIF2SzFEP2uldvXa1ogTyop4JhUxUQ/6rLlcgufjiQqan9WNw2xFRgDBxOe0s+s0BG+CVi
	2sQFZOMoZs55OFklBVWfV+LmfBkX4PgOWHk/ZJQ9Ztt7PUAElEWGSP4YLq+nhZowcQvDZoWZEbQPf
	Ijj7c3a/BLbQd+qZm+ekllr+EgTY4UYkepPw/ZFmdRV+ECiv+5o1aYk/+dL+eW9ADbWLKpIb01X14
	APgmhOWrJUTgMDM0HCsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbqq-0006xM-Cc; Mon, 21 Jan 2019 15:51:04 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbqR-0006lD-HA
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:50:52 +0000
Received: by mail-ot1-f66.google.com with SMTP id 32so20864815ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Iq+/bLYjYOQFTGBsWMeESxmK/uNouPHVdUiAadG+hoA=;
 b=kY65KUsrDmKqWTJUmDQApMt6lhGhpNYXHip7jW2mpSesA34b70/DyHHBCup9JUryA8
 giyqwQ/AAX/G6fq5NSjQUusc3yIorUxfvk1Wa4RFwF0g8+Dh3IFeIu+OFGQMS3n8Jbmu
 aVFd7S1rnmJoP1Lv42twCnBaVnezXddfrUvOC7y7+3X6AcylrdjwKutMPfbIZ+f+KqQE
 SiAhYouIwrLLLwtD4oxvv2QJfAviWtCOSWH87xZHyL6eiMw7bmkaa3SGB6HpsJblCLCu
 zlxSuEBoqrVMJ2HD+hStiCpq2LtwMXHEc9UkEpdMfP6Ao9ZDoMH9YUCqX/ydSiLDCw1S
 rJVA==
X-Gm-Message-State: AJcUukergMcq4Do3QG4nOqgtJ8yi7BXTLNVT9v1pJUeLcM0aihMN9Jz0
 fbwy6u2kMpGOHH0lrp6dpg==
X-Google-Smtp-Source: ALg8bN73nQEM542DW0JcUvXY8ztyZ2JJ5R5bGcjEWGyn+Bh6cLoInwXGL4eax+O1/7ZVp10w7cmRwQ==
X-Received: by 2002:a9d:6a4:: with SMTP id 33mr6663260otx.347.1548085838045;
 Mon, 21 Jan 2019 07:50:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m89sm5754236otc.35.2019.01.21.07.50.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:50:37 -0800 (PST)
Date: Mon, 21 Jan 2019 09:50:37 -0600
From: Rob Herring <robh@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
Message-ID: <20190121155037.GA5115@bogus>
References: <20190115184406.3164-1-f.fainelli@gmail.com>
 <20190115184406.3164-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115184406.3164-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_075039_712274_346AB991 
X-CRM114-Status: GOOD (  11.81  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Gregory Fong <gregory.0xf0@gmail.com>, linux-kernel@vger.kernel.org,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 15 Jan 2019 10:44:05 -0800, Florian Fainelli wrote:
> Add a binding document for the Broadcom STB reset controller, also known
> as SW_INIT-style reset controller.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/reset/brcm,brcmstb-reset.txt     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
