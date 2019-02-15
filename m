Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9773C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:01:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A63821A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eJ5L7Srf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A63821A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LDBYRpudzlDMMsRqSH7d7YSc1CTrep4U1zFnlwts0Tk=; b=eJ5L7Srf1pymxu
	j+1BsD1dLxiQw8m+nuyBX0KuB36AMGpVlJFdTDBGjCztmDoEymclKnUQM2RZ8LQGnXEwH1byNqZtc
	cDu2RdZyb5yqn1ZSlEpOFsqKXTqw/OHDf5xu/DKjoXp8tudZeyXcHVY11qOrDiWzBPPr2x7qGuuQu
	tpjoFvAXQJXiz4APwavUhPH0vlXBbPFI0EjzU4p9aEax2Z+vV32AfY1KazxLAlgfcDuCxE90RSs6g
	Qdx82S8H+uPfPUNEfrN+2t4hjLcBYZyiFLu8Bget+I53PctkahfE/7CxdfCdQ391t2VoJ4ch07wDb
	fB1YQbe3jLtmYnWcfT2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gud7b-0003Vu-IN; Fri, 15 Feb 2019 13:01:39 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gud7W-0003L7-6w
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:01:37 +0000
Received: by mail-qt1-f193.google.com with SMTP id j36so10696934qta.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=59rGykRaqTTeXVnkdX2/2MVXVd6+dMRocQTpBUXta5k=;
 b=aFSDsYnJ+4DhaKlt8rji42On9oNWrxHhUWWaAbS9f/EseFi2svpJGPT0m/TH1FAH18
 7eUwIC9LYZqB/owTTKlnQsydGSIAWKfDRfZ1Z58EPnUguju1gXiQM/jDHHLiiBgDO+g5
 KR2l2W9fNyadaAR48y0Zx3knGeD8zJa8acVs383cwlH+h2OTQvxz3mDZghVXSCO0x+E7
 zIHgrlV+x7oCHSJT0f3vpa8vKJaOjQ+QpdQzxGf9Au0JtlU9yZaaKvFQpOAH11jtRTjN
 p4LSTHoKJk+mNjsX4zrs2dBq+iwQOzpqK5psmLR+op/WDuSguQFFTgZRBtTf+3lPMWT0
 CPZg==
X-Gm-Message-State: AHQUAuZE9yblAaFQSITyrizyzSwrG029cXHTRS8GdCk0fGrZhyKfXdUN
 IDYD0ECkw49UxT3iCxpf2VfplaYcp59jonveSFuavQ==
X-Google-Smtp-Source: AHgI3IadOoAmQ16Q5YsyVGgZ4dRMTdO+LFyCdKSERcsAoOgR4RDu7A3B5hJQKMadmqxSij+506CqKcZReghUUdNwjSM=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr7268400qtb.319.1550235693081; 
 Fri, 15 Feb 2019 05:01:33 -0800 (PST)
MIME-Version: 1.0
References: <pull-1548951676-587288@atomide.com>
 <pull-1548951676-587288@atomide.com-3>
In-Reply-To: <pull-1548951676-587288@atomide.com-3>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 14:01:16 +0100
Message-ID: <CAK8P3a1VbccFL6tSwt-HqMw=1V7H73QSgZaJbu0ME6KeyoqzSg@mail.gmail.com>
Subject: Re: [GIT PULL 3/3] dts changes for omaps for v5.1
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_050134_248220_1FEED022 
X-CRM114-Status: UNSURE (   9.49  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 5:24 PM Tony Lindgren <tony@atomide.com> wrote:
> dts updates for omap variants for v5.1 merge window
>
> This series contains board specific dts updates and few minor
> clean-up changes:
>
> - add stdout-path for am335x-chiliboard
>
> - add wlcore wakeirq for omap3-evm, pandaboard and omap4-droid4
>
> - remove unnecessary address-cells and io-cells for am33xx
>
> - replace deprecated linux,wakeup with wakeup-source property
>
> - use spdx license for am335x-shc
>
> - configure ethernet pins for omap4-sdp

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
