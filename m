Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77BAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:44:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955D620868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KPlDjtmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955D620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IzAWTdvpNAbntHVeX33Lt4WB+IHvo6k2pUPRRvFl7HA=; b=KPlDjtmhV2deil
	1vBYRJS4vp6+tIYOTID24SNYbEfMQZM8wGKODi3bMIp2giGQCfh8TakBipF7scVxImROXTkdnI49+
	nMip8bw4gwrTns/xX9tlfx+XHDubl/3nxYXPNqlMTsK/1jqpEYADGbEVQMqQDdClK58dGQEXQdo3P
	zAzhFyQxqmPnVgfSx4laPmOjdBSkjRi9l4fMUpY4BdamroYIHlE2wh/s4UzRtHjjYel/bFb09bUNo
	QXgsTUINvfiRV1WctzFV1CaXC96IndfiF/G9SeXqpKmign4X8TIlAKLmWr87DfxmB52NbVB7KfTvP
	3KS5hAoV4sw0GAwst1ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV3JJ-0001Up-8t; Thu, 06 Dec 2018 23:44:01 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV3JG-0001UH-IO
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 23:43:59 +0000
Received: by mail-oi1-f196.google.com with SMTP id h25so2002509oig.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 15:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=np/fGIQSqeGRlIZ/0YuhlHanIBOADMGVEHFJaKvqz9E=;
 b=Pay3qrUsZXEe9GvrtJNlv52l7gUhEEoMt2Wk3lKCKRZAzRypEscfZ3H8tH3hCHC2XC
 Za4idt707FeCg9Rxo3a0k5Gds1CeDOcu+QwZx2Fu84QwEE634n0F6pE9l5jYjvbZSEXt
 FS9W0vS8BU6iYIKBcBASF8EXe+x2aHTgRCfp96353pii3ItCIaGkooYsyG76GK216H7f
 7LpC18IEF15fT892ZzjA/pvV5StG8kCt6P58ic8xIElquTuiMRkIZdGT5UnmkaSKwyey
 gJmRt0wEOxNUmIvraLSvJrCjHvqJt7tflke/o4YWfUiEJr9b7CzRoQdYOqA5ZlGciClr
 Yqzw==
X-Gm-Message-State: AA+aEWYl7UTziu+rcFgN74SXCrIVk6usLvUD38zvTuPhrlon5rMyaMlA
 aYdRIEXTnJO9zfg9ztQkmw==
X-Google-Smtp-Source: AFSGD/WDSx/PoLP46kgKO5035xJKrShBJmJzm0nI9Hac7rYylUc/0UebYPiTOrYZaN2eSKTlTJavMQ==
X-Received: by 2002:aca:c501:: with SMTP id v1mr17752521oif.48.1544139826794; 
 Thu, 06 Dec 2018 15:43:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id o189sm925264oif.23.2018.12.06.15.43.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 15:43:46 -0800 (PST)
Date: Thu, 6 Dec 2018 17:43:45 -0600
From: Rob Herring <robh@kernel.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v8 3/7] ASoC: dt-bindings: make enable-gpio optional for
 simple amplifier
Message-ID: <20181206234345.GA1842@bogus>
References: <20181121051752.18387-1-anarsoul@gmail.com>
 <20181121051752.18387-4-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181121051752.18387-4-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_154358_608286_C73E44B7 
X-CRM114-Status: GOOD (  11.99  )
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
 alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 20 Nov 2018 21:17:48 -0800, Vasily Khoruzhick wrote:
> Amplifier may have no enable GPIO, so make this property optional
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/simple-amplifier.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
