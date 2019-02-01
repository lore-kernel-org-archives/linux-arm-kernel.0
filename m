Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5306C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:38:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821FB20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="orusNUS/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AT1kuQXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821FB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wHiiOPQE2gCerOzTnN7Ux+QrT2jcHzfr4kTpb3a1xcY=; b=orusNUS/ogSA5D
	N050NBhMgLCJFytIxzVEpPuhnVyc2d50Jc1q8gYOipvsDoTJ0+BXddrICtPmyuPzqrLyvO3PN3+fS
	mE9cx7lNTSrNu8Fs6VcqFsCqpIOlTUR2mByRREPKySL1ZvyFPwcTApt7G9544IP+L4kLwH3HdJypy
	Y+jW/EuQSOIjF6k7pMTb5f68AvEYueshxVz1YdF5rxBPE44RJkFFQDmdrlvhOL+VaJznVch4CsRUK
	HcR+J2k1O2Z6N8B8y7tY1MOkuyI1LX9X+5M9QeU0AS2ziKjcSjPBsN1H8/tjuU/apNJ6PEzB5F8Ai
	jOKVVtypsd6xwFUyeI/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpgVz-0007or-9b; Fri, 01 Feb 2019 21:38:23 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpgVw-0007oS-7v
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 21:38:21 +0000
Received: by mail-vs1-xe44.google.com with SMTP id x1so5100166vsc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 13:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ZolcCNA5WhBYaoMj6VW21S7jHE85IHON0s818eqPUk8=;
 b=AT1kuQXzLUyDbbVV1qC9f3VCGjLkvpaERoaft9QtaIOh0yOjwwjMghgc90IXvK/q2X
 PuKRUQk/VLlFMZ+cMLpz9BFNdPTt2lPSWPeU53RweOuW58qZUHt21CfwgB6HiT1U+AI1
 yb0OWmgpcdKuOx/hb4uBYajRPfLna3XW+tu1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ZolcCNA5WhBYaoMj6VW21S7jHE85IHON0s818eqPUk8=;
 b=c3yfeL2OPoel/Gl30/cKJH5DLC+q6BiN7n3CHHTbdFZVhpCE7vEbPtgdk0ipwp+AyV
 ITzY74tOIFZIsX8zpAZ71oM5jZVm+Ww/ZnJ7jZqYm45np7HL1pddtPJTBFp3ShQwEAZz
 Ht701Zzz/b7NrIZNaVFSXUCYrb7byc6+3cNDu5ZSPX4fCQwvxMLBIipppaPxCJ+e+288
 Ew8hJGFOE7gzMJM+IWlYaOCDHQfDT4JqTcw542lw1LPneTiwAehUicg/YAovEoLGzcLl
 pMDKKylS8NXU+1jvoS41xFqKUZCxqpmwbOd74xhT5pL3xxWDAZsVfEtSgI2TMxGEI0xc
 Gqug==
X-Gm-Message-State: AJcUukeI1DXRT5YXJxJf+mBD0NW3cDmjpni3TCWWpSvvN6GupnFrJhBi
 DgnIFNXFpWl/xhciTIQ6fzz3AjQCJV0=
X-Google-Smtp-Source: ALg8bN5ZoGHF+Vhua3DhKW7wAhXUTfgW9Nh/dpmoTe8LO1ppKNXL6Qor4ZPOamY5lyMfxoMx5W85gQ==
X-Received: by 2002:a67:ea50:: with SMTP id r16mr17275011vso.61.1549057097945; 
 Fri, 01 Feb 2019 13:38:17 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com.
 [209.85.217.52])
 by smtp.gmail.com with ESMTPSA id e74sm1215626vsc.10.2019.02.01.13.38.17
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 13:38:17 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id h78so5113721vsi.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 13:38:17 -0800 (PST)
X-Received: by 2002:a67:dd94:: with SMTP id i20mr18725813vsk.111.1549057096626; 
 Fri, 01 Feb 2019 13:38:16 -0800 (PST)
MIME-Version: 1.0
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 1 Feb 2019 13:38:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X+YOf6Pt8bwuh0KCs=H3KTAW3atLLEP_X-5BMqtYMyZQ@mail.gmail.com>
Message-ID: <CAD=FV=X+YOf6Pt8bwuh0KCs=H3KTAW3atLLEP_X-5BMqtYMyZQ@mail.gmail.com>
Subject: Possible to annotate ARM64 IRQ handling to help gdb?
To: Linux ARM <linux-arm-kernel@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_133820_308542_4B4E2B94 
X-CRM114-Status: GOOD (  10.36  )
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
Cc: kgdb-bugreport@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

I was wondering if anyone out there has given any thought to
annotating the ARM64 IRQ handling in such a way that we could stack
crawl past el1_irq() when in gdb.

I spent a bit of time on this a few months ago and documented all my
findings in:

https://bugs.chromium.org/p/chromium/issues/detail?id=908721

I can copy and paste all the discussion from that bug here, but since
it's public hopefully folks can read the discussion / investigation
there.  To put it briefly, though: I can stack crawl past "el1_irq"
with the normal linux stack crawl (which is what kdb uses) but I can't
crawl past "el1_irq" in gdb().  After talking to some of our tools
guys here I'm fairly certain that we could solve this with the right
CFI directives, but when I poked at it I wasn't able to figure out the
magic.


Anyway, I figured I'd check to see if anyone here happens to know the
right magic.


-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
