Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58639C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:23:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DBF21920
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XWJB9h5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DBF21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KWEUJvM0xPc2i4RWmZaqwaE9YaW0NwdjhDQHwbfK16Q=; b=XWJB9h5JZ8LB4E
	8h2dpwMccq1XHTQeesq7jObL3MYH5jIgD8DSKfee+cvCL42wXzP3WxRKP+yGpSAi2WyXxHKjQYnvH
	7tzNS7QxSwD3xqQGqpwTcKQOAXcOAyZx0rLMkiidXke3jaVSAVZYHIGdVhnlRufgK14t4grNJYQP6
	y2PdOL8M1GRz7eNpIxZqeEWG132xPJ9XXmkUw+BH5t51QSleHiQeMwcnpqXz0cXPI8gkmmD114O7C
	P6LoO9ROoOf/J3Ekrjj1N11luwvN88kEASpgc02TwKNDmHI9e8BiKnlHK80LJTAERg2JB1bH0oeDr
	bSyHLEZFfVGYZOnIxKkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaPSd-00038i-Ca; Fri, 21 Dec 2018 18:23:47 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaPSa-00037u-7C
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 18:23:45 +0000
Received: by mail-ot1-f68.google.com with SMTP id 32so5903407ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 10:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JA2rZwpKRghhAE4r5apXuDvLr8PrAzse9lI7Ni35z0o=;
 b=LspyLQnEoyys7xe6/lubhEuk8A/xLDU50r5DZ4dhCA0DUrWw7oJ3LKc6RF7HNapUb4
 Yv0LVdAM+kCWNmbDGf+WsEsaDBjD8lO5hzVikN1L+RzQtuxqJ8oq79T1Z2SBQzU2oqBV
 JkwKBp3qwxGQj2kX3zourzML+/H5w1S1bcbJQWAjnP/iXpIOKiTr3HQZ10jIKDWhOBFb
 yBwNUzPSyo6i4TnBmBqexp3AdfuYSISTnQEvYxnxf3/Pu0DEBGwQH/NVtatms+vhG2pL
 HuFwqG3TEaQd4ATtD7yXR/v3Eu1JhvoUMrYWabLesdJfVVO/r4KaacBnj2e5pnMnI4qo
 pTBQ==
X-Gm-Message-State: AJcUukfVlsgv9kDd5CyFHF+0jRo5ShmJI8OzH/XBYKaiEVEiRXZOnaIA
 WMPIVnxkGf/nEvrnurZ6IA==
X-Google-Smtp-Source: ALg8bN6eFfYUfyym7c2Y5Cir7ulZDAjtsmt2lt4dB90cY222B+eHGT6uL1oXLylUVz8SS+83TEdJ/A==
X-Received: by 2002:a9d:7ac6:: with SMTP id m6mr2419927otn.62.1545416612825;
 Fri, 21 Dec 2018 10:23:32 -0800 (PST)
Received: from localhost (ip-70-12-27-227.kscymo.spcsdns.net. [70.12.27.227])
 by smtp.gmail.com with ESMTPSA id
 m89sm13391147otc.35.2018.12.21.10.23.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 10:23:32 -0800 (PST)
Date: Fri, 21 Dec 2018 12:23:29 -0600
From: Rob Herring <robh@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH v5 1/8] dt-bindings: stmpe: reformatting parameter list
 and use tabs only
Message-ID: <20181221182329.GA5726@bogus>
References: <20181221134638.20600-1-dev@pschenker.ch>
 <20181221134638.20600-2-dev@pschenker.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221134638.20600-2-dev@pschenker.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_102344_257021_264ED23A 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, robh@kernel.org,
 alexandre.torgue@st.com, devicetree@vger.kernel.org,
 marcel.ziswiler@toradex.com, lee.jones@linaro.org, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, stefan@agner.ch,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Philippe Schenker <philippe.schenker@toradex.com>, thierry.reding@gmail.com,
 coquelin.stm32@gmail.com, Max Krummenacher <max.krummenacher@toradex.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, digetx@gmail.com,
 shawnguo@kernel.org, linux-input@vger.kernel.org, jic23@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 21 Dec 2018 14:46:30 +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> This patch reformats the parameter list for stmpe device in a
> table-style so it is more clear to read.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> ---
> 
> Changes in v5:
>  - Made a one column list
>  - Added lee's Acked-for-MFD
>  - Changed author of commit to use correct email.
> 
> Changes in v4:
>  - New separate precursor patch for holding reformatting
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../bindings/input/touchscreen/stmpe.txt      | 64 +++++++++++++------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 ++--
>  2 files changed, 53 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
