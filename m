Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01779C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:23:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F8721738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HcNDpYpV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERUZ9+BB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F8721738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZWglzfgi6J7CyAdedOgIBHZSWL9LNrRoWHULxYNTag4=; b=HcNDpYpVEYUbyq
	1iCP8OWs3w1wAkKQg2hM/xPHmJZTde9hZXLU263VT3j1ZTJjxE71grBRMR2hlLWQBYnjAUBPNOfgN
	CeZ51aeN/uphaLqLKmUXgF2HYppryzndXPbtRkM8YDuke4SXcAF9NX9vEmgacQnkOnbDqoOU2VmuF
	LSNzE1geGuakA8NPv5SQ5IOnmQEMILoi3that1ECDVNxci8I0V+qRPhhlT9yaitPfibwoI7y/enyy
	put1Q4bbzZsH3X7GswlakxFDTg3rTAxzpXeC1gmJbFDiED7XUl9mssPGtUFfHHBguz1/IV4F7Cwuh
	jrcoHBId2kPfnL9KmLWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBxH-0003lg-EV; Wed, 09 Jan 2019 11:23:27 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBxE-0003lA-BD
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 11:23:25 +0000
Received: by mail-pl1-x644.google.com with SMTP id gn14so3444878plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 03:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qHzQp0kiXKxLyhNLmld/2I5RlSC4SJfARu4BS/3WG9Q=;
 b=ERUZ9+BBcdoGzDZjgRpZulY/jkDZef5hPSUjn5MPBnZ75et591KFNgm789NlRFxUHc
 +NXU/3Bm5pdSuvo8PWXhqoS8rd3lTgmr0xLUSSSpJEG69I/tsSeMIfAsYSK7FReyRsfU
 S12AylVeXNNQxyjZx6FCV+JbOAAYKgocXS8JYxcMwqdNxiLzCIBlW47SzSGk+ZHmtHIX
 qcuYekr15FEoc0MFoMG2beI+okdJ2DF0IAU1uARicg6IgEli0vljZR+lXW9f/pkmc9th
 gxF8yPG7qlQ3DTN7STXCp0RPyC3I4OLCH6XS/4mXW9xp/hg6Zfw5PYkmB50ilbklhFwc
 UI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qHzQp0kiXKxLyhNLmld/2I5RlSC4SJfARu4BS/3WG9Q=;
 b=hcmbLqr9wKNuTuTfdajhHkuVjdegBYae4x0ksgdHZ6P60927AGOe2d3oDDmGZY3U5n
 /nN3I42wh14bwn1SZYxJw2AUzpIK3enUcc+oswQAyebUZhuUU0WAMKxUbqHiTEriGgHM
 /HjgRb0VNyywz3wEZKRX6oVD4yrPXy7Nlc/+njHYVdd4PgCjIme5ZU6mfPmpIfSXNiYF
 ksicrJHMnOrFdSNDS4vTvNiASByYvxAjvGktbzJULGxPeZyXDVqooe2n6tmbLlsxK6Aq
 hGParefAVQSiLD7t92TqO7TM8lAAeLDuxHqAN+ra6Cv5VIr9VhXbakZ6PtiysVCOKNBQ
 YUUg==
X-Gm-Message-State: AJcUukdCfazOf084+ChZvVTnkD1zQzgrUkPkz5y1422guh46JWcPiSvE
 6EURpKx/UhfhJ8otM4vFKXUwSKAfXqhQjRmK++Du27LH
X-Google-Smtp-Source: ALg8bN77kthZIpSSKtB/V7To/2gKvPymR90In5qxOXqM9UcaQ5lsus/M2q3f7W9S9GrLnEwYRDUECm6SOj5nw/LTX8A=
X-Received: by 2002:a17:902:4081:: with SMTP id
 c1mr5747105pld.87.1547033003677; 
 Wed, 09 Jan 2019 03:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20190108175818.705110-1-lkundrak@v3.sk>
 <20190108175818.705110-7-lkundrak@v3.sk>
In-Reply-To: <20190108175818.705110-7-lkundrak@v3.sk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 9 Jan 2019 13:23:12 +0200
Message-ID: <CAHp75Vf7ctTmncjOfMKL7MDAi=4rr2huBmZ7RsAnPKyJv7HTQQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] Platform: OLPC: Move EC-specific functionality
 out from x86
To: Lubomir Rintel <lkundrak@v3.sk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_032324_383279_52F26B09 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, James Cameron <quozl@laptop.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 8, 2019 at 7:59 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Move the olpc-ec driver away from the X86 OLPC platform so that it could be
> used by the ARM based laptops too. Notably, the driver for the OLPC battery,
> which is also used on the ARM models, builds on this driver's interface.
>
> It is actually plaform independent: the OLPC EC commands with their argument
> and responses are mostly the same despite the delivery mechanism is
> different.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>

>  #define OLPC_F_PRESENT         0x01
>  #define OLPC_F_DCON            0x02
> -#define OLPC_F_EC_WIDE_SCI     0x04

Still same concern, i.e. if the initially added definitions are
coupled together by some reason, why we split them?
As I told either move all, or none or put in commit message how
decoupling would benefit.

> +       /* EC version 0x5f adds support for wide SCI mask */
> +       if (ec->version >= 0x5f) {
> +               __be16 ec_word = cpu_to_be16(bits);
> +
> +               return olpc_ec_cmd(EC_WRITE_EXT_SCI_MASK, (void *) &ec_word, 2, NULL, 0);

No space is needed in "(void *)&ec_word".

> +       } else {

> +               unsigned char ec_byte = bits & 0xff;

Shouldn't be u8?

> +               return olpc_ec_cmd(EC_WRITE_SCI_MASK, &ec_byte, 1, NULL, 0);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(olpc_ec_mask_write);

> +int olpc_ec_sci_query(u16 *sci_value)
> +{
> +       struct olpc_ec_priv *ec = ec_priv;
> +       int ret;
> +
> +       if (WARN_ON(!ec))
> +               return -ENODEV;
> +
> +       /* EC version 0x5f adds support for wide SCI mask */
> +       if (ec->version >= 0x5f) {
> +               __be16 ec_word;
> +
> +               ret = olpc_ec_cmd(EC_EXT_SCI_QUERY, NULL, 0, (void *)&ec_word, 2);
> +               if (ret == 0)
> +                       *sci_value = be16_to_cpu(ec_word);
> +       } else {
> +               unsigned char ec_byte;

u8?

> +
> +               ret = olpc_ec_cmd(EC_SCI_QUERY, NULL, 0, &ec_byte, 1);
> +               if (ret == 0)
> +                       *sci_value = ec_byte;
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(olpc_ec_sci_query);

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
