Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C60C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:38:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C46208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aiWbILhH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ex4kS9Dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C46208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hov4t5nz1Js3ANv0RHESwbTOh0pq4INYRa4mNp85PvQ=; b=aiWbILhH+KjIuD
	bkz4TcXj8fV0OwJcK8JSJTfVMGK3AkJ9NI4hGSMNq5PtFrRqj5hB1NIpvlrpywH1hzNhpVADqnk/D
	Q9bjDpKF+m9Pd9oBta2LuwPq6Q9LIASJ8YDNPv7phvH1BuSy0lgzBaM6I4O6WgufdJbCL3Atamjg+
	ZEYLOoIJwSdh8pae3qDgHqsYEDsRYMqM1N9tmwj5vGOa5wg2WTDle06s4P2MFEUFE6QWw3xuGMB3h
	eL1Mj6ozuFtfIeDIPsirg16h0mo5DSHZ15cnDa5N5wVf0opWklgsV74bDDeuHAG0CxTAnNP9222if
	bElfMG0jVjtLisQhwXDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUgkE-0005Bv-NL; Wed, 05 Dec 2018 23:38:18 +0000
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUgk9-0005AE-34
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 23:38:16 +0000
Received: by mail-yb1-xb42.google.com with SMTP id d187so1345347ybb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 15:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ir9MSZpuxM6D+erZKZloWc1q6q+x3L3ZGqxz9Yh0TO4=;
 b=Ex4kS9DtDYkQSIpsukKr0vhqfyhKwtBBAxa+l0KRVdbys2db0GHKhtpTI8P/60oSf5
 TbN0Z5qLrMprijW2j70mBM4T84o953HSSt5xaYgiT+7SeqkVjRctaS+3Accf69cce6TM
 aL4RlmS3NGyupnxZ+/atvbPk0L+VejHQcvcrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ir9MSZpuxM6D+erZKZloWc1q6q+x3L3ZGqxz9Yh0TO4=;
 b=hvkZOeYs2nsVejxgWL0uxN0hJBLX1g/ymc3gEoP104jypCppGgR20D3RfK9f8h4J5G
 aaJQ/0DZXOlFl89lwreNgjcYL7jOgNzcOOV9jdApBvl9QWKiH8XajciLz9VJ0epPNwTL
 Qyzgpp0M+L13AiuqKIfH5K4oJNCN9BDbTx7gG9K8L5JLtu3ci9kxe59tRTEPUqb6zzlg
 y8fSw+RCh/AbZrL8k5z237fdRKku2BMb097pvIhg1gS4zzo/XDSzxSujzv4jStyb4yTt
 7DA2GN57iP/kz3c5yP2Jv0pOHlhMeODcjGKLXZ2ZkWqi+KLy50/CHoSFbDgsPBSTblL+
 U9tQ==
X-Gm-Message-State: AA+aEWbVjC5F+siekbTgF8hhTrahzV7mj6lT1q0t3en3pHHW2iZg8RfL
 i+faUXJUyMmfXEoZ+wsL4F7AWaPD4Cc=
X-Google-Smtp-Source: AFSGD/U/qdm1itgkZxldnFozfW1eKHg1tOYDRwlgiEaQFTN5gkBg6kM0Uk3uXC+hS3/j9eRvT+RupA==
X-Received: by 2002:a0d:d343:: with SMTP id
 v64-v6mr15203577ywd.68.1544053081861; 
 Wed, 05 Dec 2018 15:38:01 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com.
 [209.85.219.171])
 by smtp.gmail.com with ESMTPSA id c140sm10093348ywa.74.2018.12.05.15.37.59
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 15:38:00 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id s8so7511597ybe.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 15:37:59 -0800 (PST)
X-Received: by 2002:a25:a445:: with SMTP id
 f63-v6mr24461270ybi.171.1544053079487; 
 Wed, 05 Dec 2018 15:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
 <20181123221804.440-2-ard.biesheuvel@linaro.org>
 <a16dc0bb806d6a0685978bb94c2e3f19588c063f.camel@intel.com>
In-Reply-To: <a16dc0bb806d6a0685978bb94c2e3f19588c063f.camel@intel.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 5 Dec 2018 15:37:48 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ915yAyLWQgGHLH5w8zn4rZTP1VTj=egReG5edwTh8pA@mail.gmail.com>
Message-ID: <CAGXu5jJ915yAyLWQgGHLH5w8zn4rZTP1VTj=egReG5edwTh8pA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] bpf: add __weak hook for allocating executable
 memory
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_153813_137596_980CED8A 
X-CRM114-Status: GOOD (  15.61  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Eric Dumazet <eric.dumazet@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jann Horn <jannh@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jessica Yu <jeyu@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 26, 2018 at 9:02 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2018-11-23 at 23:18 +0100, Ard Biesheuvel wrote:
> > By default, BPF uses module_alloc() to allocate executable memory,
> > but this is not necessary on all arches and potentially undesirable
> > on some of them.
> >
> > So break out the module_alloc() and module_memfree() calls into __weak
> > functions to allow them to be overridden in arch code.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
>
> It looks like some of the architectures call module_alloc directly in their
> bpf_jit_compile implementations as well.

Ew, good catch. :P

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
