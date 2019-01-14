Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50377C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:14:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217EC2063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JfKGSoLW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBbrDnCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217EC2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N6GRRwCE01+GZY5G4SIt4/TjDVNivqiPZ4MZvbYBfcU=; b=JfKGSoLWZZywfQ
	nD9LSUZszWTSdGtUiR61k0FYrb7D1wlJwJZnsU/zqbpPbWzSUyqX2dSOqsJ3+5IWObeoENswl4GOh
	+Kz+X0Ahc4JzbQ9bl/a8Ieoae0S6yS/43yHYevFM9pPBKwFczX6od3J8B1VpRVtzr8OvkyW9Wm8l+
	CO+vpmLgR6GMLTTm06iqBuSke+vPZLgIaR4AdSQelpKC4pKrZe+ehp1A5yd00NfeevhbVeb7k6v91
	FMGUrgze7DJPYOEO23g1BZPaFCN5isZ+6aesFPQQZ0rMjHGqHeqh1qTVI7zo41cDwEm7S92rnUD7y
	OlgT0liHtaaivBbLagpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj184-0004Rp-9Y; Mon, 14 Jan 2019 12:14:08 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj181-0004RO-Ac
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 12:14:06 +0000
Received: by mail-pl1-x643.google.com with SMTP id u6so10072058plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 04:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9rDzKOuL0UG5qQGT2nWf2dhs7fmgU+oCSfvYTEpYImY=;
 b=pBbrDnCxBKp/SJuRdXcl+9i0ufQYwz6AalCV8iIiIqNGD9npyX1NOlTqDUopV+bQV4
 6l1jv48D9uH3tNBQppzuMH+ofIwu1BD1nU5QSLw5vXRSceGHxFHha+71fCVdrx8QYiqF
 KkuqYldcZXNAY26wnm8q5cGodugN9QB596lD/56t1rjFSgEFX0E94U1xaa/SdacqAdoE
 PfyUvJ+tt2VfDO47MG2vS0drJkHSNZz6n51fqxWHu5qDRN+t24BKt95+KAfYivAkuzPx
 FYnaERSa8Pc0J9fmF1ozTACMvqVQKoSwjJIJgTqGP20bPfDFSWi8bmTZKKyM/GzOQrY/
 Gfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9rDzKOuL0UG5qQGT2nWf2dhs7fmgU+oCSfvYTEpYImY=;
 b=G/b5CkYdIqQs9kU8wUAk9W2CNJBYOMRX87PC2CP2xVwwQ92BtDww2pL/n24y1uqFQd
 sMLiJGoB0GSi3dA/JSKy9Mg4UWQY/MFeMjsULmOG5WUOsHeuqpUrZgAyvhrAY9AQGwbN
 4K3+IqGt7ugVtoNzMKsceQFOrTY1dGL3syd1qIQa5vcPXsXmLjul7Ti2Fq+PMDzFSPhF
 Vquc3XvrSb/+yi7ebkHKbFnt4oggM1qHeYo8HUHofncnon4nY6LR0Zcvif297Vm9AToU
 rNBzkjuD8XMnjxUlagjDEqEFT1YlccCYtfoBIQOCs20TdmjLjQ5Ixptu6OuSR8C45HLB
 42/A==
X-Gm-Message-State: AJcUukfI8lkgJRcIL/sEiGiYy1K90aIXlDKx+AS7Aa7OwjdT5Wng2UQY
 L8zv3z8IWD4w1mlIpKGq+zo=
X-Google-Smtp-Source: ALg8bN6vONMdv/cln8lQbUiW9tABKWpS0tNZBKGzuMdSUwCuDQui4P121o0Rx6T8lRoUghX4sDKfZQ==
X-Received: by 2002:a17:902:d01:: with SMTP id
 1mr25465192plu.127.1547468043821; 
 Mon, 14 Jan 2019 04:14:03 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id
 e24sm325936pfi.153.2019.01.14.04.14.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 04:14:02 -0800 (PST)
Date: Mon, 14 Jan 2019 23:13:59 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190114121359.GB26056@350D>
References: <20190104141053.360F768D93@newverein.lst.de>
 <20190104175017.GA7157@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104175017.GA7157@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_041405_368751_4B262A27 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Torsten Duwe <duwe@lst.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 04, 2019 at 05:50:18PM +0000, Mark Rutland wrote:
> Hi Torsten,
> 
> On Fri, Jan 04, 2019 at 03:10:53PM +0100, Torsten Duwe wrote:
> > Use -fpatchable-function-entry (gcc8) to add 2 NOPs at the beginning
> > of each function. Replace the first NOP thus generated with a quick LR
> > saver (move it to scratch reg x9), so the 2nd replacement insn, the call
> > to ftrace, does not clobber the value. Ftrace will then generate the
> > standard stack frames.
> >

Do we know what the overhead would be, if this was a link time change
for the first instruction?

Also, I was under the impression that some arch's do ftrace_call_replace
under stop_machine(), is that a possibility here?

Balbir Singh 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
