Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD6DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:16:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D299206E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MU8Bgk7I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=android.com header.i=@android.com header.b="K954nPEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D299206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mCwdy6TGnoGw7Rq/wEtut4xSezhtbT1inZOF+Rx6OKs=; b=MU8Bgk7I3dValhmo6MyXAnFan
	9pbacep6izSOY7UlZJc28jFtrWLCOVE1PNHBXZiysgO6Ydq2lurzQ6rASbwxNZm03Gs6Wf1k+DUgL
	ifRgX5OquBbLqcJXJzbbk4zWzoJHyj6BmTmXOyB53kfgc4z9RGBXbw4tCkgswKyu0KmTBA9v4f0e5
	qJcd0jG8a0x7q9jYfhNBLaqxeCNcb95D0xU8eF33BOZ5wwcfRH6JVQ1VyEA9GmavGwoxViVgkhsKG
	fr92RABwcL4kczJZ40+bfZ7XXd9sPw7LgBun75+KXuBDVejkWXRSSQ3wtpG00ZjbM7kVqoo3VgbkR
	Ezl+vVpgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXs0P-0001Ot-9H; Fri, 14 Dec 2018 18:16:09 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXs0M-0001OJ-KM
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 18:16:08 +0000
Received: by mail-pg1-x542.google.com with SMTP id z10so3043284pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 10:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=android.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=QoXWVsfblDX0vgNXZECojRjf8HfC9B42HEMKbG78/+E=;
 b=K954nPElLZH2IcyMF/flYsoNIRdtVvhJs/qyfpkU4mcCX01aw5cqpgt0b0KsmsK/Xn
 C9rPTxG/Cu5I2HfstgSTi9qsjKHUonMEYTPGNFiGCitLw8FlsgHAKfDTM3ZRKOhu+C3O
 PbQlUSXP7AAOsm9o8GKD/ZqrQWPWkbF+pioCF1XdhjGljHpOjCGYBJvnLwgh60QcrVY3
 w6U6N1Y3xBdtGBCHNbm3Ut62pfPdfq7IrSoInY8XkstUtjUFY3aMq9fSqoVoG4I/HzEZ
 mRl0zMbyK5jWNEa38GsOjUcWsAL6Q1qJCOumrVxGRAYgs94vP6hajoY+1v4GwrL1GBZK
 nYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QoXWVsfblDX0vgNXZECojRjf8HfC9B42HEMKbG78/+E=;
 b=mp5enU3gBHlMtMNxbFvuLHy1662niVfVsEcyjpCptQETJYaNQFBoTKA2SNi/kDWkk3
 Z33cpJGTXPervp32pOybgpe7CihrFV4vdWaRsgO+V2HzdbRQzddkxldQEnc+NxG550vR
 8kd14fzXC+bfJoE5pygt7zoabfzKmWZ+JQ2t09g4ouo390wkhpGu+sI5ON1QRijqIJu4
 RKbFiAhRhguhpBFJJtlyK0+XHVyy3CtWzw6NhhbFVpCq6dNnyc0I9S29232JXUjZf9ln
 ad5ZXj43rEXn7GkgXC56/jl/zbd4w7HunuQktTgzmHuTMRtGPv04Sz9fk6xxf4xcYgys
 MJeQ==
X-Gm-Message-State: AA+aEWYSjPnJSfEpcff0BUtSN4GdoCgLM6fBEgB0QojJwoNNFlGFQ/5Q
 IwWgTIgmX9Y3V89XAFxiCJArKw==
X-Google-Smtp-Source: AFSGD/WKY8w8894SYTbKBjbOnz6tO1VZvcWJOuGBCjP89opaHX3qi2LXBwt+lT3bD/T8yZIgxJfJgg==
X-Received: by 2002:a62:6303:: with SMTP id x3mr3925923pfb.110.1544811355067; 
 Fri, 14 Dec 2018 10:15:55 -0800 (PST)
Received: from nebulus.mtv.corp.google.com
 ([2620:0:1000:1612:b4fb:6752:f21f:3502])
 by smtp.googlemail.com with ESMTPSA id l22sm8615670pfj.179.2018.12.14.10.15.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 10:15:54 -0800 (PST)
Subject: Re: [PATCH v3 02/24] kernel: Define gettimeofday vdso common code
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
 <20181213165746.56930-3-vincenzo.frascino@arm.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <51d9b642-d44e-1995-0bd0-91ce00a8526b@android.com>
Date: Fri, 14 Dec 2018 10:15:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181213165746.56930-3-vincenzo.frascino@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_101606_668652_17D1BBF2 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/13/2018 08:57 AM, Vincenzo Frascino wrote:
> In the last few years we assisted to an explosion of vdso
> implementations that mostly share similar code.
>
> . . .
> +}
> +
> +#ifdef VDSO_HAS_TIME
> +static notrace time_t __cvdso_time(time_t *time)
> +{
> +	u32 seq;
> +	time_t t;
> +	const struct vdso_data *vd = __arch_get_vdso_data();
> +	struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];
const struct vdso_timestamp *vdso_ts = &vd->basetime[CLOCK_REALTIME];

-- Mark

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
