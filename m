Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C10C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:27:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5C0208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PtO3EdGg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T71C8CJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5C0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/ajejpp8K4bkTd+rzF0cnLwcEqzzCiw096a3uxzATag=; b=PtO3EdGg5svJTh
	A7PyBIyXQKba9dpRwbUIAQgNRh0xS196qzSFG7PIHJJv8W3LX4x5L9qnLdM4C11nRqiOIJDl43iZt
	BJ/f2P1h7GTr5R7uZ2JFPx7NILUf0ZbRtdocdFysU/NTPnTZCSSW7DTQnFLlRrExiZtzIwPM5zhG1
	4LSXJ9wGZbyKEifPu+mDgc0eXgJkHrfKQzpHoirMBRaQKzDjYXxzQmtcDzrztyAgYBHYW9m6HTSKj
	VTbic84ZX2zdt7c22ARWBlxjeqTmmyvBRNlwx43lBpjR8AOzDevbAyiyGggLP2fiZlz2npFlrh9WM
	mtPedsV2SP5cbC0i6w/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfPVm-0005or-Qx; Fri, 04 Jan 2019 13:27:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfPVa-0005jO-Ul
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 13:27:40 +0000
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DFA9921874
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  4 Jan 2019 13:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546608450;
 bh=PDUOT9GqHNLgBUUCCinSABv67vhBVK/eeCRUaV6y1bg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=T71C8CJxrdIlcnz1JTmX1ui6Acw+Vfqt5K8EhCxHe1/EeH6P8ruqo7LKF6g35yFg4
 k47mpzHX8ZddoL12vDQ7CLVbEGYB6CTlpG6wZpnHK844aUwSigOCm0ZQS0rqHb1TAc
 2AZXH95idY1X0yi4zsnWqP02EN1yBiTYxamCLK34=
Received: by mail-lf1-f47.google.com with SMTP id n18so25415230lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 05:27:29 -0800 (PST)
X-Gm-Message-State: AJcUukfS32Z516n+qGA5x6wsuLu522v/RDukTAbrCLP6XIp5u7ty0T1M
 1PgFOSBJSnoifDUtcLd5zumm8t5IrSJ3zn7iv7A=
X-Google-Smtp-Source: ALg8bN5HQLbkMfD/IuQ1ZhmsQdSY5/tEDnBNfnxC1PM6G42HUKAJJOSsGvY+9+kSSEbpBrTa2mvoBdPV42q/KXU0TUE=
X-Received: by 2002:ac2:554b:: with SMTP id l11mr1112300lfk.92.1546608447997; 
 Fri, 04 Jan 2019 05:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20190103201408.GA27754@embeddedor>
In-Reply-To: <20190103201408.GA27754@embeddedor>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 4 Jan 2019 14:27:17 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcihzhU+K72p+B83kwXQECYgekSSjy3wZ9eaFi5qTnY_w@mail.gmail.com>
Message-ID: <CAJKOXPcihzhU+K72p+B83kwXQECYgekSSjy3wZ9eaFi5qTnY_w@mail.gmail.com>
Subject: Re: [PATCH] ARM: mach-s3c24xx: Fix boolean expressions in
 osiris_dvs_notify
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_052731_203174_362FFC59 
X-CRM114-Status: GOOD (  18.48  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Ben Dooks <ben@simtec.co.uk>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 3 Jan 2019 at 21:46, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>
> Fix boolean expressions by using logical AND operator '&&'
> instead of bitwise operator '&'.
>
> This issue was detected with the help of Coccinelle.
>
> Fixes: 4fa084af28ca ("ARM: OSIRIS: DVS (Dynamic Voltage Scaling) supoort.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
> index 058ce73137e8..ccbd7b7965ca 100644
> --- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
> +++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
> @@ -65,16 +65,16 @@ static int osiris_dvs_notify(struct notifier_block *nb,
>
>         switch (val) {
>         case CPUFREQ_PRECHANGE:
> -               if (old_dvs & !new_dvs ||
> -                   cur_dvs & !new_dvs) {
> +               if (old_dvs && !new_dvs ||
> +                   cur_dvs && !new_dvs) {

Technically the old code will work fine because all variables are
bools (so 0 or 1). Therefore I am not sure whether this should be
ported to stable.

Anyway the patch is itself okay and I will take it after merge window. Thanks!

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
