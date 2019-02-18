Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EFEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:54:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765472084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o8G5J7UH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DsbETMis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765472084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YBPq87r0eoT79Z/vNkDuoFL/mFKNNghoCK0D4lNYd5A=; b=o8G5J7UHl67n92
	r8Q9gSAYqrUyGKC/WtuH5j+2uuOK42ZRvYElzSkJo8sHGlbHQ6sFaSgcCcNEphPkaDKKQk1JCuT+S
	eEaaj0jc18bqgfszn2WNnDby0nruSKKSTV2nGbdnfgyJGYjGK724ZZ9Os69VdqqsXAtluWzUDSmrq
	EDcshwqdMz2PEs3NDbVdsCEXh7bPL4N8TF0SoLdRoyxC7X2ZOD7ro7V/42qlry8t2K71lo7BO3QAe
	lhPBskpML9yyt8BXEPggZqGwWtntRpmsFtgIz/RUe/4tvbgH5G6My5NvZE2engvXStdEGQtzR5E+v
	Gvx7/q5NPLc18wIsSJWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvlF4-0007Zg-B0; Mon, 18 Feb 2019 15:54:02 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvlEz-0007Y3-7s
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:54:00 +0000
Received: by mail-qk1-x741.google.com with SMTP id f196so10202492qke.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 07:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=92e/VznH5XQ4jHrphTiBJuS311THvP1Iy46wzOErUls=;
 b=DsbETMist337QY5KKYKHkpzezMciT+GLylX1erdZoBCKWX4nvmz61RYdb7Szq86sRq
 75GGfxI2YcpFrI+AW7/ebgWdxJKsaF/Rd0NIrBzedSxh/F2at05G45HzaYKPpIZTSICC
 v9Nw6rOudP5/g0fma1ixw15BHIMXSsCWeIkfP6wXvMwszvQxJby3D6t029qhHMmkFGBK
 /B8dxtPMcZs2XfBRVjqa6KKPdsbsD8Ey0yyKLlvCjuMnzVINxK6yyX9KBdLIL+MY14Ox
 Sf8e1eSRKjCo7CJ/UyHL6pFcvMbM9dlAwoCQiS3/0lY9aJKgAw6mfoYgW8CKLkRH6qbJ
 0ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=92e/VznH5XQ4jHrphTiBJuS311THvP1Iy46wzOErUls=;
 b=Igu9UPAlT3kRA0UDL5OjvEjs5jpjKDp/juNEEaVic3CZfAf3u8gP97KKmmtVdISotr
 PCIhC1q+LQVfWStZb/fZCnL43iLgx9HHm8UE4pMNECooPUfeqk4gj2yuerO4J2092NTo
 zesKFuF8HQvZphXyBDBUmbvlk3H2zWvkYfw2crtk7tzE+BH692IHjTSIF3sSvs67VqjW
 d1FdH178Q0I193ELpYc1tcXGtJZO5HTdUpPHymsj4Smt0PdJnjW2LnEdJxRkJL7UXjaz
 u7dLZxsVSzxx3GGZhQQF9ZfVrRwTujeWetqmtwOYtJnbrsB8LLs9Ev+axHv711wJGZZ+
 Jgwg==
X-Gm-Message-State: AHQUAuZC4ZHYx/zV6DqL5dp/oKElrjqqqHPwBAcfVDIAAS2nrcLhaBY1
 fYRVfku3rQCJ0OPy5Wmlqflwow==
X-Google-Smtp-Source: AHgI3IZLkBNNpsUQecN0Y1ZnuWfF04xr+lqzQJYkbkrq3vrOP3KcGPWjfd7022Qxx+aKpuo93OXLaQ==
X-Received: by 2002:a37:9201:: with SMTP id u1mr17606536qkd.258.1550505236132; 
 Mon, 18 Feb 2019 07:53:56 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id 50sm1038107qtr.96.2019.02.18.07.53.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 07:53:55 -0800 (PST)
Subject: Re: [PATCH] trace: skip hwasan
To: Andrey Konovalov <andreyknvl@google.com>
References: <20190217043434.46233-1-cai@lca.pw>
 <CAAeHK+y8Xd1J2DppUMQLVhoc69wrqgNA=9hV45Jsd7V97CN6yw@mail.gmail.com>
From: Qian Cai <cai@lca.pw>
Message-ID: <dddc0e6e-af71-c98c-c8db-20c6d9fa87c3@lca.pw>
Date: Mon, 18 Feb 2019 10:53:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAAeHK+y8Xd1J2DppUMQLVhoc69wrqgNA=9hV45Jsd7V97CN6yw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_075357_334561_00945320 
X-CRM114-Status: GOOD (  12.34  )
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
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 kasan-dev <kasan-dev@googlegroups.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2/18/19 10:25 AM, Andrey Konovalov wrote:
> On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:
>>
>> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
>> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
>> because there is a burst of too much pointer access, and then KASAN will
>> dereference each byte of the shadow address for the tag checking which
>> will kill all the CPUs.
> 
> Hi Qian,
> 
> Could you check if adding "CFLAGS_REMOVE_tags.o = -pg" into
> mm/kasan/Makefile helps with that?

Yes, you nailed it!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
