Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D3EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:38:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A8F206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XtA0vjUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A8F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Loo9Ffs9rXRQV75Jb+xaUYHwOXYZ3nGE0EtmMEkq6qQ=; b=XtA0vjUXOCWPxw
	tdqIRwK5lCZfiBWtgfa3ZHEBV2lRyg8+iTfUz5CjvlS/fBYh8CXpH7V5iCM4kiSQYHMqIV2ADnPeq
	Ws70l4NMGXTv6vOwXctFDYtw5zj5l56GyhhnGsGfaLyLfThHqkTvNMAW7DV4t6oAYex0gYlzMZ0qx
	qnC3vxF1i56luX34X/YR3HD7YII1tPSO5F9XZrZ0oYnAbH+B5EtQqPcmKon29VefYlscTb3Z4+i1w
	cEANfN4K9kTqu7XQn+i+laEuuBxB2jUipSi40/m0AYtrIhpRnVNCdwLHeLlu8Bf2YBMa730JVPHTp
	G0K6BKh6HgtJ7AhgKVqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFiH-0005wy-KY; Fri, 22 Feb 2019 18:38:21 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFiA-0005up-RF
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:38:20 +0000
Received: by mail-oi1-f195.google.com with SMTP id z14so2521430oid.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=10Dgi2QHVM3b3MGiOV+JfGuM6InqoSZA30FHUFZk4hY=;
 b=AWl/LRwK6b16NIpKtYIPE46SYIidlEycFlmWhgfGTSLmJUcDDa4OO8BMw40BQVgZ6o
 RsEdb/WMrraR9mNu4Es2RCbum3ruVooboGc5+zr6dAJcr3iFdz5U+UDYEFcVt367rWBi
 czhL0bXdrikAfpqZ7sgTKts/DmzWKc4AELSTIQqixZ4WvvG5eMIIoCVLyw+A+DCo7UMJ
 vpZC5nMVc2Nyla/z0T27yvZRSeguViK11U33eFatbF7DpSFANOA/52MmH8/bvJv2Nv7r
 C6P/Nr5yGk2+aICp7WTlEa/D5hFxpW8dPlj2QWkRRLJpDeRvYIeRXfv91RlK+SgVh10t
 FuEA==
X-Gm-Message-State: AHQUAuY4zCvzoQ3lExlrXaDF/hRCGMrpKd+KZIHm/T1c4VyPuhAxyZUp
 ukUifJDIREdEsy+RymnwgQ==
X-Google-Smtp-Source: AHgI3IbSgwseEMdVBw/Qy/2P6RYugN5ZaKjThInL+olOyRnlN90LSp2j3bUU/joQPKwdMUXfCsT6Sg==
X-Received: by 2002:aca:e345:: with SMTP id a66mr3228574oih.41.1550860693707; 
 Fri, 22 Feb 2019 10:38:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id f43sm816316otf.23.2019.02.22.10.38.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 10:38:12 -0800 (PST)
Date: Fri, 22 Feb 2019 12:38:12 -0600
From: Rob Herring <robh@kernel.org>
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v3 7/9] dt-bindings: serial: Add Milbeaut serial driver
 description
Message-ID: <20190222183812.GA20616@bogus>
References: <1550648677-11164-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550648677-11164-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_103814_875919_469B9DA2 
X-CRM114-Status: GOOD (  11.12  )
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
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
 linux-serial@vger.kernel.org, Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 20 Feb 2019 16:44:37 +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut serial driver.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
