Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D549C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:48:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AE021720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A+sA+Sg3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ftWZxabR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AE021720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JOBBA/N6WJ8QcQqVAcgVsGvtb+E1H5xSJkUoWfALNck=; b=A+sA+Sg3AwzHoK
	kAGlMJyPH70FoioWPLh6jNDOCmhgAq8tJUkBBaWmJZ6s4CJvb1gafA2thcfzV79LHpiVzlKwUk5AI
	Z1TtzvLM2t3N3L1BAAtVnzGjcu+eF/jNxG/VBXuHTYMg9FyjiYMj7F9cNsAlLEJlVJKlmOipfqGzs
	776YKD7AKNPPlmv+S5gnZKVc/T2f3XGtG+yq334J6Q0y9XnXtrbjqlWzu6As7AnfR/UXM7VGJuXMV
	ZgFLNn0vG9nUsqbcevfHSxI23JAD6HkXoT2glRLiPPclv+bNeb4hXZ9BboL5EjfHI8uyY/wEaSfIq
	Xz0kE5XukMnMCPq2xDNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbyJ9-0007b1-2E; Wed, 26 Dec 2018 01:48:27 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbyJ3-0007Zn-Gz
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 01:48:25 +0000
Received: by mail-lf1-x141.google.com with SMTP id e26so10097908lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 17:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dAxzPJk2gWqSyzfmcd+C8/dL6RfZa0QYIbGXGr2SG0c=;
 b=ftWZxabRfgqWvjOrArSWeXWM+WF1WOTeFkPB4X+H7d3RT516rLzgxAyHmIhG5lPG3V
 9alG2ocl9Y4DD960RWGyjyKqb1N0qIqh03qaBIHJDCHokMd8pS9+ieGB0mfntX4+yzE8
 lxg6iD9C+9lnHlXFMaCKFRRKl41NzsLFD/lac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dAxzPJk2gWqSyzfmcd+C8/dL6RfZa0QYIbGXGr2SG0c=;
 b=nC2syp0E1vYRAzqT8kMFA7xxFv2R8rVrkoPnLuQYtOCHhdCZAnjnHmeEdMoRvkPzj7
 eJlibJwB8rMoDjgcvpBPYkFN6V3MsVEQTiJJXsRgo/08M/Li6Yw9570cmH+cXBXSqjKn
 QJOrB9EhjTtFsZN4lLXcSVhBPNKFeUXpaIA6NGPM7TejFk0WbeoLd+N9qDDUgfpO5hjj
 x6IH98zsNJJ/BYnAA8wHyaDhXkXCUzTnGLE3Ddll61pf+f6RioM3C1baLEg0cwytKYIP
 EhvimPWaYqkBChdZlLmOZ0ol7LKSreAb/Yz/BCxW0gS59Ds2GoWnqMOu7V0sQX+8UKQ4
 Yluw==
X-Gm-Message-State: AA+aEWaOlHQBvxRKKOOPFCwP0wjyqe+SzgCdpb+EHqh/p9ZCuWLE25hN
 2BqqKlur/SE2+1pQt51EQB2/Ps0NVWM=
X-Google-Smtp-Source: AFSGD/VV3KV1R1R6Xk5zhYAZBzpDIz5c8rUF6dxoDSvl4pJQJDi1wCixU90SW3EhAovarGtSSJsWdA==
X-Received: by 2002:a19:4402:: with SMTP id r2mr7415507lfa.111.1545788888759; 
 Tue, 25 Dec 2018 17:48:08 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com.
 [209.85.167.44])
 by smtp.gmail.com with ESMTPSA id x29-v6sm7261044ljb.97.2018.12.25.17.48.07
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Dec 2018 17:48:07 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id y11so10075890lfj.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 17:48:07 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr9439374lfg.117.1545788887326; 
 Tue, 25 Dec 2018 17:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20181214161412.GB8148@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181214161412.GB8148@edgewater-inn.cambridge.arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Dec 2018 17:47:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiYb72J3F7=X1KBRQwOkd_rJPNmRmHF9QaM+-K_6K1eBw@mail.gmail.com>
Message-ID: <CAHk-=wiYb72J3F7=X1KBRQwOkd_rJPNmRmHF9QaM+-K_6K1eBw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: updates for 4.21
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_174821_562722_CA8A3235 
X-CRM114-Status: UNSURE (   9.71  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 8:14 AM Will Deacon <will.deacon@arm.com> wrote:
>
>   * The A76 workaround for erratum #1286807 landed in mainline after -rc3
>     ("ce8c80c536da"), so there's some shuffling needed to accomodate that
>     in conjunction with the workaround for erratum #1165522 here. I've
>     included my resolution at the end of this mail.

Yours dropped a "If unsure, say Y" that should have been in both
config options in the Kconfig file.

Mine? I don't know, since I don't do cross-compiles, but it looked
sane enough. Somebody please holler if there are problems.

                 Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
