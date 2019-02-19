Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B964EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:13:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5CA2086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iXGyH/03";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+Nngyw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5CA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4xLPCq3Vk5Gy8EN8dS9PuP4gZ83YxOsGjWAbNm+8yIM=; b=iXGyH/03BIadPU
	gV/8vCVekMTWmNIEOoUtKwsOHGAfN9Mx/Om5Z2lFVOU306qT7xCR3raK+A3/WQ+ZWazzIB1ZG7L4t
	myWkqrqof27TK98vJO8fwvzi8hUCOyNOm4spCF10LLaEbgTc9lXAgx9PdDfKljywhrJ0DsC6Z4/Hf
	GTtkx26C0niv/DdACMKhM4ZpGxD9SPcz9WnWnVNvevW0Y4r6dkd549WbPa4RcpOwXTtdZe3I2gFrY
	36Kml/rPjVCYBvvAwUTSsvk8I/2Z4hSB/YHWjszwag3W5w0BdBNDxJMnysS5bcW0c25DjuNk/Q6N0
	uduu7bV++YnNMGhMIXfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw4HW-0001gA-Io; Tue, 19 Feb 2019 12:13:50 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw4HR-0001fq-Ca
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 12:13:48 +0000
Received: by mail-it1-x144.google.com with SMTP id d125so2710553ith.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 04:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=01TY49B0fjbuoDWfHIk8zqjQoT0fgyC5QybHYS1cbBM=;
 b=G+Nngyw0UBYtWltq95x75GU3ToTZ5tGkoqYZRgQph9+vmekdNjQUAB365B7qzCwBJH
 imvXP2xczRVyKtBinzPsKRNOgelgq5MEUlajQvJqI/iwbdh3LS33J01+I8wzWCGai77v
 DF0pS7zVmxtgAspxJL5WNgCpuPbBJnL7fqMuxxMf6K4po+MyibLKDsrnXyWpoNFyiBxm
 yvVUUnPar+dWXtlxwZeySW8trwJINtuCigvAzzLBq5rM2Ca8PiV/LxmYaqd2iTAbmEoh
 cT646K4vvdUxooppV89nBeAPGxFwrk7i/C0ATWkiR/OKafnjw0mk4Lcn2gZxJcbp1XGb
 4+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=01TY49B0fjbuoDWfHIk8zqjQoT0fgyC5QybHYS1cbBM=;
 b=b6M+qv8lYkAYVeYfGpeGp+sK2RlXv7ftLuoDcL7pv22C+p00mL7KBHdMgK+eCJtfPs
 nU3Hk5+I3wBGyTRDWxYvQ2yhqf6mg0cX6FrEgEZem/nvXg6f4a9vhFvruxl1JTFhIMIN
 s+ZQpGzThl8OJYtW/75SZu0qVtAAgNhYsG+rB2KaPG90M6o+oKjRE6WPzY5ZlhTDVTbw
 V9YNgom8BX4f9l5LfmVvuwiKA2g3nNbQy338ppUeU5TIfsAdPqcXA6Ma+k7XsunZzSz4
 ugIhlJX+Cij0zYqWQMbEjs+3H+mF/nQBQdBbFB3RRw9zTWeC/s98gl+w7oXcs+jAvgOC
 G/vg==
X-Gm-Message-State: AHQUAuZh0QsMOWptm4dsWAw9+JdtaO19Dy/81cDjB5hWzp1CRZIFzCzu
 YxqCmmjtFBer8CJFG6q2bp0UeZ+h3Y/mRWkwdcLriw==
X-Google-Smtp-Source: AHgI3IZRKu653o5gClF48egdwQb3BGkHNYQPjGFP5rqD9JdYWJLOYa/HaXaSuPuF44kpRBlESs9BwTuMNjJxNwD+ODE=
X-Received: by 2002:a5e:d609:: with SMTP id w9mr15780978iom.170.1550578424296; 
 Tue, 19 Feb 2019 04:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20190218170245.14915-1-steve.capper@arm.com>
In-Reply-To: <20190218170245.14915-1-steve.capper@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 19 Feb 2019 13:13:32 +0100
Message-ID: <CAKv+Gu_xOFXLwKsrFo-rBXdgk4O6zm6xPHB+tv1XjDjzyrjhEA@mail.gmail.com>
Subject: Re: [PATCH 0/9] 52-bit kernel + user VAs
To: Steve Capper <steve.capper@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_041345_551617_99A94B12 
X-CRM114-Status: GOOD (  17.96  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, crecklin@redhat.com,
 Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 18 Feb 2019 at 18:05, Steve Capper <steve.capper@arm.com> wrote:
>
> This patch series adds support for 52-bit kernel VAs using some of the
> machinery already introduced by the 52-bit userspace VA code in 5.0.
>
> As 52-bit virtual address support is an optional hardware feature,
> software support for 52-bit kernel VAs needs to be deduced at early boot
> time. If HW support is not available, the kernel falls back to 48-bit.
>
> A significant proportion of this series focuses on "de-constifying"
> VA_BITS related constants.
>
> In order to allow for a KASAN shadow that changes size at boot time, one
> must fix the KASAN_SHADOW_END for both 48 & 52-bit VAs and "grow" the
> start address. Also, it is highly desirable to maintain the same
> function addresses in the kernel .text between VA sizes. Both of these
> requirements necessitate us to flip the kernel address space halves s.t.
> the direct linear map occupies the lower addresses.
>
> One obvious omission is 52-bit kernel VA + 48-bit userspace VA which I
> can add with some more #ifdef'ery if needed.
>

Hi Steve,

Apologies if I am bringing up things that have been addressed
internally already. We discussed the 52-bit kernel VA work at
plumber's at some point, and IIUC, KASAN is the complicating factor
when it comes to having compile time constants for VA_BITS_MIN,
VA_BITS_MAX and PAGE_OFFSET, right?

To clarify what I mean, please refer to the diagram below, which
describes a hybrid 48/52 kernel VA arrangement that does not rely on
runtime variable quantities. (VA_BITS_MIN == 48, VA_BITS_MAX == 52)

+------------------- (~0) -------------------------+
|                                                |
|            PCI IO / fixmap spaces              |
|                                                |
+------------------------------------------------+
|                                                |
|             kernel/vmalloc space               |
|                                                |
+------------------------------------------------+
|                                                |
|                module space                    |
|                                                |
+------------------------------------------------+
|                                                |
|                BPF space                       |
|                                                |
+------------------------------------------------+
|                                                |
|                                                |
|   vmemmap space (size based on VA_BITS_MAX)    |
|                                                |
|                                                |
+-- linear/vmalloc split based on VA_BITS_MIN -- +
|                                                |
|    linear mapping (48 bit addressable region)  |
|                                                |
+------------------------------------------------+
|                                                |
|    linear mapping (52 bit addressable region)  |
|                                                |
+------ PAGE_OFFSET based on VA_BITS_MAX --------+

Since KASAN is what is preventing this, would it be acceptable for
KASAN to only be supported when you use a true 48 bit or a true 52 bit
configuration, and disable it for the 48/52 hybrid configuration?

Just thinking out loud (and in ASCII art :-))

-- 
Ard.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
