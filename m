Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E831C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:25:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6EA72184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GoPDeQRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EA72184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=umRRdPqH8bHLqbd9soojRpLLnY2vFLWWJXqLlKCG5p0=; b=GoPDeQRDqA7hzj
	rv+c6KlLmsbcv+LcNOxhc/IT5kaY0+49FvLXsyyGiwEiwYCqtU6XC9bAoXILxH9DK6e00VtD3j3Io
	wWV8ca7Y4fh5vfwN4bDFQ0a2CCRy3926fmEqx0asd35pzWVDOJ9c9Y9320eYrXfOlK0tYGWt1OEKR
	yXGwU15F1SvDOuJodcMyuU+lSxNifTu4jdg7z0DCixacOhfVvT43DLQsVTRDLK5Qh1wIcibMq5nsX
	U2o4ay9NdXBSIWY/vMdwx0JzdQRX6KgFaRhWNvO2v26gdlsxjlKClTWfQ5GfdwDi1zKnDxC240Uhx
	ozVpJt+E9tLLQtoqHg/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxMY-0000jr-6V; Wed, 30 Jan 2019 21:25:38 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxMU-0000jV-QB
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:25:36 +0000
Received: by mail-qk1-f193.google.com with SMTP id c21so670448qkl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 13:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=clrEB5DCA5GhSoOyok8JMBONA4qCVAa7VEjKUPJ1vqY=;
 b=jDet7rkIEcNX2ee/TvHLVqd3D8srLKID/nxW4ZuX+T2dNxlBJSO+rKIBsh3r6g17m2
 tmda3UmCBm+amp4or3/qREKIMnR8aVpLpffRzS3HMsyJCkEXIG2N2ymAXjtIVneVE8m0
 6SLIqFHjCGJIp1+9gOGMub9hmORz/B+RqidQESKVBPIuJMVHLS71CMYGn9GID+144z7G
 ag0WEBrdtwHooEw2LgYHzf0F3VtAF2p6oytdObTmT42xMVjroCZneHYSWyb+7nmuXfBo
 GSAawTnJnt+HMcoHjh7ZLrfZ5+yPDAcNzVZekh9unMjQUXLlMj6JI230xXa+c2m++egM
 JHMg==
X-Gm-Message-State: AJcUukdpcG7uKNUgg1pe1Q7OIC+WGxOdt+3//i+UuyD6NLoelKGnVOvQ
 2BS97H9xt6q5TFY165b3FlFzYt2V7O5I5F3xlWK1GldB
X-Google-Smtp-Source: ALg8bN4r0ME8sWPYEaLf7F4vHrHmBTErFNwDw8/hxXTOXBgeYfjWn6CXbObily1nu2c6wAxYwCV06YYGL6uk3obZ25M=
X-Received: by 2002:a37:9a89:: with SMTP id
 c131mr29307577qke.173.1548883533058; 
 Wed, 30 Jan 2019 13:25:33 -0800 (PST)
MIME-Version: 1.0
References: <1548843431-8162-1-git-send-email-vladimir.murzin@arm.com>
In-Reply-To: <1548843431-8162-1-git-send-email-vladimir.murzin@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 22:25:15 +0100
Message-ID: <CAK8P3a0oBCXbgp17bYK9hfH1k8RkygsJkYFTd7SdETzzsXDtKQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: NOMMU: Limit visibility for CONFIG_FLASH_{MEM_BASE,
 SIZE}
To: Vladimir Murzin <vladimir.murzin@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_132534_855797_12818741 
X-CRM114-Status: GOOD (  12.72  )
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
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 11:17 AM Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
>
> It looks like usage of CONFIG_FLASH_{MEM_BASE,SIZE} is limited with:
>
> arch/arm/mm/proc-arm740.S
> arch/arm/mm/proc-arm940.S
> arch/arm/mm/proc-arm946.S
>
> So it might look confusing to see the option for anything except these.
>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

This looks correct,

Acked-by: Arnd Bergmann <arnd@arndb.de>

On a related note though, there is an old problem that we don't
actually allow any platform to enable those three CPUs: the only
supported machine that has it is integrator, and for the past five
years since commit 68f3b875f784 ("ARM: integrator: make the
Integrator multiplatform"), it has not been possible to build it
for NOMMU.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
