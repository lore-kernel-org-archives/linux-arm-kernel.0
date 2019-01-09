Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF41C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:04:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A97206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vd/Of7J3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyikVoFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A97206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=1qP3p0SerBKNjU27U67YqrmRczzwWGSgGpUSKyWg6HA=; b=Vd/
	Of7J34EJpgWxqiJwxUmhtPHDBfStlNuOil35JrR54Bh3LBVQLsQ7TcH3ZxtUAUHYrO7UOp9IUYbEH
	7Id5efb+fyBkyCAfDesJ1NFwYHdlrEcuEe8KWwVF0fMUrEJckqoX9Cr2OIJWb7yW6ieOFbX6DjfMK
	RG5CAw6VLPDOVsYpNliKJp+c86SnIkkErJOF+ehKi+esmKtMToJSqsihFLMZSsl/SqzmEM1+ubGbU
	ylKsJ81supJpidZ5ZgRSqGNoSU7AkijqNmX7LOHWvJ0y0yRN7wRCFT7oJNyw7Q/kJXd99Snc1Iukc
	+vK/VcjHUOTv5wnNNZ1kR346ljo+O4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh9mE-0003KY-3V; Wed, 09 Jan 2019 09:03:54 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh9m7-0003K7-Dy
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 09:03:52 +0000
Received: by mail-pf1-x434.google.com with SMTP id b7so3353653pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 01:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=yI11afyUBVCwEJjCs/85GeBO9QfmV6lxxJ9paeNHEaw=;
 b=AyikVoFAlKLCYEQyn//2BQvr0e0eO8MAu/sfjq4cRUHzCqgOTbhcZ+aCQQn+rqMO3o
 OteA2Gqk+gaaikcu9mhzdyt6Pkn8XUy3f5SgRYgQTDvdCHVG8PRDWlxsq2/yibt940u6
 tYlAmFyvEXmKlEpq8hu5pCRwhTN2R9bnUychtN/96Ba80SfUCWe387U9nQ7u+fTYqhtH
 mxHenpbiHZ8btDTzG5cOi71VMiWEgMChVBwLksUfqCICpHldMgPoUe4G21e+S1I6tE/1
 tQBbkQBqV28NjgvTac2Stre5hRBU1A3xEYdXl6glOQT+H0i+8Wo07yWcT8jdWA9/GEpj
 VSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=yI11afyUBVCwEJjCs/85GeBO9QfmV6lxxJ9paeNHEaw=;
 b=Q3rLJCtLYNjTA9pn8toHWcjVURLzF68nlvLfDfPC+oHZAoqTWFDsbh6s8xaLODxWl0
 S5CTVxnYijwaqd5afD69UTUAGoiAwR5Q9599e36R0R2jRgWeF2J1LrS9Y1wpS5xB7ZCo
 alpPYggFRTj7qAJ0Je81DbeDsyxzEZbxRCIl5TkD78NsmpIcyl0xT/kFjf4XlVlrKNlk
 1kOwDQsxjb5heJ8phYsgLhrwlKbNlFvh4K0KIH266RGJuvHJrSZso8zUDyM6YIncv80J
 w9lza3rE5X+fVmhFG/a24jaV9ehmS3foQ4rl9rZ+mFqW9AFhOBh4c+D9uEwgC13ACf12
 0WNg==
X-Gm-Message-State: AJcUukffxHkE7uZ1/7/iDsylLgDrOM5vMuuWcR9RqychDM1UNf54+Fku
 HwJ+IZFvFw9vBQmdu9z+omAYd1XM6vOF4iKKpQmkic4o
X-Google-Smtp-Source: ALg8bN7VQsNJw0YymDtjm+SZDK01DMejmqDhwiZMR92HiAw2+bqs07ogG2kaSQhL/Y6+2fs1odHCRmf/qZw8NNlpqSk=
X-Received: by 2002:a62:47d9:: with SMTP id p86mr5004076pfi.95.1547024625403; 
 Wed, 09 Jan 2019 01:03:45 -0800 (PST)
MIME-Version: 1.0
From: yoma sophian <sophian.yoma@gmail.com>
Date: Wed, 9 Jan 2019 17:03:34 +0800
Message-ID: <CADUS3om=GzsVaVHvcAChivp1cTFYq-5YC_mQr-Yw3ANxbn4k+Q@mail.gmail.com>
Subject: arm64: some question about default_idle_call flow
To: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_010350_709982_EF3BA4D7 
X-CRM114-Status: UNSURE (   4.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

hi all:
In "default_idle_call", if
a) "NOT" current_clr_polling_and_test
then  arch_cpu_idle will call cpu_do_idle().
(And below is excerpted from arch/arm64/mm/proc.S)
ENTRY(cpu_do_idle)
        dsb     sy                              // WFI may enter a
low-power mode
        wfi
        ret
ENDPROC(cpu_do_idle)

But before calling default_idle_call, the local interrupt has been disabled.
Who or what kind of even will wake up this CPU after it runs wfi?

thanks for ur kind help in advance,

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
