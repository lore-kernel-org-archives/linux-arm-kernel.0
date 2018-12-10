Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8DFC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:25:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0C52082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TT3FYeeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0C52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NDHUzEv74hJg5oK/p0XLhUcjo5xH6S1lJRgOS5ag2x0=; b=TT3FYeeVvcFZ6E
	czL4qR8BzzfxRrJx03vFG7IjH1RNwxgM0fhz+haTxXe9ptA+96DcDDneFnGFSnPpSOKT2whX5YpZV
	r1mocA92c8LTunRl3xmzw5qzIpmm+ocpE9cdcf8YnGy0BLjNvJn3+oXtUm9kUOVE/1Co3IH088xKj
	mr57/Eb152gmrYZtpS55hEmmB1XjLUSnzOZylaBD6NQm9EVbYMD3wVFYZeDU7BgtcvI0k/NfOlJwN
	KW2EnOASugphDY3bPzvlaGja5DiCy0Vx1ySGx+TnF/mRQrc+J8U1/VzNt+lavIXND6cM2GOZ1rpOG
	JBFIA1kyzCAw7PIKfqqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTzs-000365-9s; Mon, 10 Dec 2018 22:25:52 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTzp-000308-CL; Mon, 10 Dec 2018 22:25:50 +0000
Received: by mail-ot1-f67.google.com with SMTP id e12so12079612otl.5;
 Mon, 10 Dec 2018 14:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=dcrwqDt+BOSt60/oApLq93K6QJ2/knMWlj+10Je9AN4=;
 b=joCNcr0wvbVtBTTJeGHu9IReUmw4tnAyz96eNr925fJMMpX901MBJRRl0GEBRGWQNR
 rsCJ9BK+4DCSD5TMZOFxBKiewQhkD9nOX7XD7ITWV65ZGwpFNuDh+EC6Ifn2SFtghhre
 5F0irmlxdKCjDQhaCfKVTKyG+FnsrgT2lmwhKcchg05//34iM6z+pq8vUq6YqOeFq6NS
 JSIn12do68dsK32HjDduq2W7LpS2fajKVO7HVmFq3iCwXukms6wJOETf7Bs2RFG51EbQ
 2lD6piV9qW5JM16wfaz6IP/9S+0JYwo+uUgYmT+K0cBUmFKf57CL+jJzDbGgIGyXFkNF
 daNQ==
X-Gm-Message-State: AA+aEWY1ntb8pHq9ULeRiOyUKaLCLw7/1zx8MqRhRI/FksT7TFznmu1B
 wmRXoePA1mqArsn9ps1rRn0jNHM=
X-Google-Smtp-Source: AFSGD/VcZW49TwEtJwCT6hRinpqvtsSfSSS5F0fFYxQS6TK9meO9IRpllAEhDVY1nMYaE0+tp46edw==
X-Received: by 2002:a9d:3db4:: with SMTP id l49mr10369049otc.358.1544480738297; 
 Mon, 10 Dec 2018 14:25:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id h24sm8437671otm.72.2018.12.10.14.25.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:25:37 -0800 (PST)
Date: Mon, 10 Dec 2018 16:25:37 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 12/15] dt-bindings: serial: Document RDA Micro UART
Message-ID: <20181210222537.GA2223@bogus>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-13-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210173550.29643-13-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_142549_425321_B2AC34FA 
X-CRM114-Status: UNSURE (   8.77  )
X-CRM114-Notice: Please train this message.
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
 amit.kucheria@linaro.org, linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, olof@lixom.net,
 tglx@linutronix.de, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 afaerber@suse.de, linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018 23:05:47 +0530, Manivannan Sadhasivam wrote:
> From: Andreas F=E4rber <afaerber@suse.de>
> =

> Add an initial binding for the UART in RDA Micro RDA8810PL SoC.
> =

> Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-u=
art.txt
> =


Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
