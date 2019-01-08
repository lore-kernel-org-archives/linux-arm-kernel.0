Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C842C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:53:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2F720827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UMevpTdV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1/yOEbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2F720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CIU5T3bPU1oK0s93Vta9XdsT83Vt07tJ6awS3Y2Uv5A=; b=UMevpTdV0nGxug
	dMZEqpi3uXnI8DHnMij4ehlx2FrcujQVlVd0WHPb6Yk2avwfvJDuceGiD6Ref0BYWWjvvijlT0ZdI
	Cfs9ZIw1AdKdJHFeKzVAlDTU0PpZXh4Xjw2AuyWhjcc+7UsvjyOaXdos55ND0dZVpt69bgwxekpd+
	MK6H6fAUOHNTRh+TymOmiHKoclcRaBwgIiGWytdyHDWA46ny5jQLfXz9BK9fWc//0pYA45kJqrEo7
	RieOtNYv/xLG5grTX6DQWTqL1jgV5mMevCPRC49G1XOmdlOeF147q3YllUyPvQTte4FBDcwoLDZO5
	IywXnB9qYs8KbBF7hL7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggth3-0002Jg-D9; Tue, 08 Jan 2019 15:53:29 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggth0-0002Ge-A7
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 15:53:27 +0000
Received: by mail-wr1-x444.google.com with SMTP id p4so4553793wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 07:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CsbDDtr/cOKRhJciYic2hAxU3PSHC8ySvN9ouYTQGWA=;
 b=Y1/yOEbcvnqeeN/cSWPRKGNuxAp8xoVsB9AHgVkQ/8H30AVymhjPDji4KiJtH5b6f6
 MbABI4MTR9TqSMIXKBm/2ulSePis2F1JusTRVbPR9PbBc4poHoWux1h2XxyZzFjHWhtw
 HrYWb3gi+19azpbwwyMYKcBg60WL2S2gKIRtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CsbDDtr/cOKRhJciYic2hAxU3PSHC8ySvN9ouYTQGWA=;
 b=GBHHz2FqFDXkXdPjgyy2aN0YQeLy30bqrC4gPwTeWIwdn9DJFU3nwqY8mXopGVUGCq
 VNVx/PjxiNkA6hFNgxAS+Brtvvmb9kwt6H4fwIbi6F15sMSDu4906SFGfR3Mk1hMzMZx
 N7in6sIx7+EST4v1IIWWHtki5Bn4WvGIYYVTF9jQjAcc+NVptGjFbbne11jM6AbYRX7A
 hdY/ybyDr1j8O6apN5JQqjcjJigkxIVNGyUhE3y3aR44FzK8bvDXLuqmQzf4yRx2wkIS
 DYEZYjUE57vPVqOEIMvlv70s6ZoyJ3jJ8EctrlA2vljkxUHH9xtvKTw39Oh67DWhvsXv
 VWbQ==
X-Gm-Message-State: AJcUukeumxH9OBmJrI0wtQTL8eaxAAYHJGM2PwZZteILAt41jUQv75PY
 BUWvIFvIajQOwyQn57lRylFtEQ==
X-Google-Smtp-Source: ALg8bN6fFNcjFDuqXcKGOhaQ9adFuzDmz9i+dxtu77+XzgrZv5T5IlJ3kAKzGcua7hVnIvyFB1BL2A==
X-Received: by 2002:a5d:4250:: with SMTP id s16mr1895039wrr.253.1546962803980; 
 Tue, 08 Jan 2019 07:53:23 -0800 (PST)
Received: from bivouac.eciton.net (bivouac.eciton.net.
 [2a00:1098:0:86:1000:23:0:2])
 by smtp.gmail.com with ESMTPSA id z17sm47586239wrv.2.2019.01.08.07.53.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 08 Jan 2019 07:53:23 -0800 (PST)
Date: Tue, 8 Jan 2019 15:53:21 +0000
From: Leif Lindholm <leif.lindholm@linaro.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] efi: use 32-bit alignment for efi_guid_t
Message-ID: <20190108155321.7us32cbh6jgvwaw5@bivouac.eciton.net>
References: <20190108152829.11579-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108152829.11579-1-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_075326_355797_7FE9106B 
X-CRM114-Status: GOOD (  19.37  )
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
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-efi@vger.kernel.org,
 lersek@redhat.com, mingo@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 04:28:29PM +0100, Ard Biesheuvel wrote:
> The UEFI spec and EDK2 reference implementation both define EFI_GUID as
> struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
> is 32 bits not 8 bits like our guid_t. In some cases (i.e., on 32-bit ARM),
> this means that firmware services invoked by the kernel may assume that
> efi_guid_t* arguments are 32-bit aligned, and use memory accessors that
> do not tolerate misalignment. So let's set the minimum alignment to 32 bits.
> 
> Note that the UEFI spec as well as some comments in the EDK2 code base
> suggest that EFI_GUID should be 64-bit aligned, but this appears to be
> a mistake, given that no code seems to exist that actually enforces that
> or relies on it.

Whereas code does exist that relies on it being 32-bit aligned...

> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>,
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Leif Lindholm <leif.lindholm@linaro.org>

> ---
>  include/linux/efi.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 45ff763fba76..be08518c2553 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -48,7 +48,20 @@ typedef u16 efi_char16_t;		/* UNICODE character */
>  typedef u64 efi_physical_addr_t;
>  typedef void *efi_handle_t;
>  
> -typedef guid_t efi_guid_t;
> +/*
> + * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
> + * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
> + * is 32 bits not 8 bits like our guid_t. In some cases (i.e., on 32-bit ARM),
> + * this means that firmware services invoked by the kernel may assume that
> + * efi_guid_t* arguments are 32-bit aligned, and use memory accessors that
> + * do not tolerate misalignment. So let's set the minimum alignment to 32 bits.
> + *
> + * Note that the UEFI spec as well as some comments in the EDK2 code base
> + * suggest that EFI_GUID should be 64-bit aligned, but this appears to be
> + * a mistake, given that no code seems to exist that actually enforces that
> + * or relies on it.
> + */
> +typedef guid_t efi_guid_t __aligned(__alignof__(u32));
>  
>  #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
>  	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
