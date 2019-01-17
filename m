Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F27C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:11:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9E320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="heBk3WI7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T0Z4JLfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9E320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ocqb4ACPxnQtueGp42t4hqDC0tqdHVBmVhimx0w6SdY=; b=heBk3WI7THez85
	ZetP0b0fbfk8SoPd89Ckj5Psbqrx0SbpWX9HO2tvs69iXClsuSXEgjQv2tqf4+HcpnaiRClFIlMnE
	mbvGBacdCBMZT9mvDCnZUevWS63bpuSWXhESNB8TksfB4ZeYB6yyVqc0G+YQE+lWc1wp9s/H3/X/Z
	HnqToqYAuc23xNmjShxzi0qDmbEdBKEQXbZM/vJ0RZ5lgp2vycWqH2tx94COAozK1K3hcJsfc2N3p
	ifI+phfopJyQ+mVPie7WMFBaMDWwP3ey/AiR687jhuxGhdhb2r+l6OGDKQyuvF0/YK3iob24K0iRO
	+9juVikhdHGnMF6jSK0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkBCe-0002Fa-IX; Thu, 17 Jan 2019 17:11:40 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkBCc-0002Dz-3C
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 17:11:39 +0000
Received: by mail-vs1-xe43.google.com with SMTP id e7so6695941vsc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 09:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9NH/nNdAELJO+XX2r9h3AuIOg98tGgx6St0RefpZQA4=;
 b=T0Z4JLfnMp6XuQB31A8RKP7WphX7sY6WgvX+4tfIoDjyoCuLGyUfV8XhV8Zuh5jCCu
 Pf3umkvMa9TNjQ+I7YigjnavGhUcMYboLngOHaa70kHbPCdMQIzkEeiZg2B3MZ2+wM9u
 TIM/Pex5NBW1vlQ2ApRkW/34TwIJgqr5MMlxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9NH/nNdAELJO+XX2r9h3AuIOg98tGgx6St0RefpZQA4=;
 b=kd1cUjCXN5ORj0B5tfwrKWR0C1R6iGonUeIs8P+KRYu56Joeu3vz8L/mJnBwVOJxim
 tdU4ptfsrOL9zUjXf+ufIT/plprNVbkbo8nkQ8oIsdFbRt1PL0oLO6uwm3Ib10zXWbnH
 leSAksyKiBKiaSXDRFS2m6EikZtE3dG0HjvmzqS0XUPHI5mgTBisSw+XJrGgzIYrFogh
 U/I/Sz7IpsRhhJ94W73UDz933zkTY65RhGioDksnXodXa6gpv7TRnG+Fy5egJbXvZOhH
 sZRVz/cy5d0yANQ1VPFkOMDxS62Gg5mOLUsxMzmlsBlndMuwrE5Spx/MJBC7RVbgPvkh
 SsXA==
X-Gm-Message-State: AJcUukd2ijsFrOAneXqTBwIsNIM/CwYMCc2takod3yxmtl/i3ahWW/GX
 yDLyQ54PH21l/sLlGj4dwqmsWnfM17E=
X-Google-Smtp-Source: ALg8bN4hiouwHQK8W4z9NBQfm7aqSPq6bEEgfYYzNGfNTL3lq4sYkmUlLwXzPVELnUP8GFOGBaKi9Q==
X-Received: by 2002:a67:3d92:: with SMTP id p18mr6469071vsi.51.1547745095717; 
 Thu, 17 Jan 2019 09:11:35 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com.
 [209.85.221.172])
 by smtp.gmail.com with ESMTPSA id n206sm57649935vkn.36.2019.01.17.09.11.34
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 09:11:34 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id s184so2434439vkd.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 09:11:34 -0800 (PST)
X-Received: by 2002:a1f:298e:: with SMTP id p136mr6005109vkp.40.1547745093881; 
 Thu, 17 Jan 2019 09:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 17 Jan 2019 09:11:21 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+E1Eiv8T9OLDeM2-_qCUwh79zRhJ92Yixg496ZXo5ccg@mail.gmail.com>
Message-ID: <CAGXu5j+E1Eiv8T9OLDeM2-_qCUwh79zRhJ92Yixg496ZXo5ccg@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Fix console ramoops to show the previous boot
 logs
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_091138_160526_2B1BA4F8 
X-CRM114-Status: GOOD (  20.78  )
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
Cc: Tony Luck <tony.luck@intel.com>, Rajendra Nayak <rnayak@codeaurora.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 Anton Vorontsov <anton@enomsg.org>, Doug Anderson <dianders@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Colin Cross <ccross@android.com>, Joel Fernandes <joel@joelfernandes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 10:27 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> commit b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz()
> arguments") changed update assignment in getting next persistent
> ram zone by adding a check for record type. But the check always
> returns true since the record type is assigned 0. And this breaks
> console ramoops by showing current console log instead of previous
> log on warm reset and hard reset (actually hard reset should not
> be showing any logs).
>
> Fix this by having persistent ram zone type check instead of record
> type check. Tested this on SDM845 MTP and dragonboard 410c.
>
> Reproducing this issue is simple as below:
>
> 1. Trigger hard reset and mount pstore. Will see console-ramoops
>    record in the mounted location which is the current log.
>
> 2. Trigger warm reset and mount pstore. Will see the current
>    console-ramoops record instead of previous record.
>
> Fixes: b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz() arguments")
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Whoops! Thanks for catching this! I've adjusted the patch slightly (no
need for a local variable), and will send this to Linus.

-Kees

>
> ---
>
> I guess commit msg can be improved.
> ---
>  fs/pstore/ram.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 96f7d32cd184..441a44215456 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -128,7 +128,7 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
>                      struct pstore_record *record)
>  {
>         struct persistent_ram_zone *prz;
> -       bool update = (record->type == PSTORE_TYPE_DMESG);
> +       bool update;
>
>         /* Give up if we never existed or have hit the end. */
>         if (!przs)
> @@ -138,6 +138,8 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
>         if (!prz)
>                 return NULL;
>
> +       update = (prz->type == PSTORE_TYPE_DMESG);
> +
>         /* Update old/shadowed buffer. */
>         if (update)
>                 persistent_ram_save_old(prz);
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>


-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
