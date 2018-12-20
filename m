Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF37CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:05:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2784218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a5QSINVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2784218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RJgYgLqV7e3B84U/JzSnzLbQH+YEHP1nzoJDclQPEUI=; b=a5QSINVBWRCKuK
	T5uYV1SRIpPkEEDjIJ7CpqqM+6U4WYwSsReB1EPV8aoW8MpQAEds7MW8NF2KoUHj4OUsVvZs3gDFn
	fjnpiX0cleZRhkwH3LXD1K/z/85H4T+Wf3pcHu7sivYGcf12DFDG7TedCyvQtpEh0yeU/24vQ/qJ7
	KFVufsTsq3ixFkf64fq7EqEmoPtsPaE/EdgmLgme6dGUSEA+XTWsjtx2Rq+Mm4E/v2ZDTeumYK4Vu
	4Ek88Rvtt10I2sJJrWQ+jp4e8rCYn6PbGt5xQ2pL/ATvy4ZfwVlCVg5kXNUDgF+vFW8u3x60zO9u/
	QdGfOSxwHFQ3iA1KQfjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga4ZP-0007Hf-VS; Thu, 20 Dec 2018 20:05:23 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga4ZM-0007G8-V7
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 20:05:22 +0000
Received: by mail-oi1-f194.google.com with SMTP id j21so2923215oii.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 12:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=77+IhaNwDQKdDm12pZyQvD5jZoI+UvywPhjuVCxY9k8=;
 b=J2iDQjMlitpDn+P6xB7SJFD3yZxdCraOsYAL5UGfJyCWqupAaP97m7pD2tybFHouIi
 2aOeuot1sFY6DevKcAgaccRmzf/hjw0uPUDL5y0o029MNAqyJtJjBM439cP+oFQIi+EC
 Ezck1AKOlx07GH4rNyJtJwhnJtCctMqVpgB1ip0fa8cRs7L0CPBm7+PSvyOBZERjUu16
 I9WsIhSwl3dFLJZnGRInq979zNBWcGov6963BRA9UB5TCoC7B7xSomgvd9FLvTuS0rhO
 KCOnRk3NyPpse79DXY4lPNdy6mIj8t79OQCeaztXkdCAGdWfXdTCyunecCv1BM9KPrFT
 frtw==
X-Gm-Message-State: AA+aEWYI9mYyjUgtLJYDs0totWEUcgjbHV7rhQqIhDxphyoBgso5YqR3
 0ahuBLVA+MF5XZXIWTeVmA==
X-Google-Smtp-Source: AFSGD/V49ajMvV7y2nvF/E74eDTcfrq3wsypBN3kSHCJM2saEhU+Lh9gM4YWXFWxoFYw+YlHOptIgw==
X-Received: by 2002:aca:5bc3:: with SMTP id p186mr101841oib.130.1545336309527; 
 Thu, 20 Dec 2018 12:05:09 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id g25sm6181484otr.30.2018.12.20.12.05.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 12:05:08 -0800 (PST)
Date: Thu, 20 Dec 2018 14:05:07 -0600
From: Rob Herring <robh@kernel.org>
To: Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add vendor prefix for Catalyst
 Semiconductor
Message-ID: <20181220200507.GA7484@bogus>
References: <20181211194251.12988-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211194251.12988-1-martyn.welch@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_120521_031713_F04B887D 
X-CRM114-Status: GOOD (  13.35  )
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
 Michal Simek <monstr@monstr.eu>,
 Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
 David Lechner <david@lechnology.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Lukasz Majewski <lukma@denx.de>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Johan Hovold <johan@kernel.org>,
 Thierry Reding <treding@nvidia.com>, Shawn Guo <shawnguo@kernel.org>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 11 Dec 2018 19:42:50 +0000, Martyn Welch wrote:
> Add vendor prefix "catalyst" for Catalyst Semiconductor which is
> already in use but undocumented.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
