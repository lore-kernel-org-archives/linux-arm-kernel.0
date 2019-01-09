Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19347C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:14:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AD4217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uRBW7tEK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XykRR9YQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AD4217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q/5I78GbOe/3edMPQfz1IRyXlPp1ik+n27PBzdYFYcw=; b=uRBW7tEKPJdhJv
	PoJOWCra5Gd44qMiZ6bOVhpwIQAC9eKukymonXCC4OxzQjIQazqYtlSItWqgoK0rZyDRm0sjIa+5r
	Tp7grP4ji2Bb70R0w3b/Cd1/16wLSQmciwr1L3tgJL4XbvRX4haCmOSE8IryZ6cK3GT2fX5RMh0UI
	0shzwxuVt/ZpKCakS8ZOcz/j9kTYN+yEhSG6ULmakEVygNr2rb7if2bwmJTeiCce4GOyA5d61vT9m
	pDbAl3At5TA2+t5jZeRN0pMQybeHEufBbzraJOPUJ2o8se2HTo5DJUorppfb5tfb4V63fH0qp2dLt
	jITKmMqevaE2+Qeq/nVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBoU-0007g4-TG; Wed, 09 Jan 2019 11:14:22 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBoR-0007fh-VW
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 11:14:21 +0000
Received: by mail-pf1-x442.google.com with SMTP id r136so3507875pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 03:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/eNZY9q6gMJBzLpRRrOPLNavhG3GG/u1nKZ8Oan4i3M=;
 b=XykRR9YQuf7yi/o+TBvhRT+b9CRbZgWn4kboppAUocs8xJDaXIRe5pWmWK0+5PpKqq
 +oQ2cbeDA3SH9Z6IwTBGanbn3wVNxPPerzWYapCdngt4i/M0vQ9HheXLD4f9f8GdKfmk
 NcRazBf6Vk2gV3g1Ou+LE0+6lG1RIGMvwyk/Z5t70J11CkhucOBD+ipSPclhdRZxigc5
 Tx1YgTHgng19FKpowh/Do1WDCgZE6YOEgDNRuILAXf8nKbPTZN6KL4RWvzm+46e0AV9T
 lYXKFdxsj45yjdJoD0FGDKt/huVNg6FbkbZ61Oc4DICNWnX+Zt3elswR2KPAtnGg/GOL
 O2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/eNZY9q6gMJBzLpRRrOPLNavhG3GG/u1nKZ8Oan4i3M=;
 b=BSUbnWNKQgNUrO5NNvqCxNcIaztCaLxNLoR+b2MdA06J0X/NXHVbbDhhrVY5AfsSX8
 bLMQxYxj0Bz3W1pLzotEsA+g/v8Ruc0HMeF+WEnteml38E/I34ze8reCWiJGtS52aPUW
 D98uu/FGUFyTiohhOnvLzTna/47P6YvdOdKHJfVaUbNHylmdXA+WtRgWwsYH26o6eIo6
 L9aHpBPhseqCPIqK3N0+dLKbHYD2wBNQlwxApJDMxFLIWMUOqkOLjKtDhf1vxMA9DVym
 sM+c7NUIqK9DEum2z61qf3rbtGDcylAyUa37tm+Tw4LjWU1pDp7B44LvldAgaI6Ub+Qi
 A8pw==
X-Gm-Message-State: AJcUukfEMdbJgWfTtJP+rzKZ7Yp3x6BHtAR72QtKANmcrEIB9YmlywLS
 atRFra44O41bLUziSo3W2jbxmx8TJHkAtbnUMcs=
X-Google-Smtp-Source: ALg8bN6Ii0qL+nFHo00LYgP8+gc2FFonpfKji2qQUiXyg/1u3ZeLEza3v51nAoaZOOwiAcmerM5QdD/LF/fdajxu8TU=
X-Received: by 2002:a63:f615:: with SMTP id m21mr5098236pgh.428.1547032459101; 
 Wed, 09 Jan 2019 03:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20190108175818.705110-1-lkundrak@v3.sk>
 <20190108175818.705110-8-lkundrak@v3.sk>
In-Reply-To: <20190108175818.705110-8-lkundrak@v3.sk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 9 Jan 2019 13:14:08 +0200
Message-ID: <CAHp75Vf=B4TxZ5ETXaezQAm3HGzQ6cNkApwxq+3_fw92phumkw@mail.gmail.com>
Subject: Re: [PATCH v4 07/15] Platform: OLPC: Use BIT() and GENMASK() for
 event masks
To: Lubomir Rintel <lkundrak@v3.sk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_031420_013716_BEB98E4B 
X-CRM114-Status: GOOD (  14.84  )
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

On Tue, Jan 8, 2019 at 7:58 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Just a cosmetic tidy-up.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>
> ---
> Changes since v1:
> - This patch was added to the set.
>
>  include/linux/olpc-ec.h | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/olpc-ec.h b/include/linux/olpc-ec.h
> index e28f72416a57..c4602364e909 100644
> --- a/include/linux/olpc-ec.h
> +++ b/include/linux/olpc-ec.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_OLPC_EC_H
>  #define _LINUX_OLPC_EC_H
>
> +#include <linux/bits.h>
> +
>  /* XO-1 EC commands */
>  #define EC_FIRMWARE_REV                        0x08
>  #define EC_WRITE_SCI_MASK              0x1b
> @@ -17,17 +19,16 @@
>  #define EC_EXT_SCI_QUERY               0x85
>
>  /* SCI source values */
> -#define EC_SCI_SRC_EMPTY        0x00
> -#define EC_SCI_SRC_GAME         0x01
> -#define EC_SCI_SRC_BATTERY      0x02
> -#define EC_SCI_SRC_BATSOC       0x04
> -#define EC_SCI_SRC_BATERR       0x08
> -#define EC_SCI_SRC_EBOOK        0x10    /* XO-1 only */
> -#define EC_SCI_SRC_WLAN         0x20    /* XO-1 only */
> -#define EC_SCI_SRC_ACPWR        0x40
> -#define EC_SCI_SRC_BATCRIT      0x80
> -#define EC_SCI_SRC_GPWAKE       0x100   /* XO-1.5 only */
> -#define EC_SCI_SRC_ALL          0x1FF
> +#define EC_SCI_SRC_GAME         BIT(0)
> +#define EC_SCI_SRC_BATTERY      BIT(1)
> +#define EC_SCI_SRC_BATSOC       BIT(2)
> +#define EC_SCI_SRC_BATERR       BIT(3)
> +#define EC_SCI_SRC_EBOOK        BIT(4)    /* XO-1 only */
> +#define EC_SCI_SRC_WLAN         BIT(5)    /* XO-1 only */
> +#define EC_SCI_SRC_ACPWR        BIT(6)
> +#define EC_SCI_SRC_BATCRIT      BIT(7)
> +#define EC_SCI_SRC_GPWAKE       BIT(8)   /* XO-1.5 only */
> +#define EC_SCI_SRC_ALL          GENMASK(8, 0)
>
>  struct platform_device;
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
