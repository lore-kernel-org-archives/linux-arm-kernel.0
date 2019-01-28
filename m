Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28533C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:29:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5BC20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LkHA3Myd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxYrYAks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5BC20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CjVZPyUggnr6Lp3MlvuOqQWNKS5AHth9KgNgoX26960=; b=LkHA3MydiQjj7ZdHVkWdDsNgK
	dDRK0K+dRFKBwye5G2uj2sN0DT4Dr09U5AL8JKjPdL5nRD8OfFRnMIzHq90DA578PVNO4UvRfdIUF
	KxZmHxWRoE5zWd+A+1JBndIT4h8SEcghN0uijtvUvUW89nqZ47vcvwBuo6j0Szhip5gvM+hJs6g2Q
	fgLLQONmwawNyJzYJMIcInP5eu6vLeEAcJ7x+QbzodL+1p23dpe5a33YN2R+NzPppo2XpaX7rw+6f
	4IHuD+OfxjIhcuF69J2nj+9qCdJXQ1s1WAvtPS5neLpMFQGDpJyPYcOz516IpafOYVBZtpHzB6gv6
	Bl0IdwISw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2I0-0001Yn-V1; Mon, 28 Jan 2019 08:29:08 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2Hw-0001YN-T2
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:29:06 +0000
Received: by mail-lj1-x243.google.com with SMTP id c19-v6so13420479lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 00:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Cr0Xvw30nlRoRenB6A+Xtlvq8eKjofNGXUNco6MaAUQ=;
 b=BxYrYAksWrbzcMFPdGNfy68pu99ouzCMCV0mjEgC5c4C03ALt3H8/Ose+ibTbxdY+s
 nMA2UkQKk3EAsPLj7Ir7IhC8stI0TZEiWD2GQ/AmX2H7qmmMf7ZQeAEfGyCKVQup5lSy
 hR+2Mt/JepEs7isaGqI9rQiyquG11lfhdgSGcrPgMyUxQ7Zs0frSVCJtDZZdVOeZPzS2
 3CGCnW+n2AJQv5tKXYsSmbpvSYSQa+BOGN2jcur9r/m3LbEhWTUbTNf37zzaLjyOFW6E
 2OAGr+v02zDznpt1OinBcEiIwlDA1ZR3GvLpxiTHqPGfj5V/Rp6UgyONXo9dFRqFwkhV
 qw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Cr0Xvw30nlRoRenB6A+Xtlvq8eKjofNGXUNco6MaAUQ=;
 b=BKnDgkS8YAve4nCJpFY1YVaKJPi/j6mEMDHt5LYPFDjGyIGFJgj7S4xllxL/54axH4
 sqtP+3iMBBuRpYIgf+NAgMUwYY2DYdYkPGVogDral+uGhbuyCZLD/drao+Q1h874Nvd8
 kt6nMsKpbNQJGz1tl6pPEoNtidsUyedH0fgvcG99N+Hixs+2jlxKv2EyIc2Bd7cddWoh
 qBTfJ2xgbWaMcv196D4AldiJjpTuJG0SoDPq/qd49LZaPqhS/PcXzBf9Xrp7khnQtiOm
 oCaD+Diabuzm7SbLl0SImvCaqmLFso5idlVBlxrg5hXzxEXdhE7d61CM1FWKoJHuZx+/
 LLAg==
X-Gm-Message-State: AJcUukf4aj3oAoioRenLg332a2J75/VimMwWTLLApsiJu4tE5bv93dKX
 6VBXGv1DZTpPNi4tzP/zSF4=
X-Google-Smtp-Source: ALg8bN5LLVZWXUpWBs8gJJvQE2wwTSFPDzPRuPjWs3XoZ0dqt1PTVV+EZAXWx23OwmybcJvxoa8Xsg==
X-Received: by 2002:a2e:9d17:: with SMTP id
 t23-v6mr8987847lji.57.1548664142550; 
 Mon, 28 Jan 2019 00:29:02 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
 by smtp.gmail.com with ESMTPSA id
 m1sm2788894lfb.56.2019.01.28.00.29.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 00:29:01 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH] arch/arm/xen: Remove duplicate header
To: Souptick Joarder <jrdr.linux@gmail.com>
References: <20190107173719.GA30197@jordon-HP-15-Notebook-PC>
 <eab5c59d-cfb4-bd2a-de07-7db827830472@gmail.com>
 <CAFqt6zb0cU3TjAs0LO-DL3Ut98-7=b7cP9+hZ+bUxDLD2EN2vA@mail.gmail.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <cd855c41-dca0-14dc-6703-886feccd34ea@gmail.com>
Date: Mon, 28 Jan 2019 10:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zb0cU3TjAs0LO-DL3Ut98-7=b7cP9+hZ+bUxDLD2EN2vA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_002904_938005_3423BCEB 
X-CRM114-Status: GOOD (  13.75  )
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
Cc: Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
 Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Brajeswar Ghosh <brajeswar.linux@gmail.com>, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+Boris and Juergen who can also help getting it in

On 1/28/19 8:34 AM, Souptick Joarder wrote:
> On Mon, Jan 14, 2019 at 4:08 PM Oleksandr Andrushchenko
> <andr2000@gmail.com> wrote:
>> On 1/7/19 7:37 PM, Souptick Joarder wrote:
>>> Remove duplicate header which is included twice.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Can we get this patch in queue for 5.1 ?
>>> ---
>>>    arch/arm/xen/mm.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
>>> index cb44aa2..e1d44b9 100644
>>> --- a/arch/arm/xen/mm.c
>>> +++ b/arch/arm/xen/mm.c
>>> @@ -7,7 +7,6 @@
>>>    #include <linux/of_address.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/types.h>
>>> -#include <linux/dma-mapping.h>
>>>    #include <linux/vmalloc.h>
>>>    #include <linux/swiotlb.h>
>>>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
