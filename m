Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F40C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:25:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C582145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ir7soZT1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XY+czLTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C582145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NeDA2tAXQfhiqpAjlUWW30iyqzACTMgkUmOdse+MfSc=; b=Ir7soZT1CH7qSu
	PMwEiQmMZoGzLLlLAJnwFfLwLZZKbyba1ZToblDYQ5IHWyFQFLOq07kfyU6ytY6gloHbXCLQK4qkP
	OF7xovHxcBBNKxlZiVv6llANfkQK46eQ0P4J09k6T3apM7HOhfaLXpjUEbaVQDlxl+gBluZmwaENY
	vMIq7VDaPLBsoJfAlkXCs+scVpAnLgDGnsB45H/QlMSTtgybAVrj88+6pnr86k52xSkY/3ZNcGOG7
	Lccli2izwVHYITqEl3nHQyoy+tDylJtZOXETSf+R9ZqxWAb8zWBZa0/V78opWbRXGrhxP8KUZKW98
	3a7ZJWM1i0ale7oHzEXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gswar-0005qS-Kw; Sun, 10 Feb 2019 21:24:53 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gswao-0005q0-3S
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 21:24:51 +0000
Received: by mail-qk1-x742.google.com with SMTP id a15so5377529qkc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 10 Feb 2019 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=wkkyoSoLEHExdCv3S3zjnYxqJ3fQjmd0c8cULl7lK4k=;
 b=XY+czLThZASlIpgyozy0wFDciLazcnXpU4Flf7459xpO3F3De9dkcwj3gwfIgAOq+Y
 KNImmyoQ8xU8djpaZMbaAAjZkjOl5SCpNZyPSQLaao2ujTh+xIJSn4TV/LG5OQce9Zwb
 gLRXKLb8Zsku2w+R+WsNvTVpnuGebhRQux/CuAmqg1EX9wDJoLvdKs1JD5Y7TIZWjBpR
 RcMDZ99CvWKnPRgz26XZPOxDl3jRimL38B8uGOX7METwQhsN2kcY6NmeCihc1Uc/GfJg
 miMkDvFOPHCXKkhzWWqjI9LAT3Ya1aYSeQPeimfPiIYRfzg6E64QJ3lPzYixVExfcLOy
 ateQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=wkkyoSoLEHExdCv3S3zjnYxqJ3fQjmd0c8cULl7lK4k=;
 b=V2+1FJL3dnNr0wjyUbSiPUsQVOkltpiiACGOmbedT/vgrix+e7lHA+ziVsyzd2yMAE
 GBhiYiIkIQSVilAtCj9ZWjOkqMsTNUz8QXOPL2eNZIXbKCYpzkG4N7E97pav1Xu/l7La
 t2/t+QnL0w4J2OkTBFY63vtzDXjaciYStsEruCO2PsyZtJzKybl/fBsmrGCm8PuT8LHg
 LwMLiW+xReIMLJ/OLnZYFlS7oZ7DD+7c8OuoSW0salo7QD/5LQF09qUdcXyMaVCLMH44
 b0gSPP1FTa00WDZU/+92C2pL2NGa7xJK+5GDDmj9DfU2/QWni+PDGyQPWsn1m9N23RGr
 S30Q==
X-Gm-Message-State: AHQUAuZHCOsvp2l2yCpdOLll7Il9t4bcbmiGw7Cuu5cxzy3kBkldm1ba
 prBho9WiRgMQORYQ//zPSRzOyg==
X-Google-Smtp-Source: AHgI3IbBOyxHEIiwd7lMi8oCGLyLrxn0eDbfetqek0DvDVFLF0++WXIh/wrijfmkcRumTyYDoWC0Yg==
X-Received: by 2002:a37:b084:: with SMTP id
 z126mr22723222qke.154.1549833887205; 
 Sun, 10 Feb 2019 13:24:47 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca.
 [70.82.104.228])
 by smtp.gmail.com with ESMTPSA id 55sm9052123qtq.88.2019.02.10.13.24.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 13:24:46 -0800 (PST)
Date: Sun, 10 Feb 2019 16:24:45 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 0/5] ARM: convert to unified syntax
In-Reply-To: <cover.1549753425.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1902101620430.2213@knanqh.ubzr>
References: <cover.1549753425.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_132450_153117_92DBA351 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: mark.rutland@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
 will.deacon@arm.com, julien.thierry@arm.com, ndesaulniers@google.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 natechancellor@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 10 Feb 2019, Stefan Agner wrote:

> This patchset converts all assembly code to unified assembler
> language (UAL) compatible assembly code. From what I can tell,
> this mainly boils down to using conditional infixes instead of
> postfixes.
> 
> Most of the conversion has been done using the following regular
> expression:
>   find ./arch/arm/ -name "*.[hSc]" -exec sed -i -r \
>     "s/^((\s*[._a-zA-Z0-9]*[\:\(])?\s*)([a-z]{3})(eq|ne|cs|hs|cc|lo|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)([a-z]{1,2})(\s)/\1\3\5\4\6/"
> \
>     {} \;
> 
> The expression resulted in some false positives and missed some
> instances where infix conditionals have been used. With this
> changes applied, I compiled several kernel configurations
> successfully and without a warning.
> 
> The file arch/arm/probes/kprobes/test-arm.c is still using some
> divided syntax assembler.
> 
> This does not allow to use LLVM's integrated assembler just yet,
> there is still some assembler which the integrated assembler does
> not like (yet). But it is a big step towards that direction.

OK....

Please document why you added .syntax unified in the commit log of each 
patch where this is added along with a link to the gcc PR.  Then you may 
add Acked-by: Nicolas Pitre <nico@linaro.org> to the whole series.


Nicolas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
