Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575E9C282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:21:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2783E21874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JgbC0nw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783E21874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WsRojBtqa/QZKMK6ve/pZOt7UcvWZdIKX0n+Gy4CGBY=; b=JgbC0nw/Hy2gvz
	23zn4WVtkFdTsw4ozT788sR6b4CVg4xpjKvb71Ma5jQnsmKeLjPbfJP9+UPsonabZHFqPome9vj3n
	xe5g1/u6mK30/bYKnWyFMh1qUc7ERBE4rsHjW/0+iojaYOpGtrrIHjjjrO68j6J6V9j8kK5P0vYeZ
	0JQpxr2Z+zp9/68PlnTV9qwK0bLnK1S5ty6uyeirRnKaxBYdeEsMPWFW7+pvBiaarsybvcOzNMlXG
	uLmu3zJetNFiNKIDw/3RpXEmN+MRaEtxQspBdiyqY0Q6wVA9jmT2UI8GIjhaM3JPNsbbsjjf1vi03
	T991sjWWon9tscjYBepw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gol89-000370-Ee; Wed, 30 Jan 2019 08:21:57 +0000
Received: from mail-vs1-f68.google.com ([209.85.217.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gol86-00036f-1L
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:21:55 +0000
Received: by mail-vs1-f68.google.com with SMTP id u11so13722591vsp.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 00:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UXRoeRbZly/zcIscio6rfCE5e28iEH5JSota4EpbSNQ=;
 b=nwYZ0BceLwjf8vGjnrt94Q6qIO7aN9nKdiPCQQc3MOlbpTykXNutVX8p+cC1pVzd6K
 lzfAAxYJUad7o+7Rj1hSfdiTVssaWWwzX4KTnjjO+CqtOkiOUb4Nh3UN6m9KdxE7CaT8
 KE5Dte4u7WY/j9d21qaWtMW6I1mNdmAXkMrP93LiOt3uKUdpducrB43ePrHE5tLXxgFW
 +GGcQZ4DRA/w/cuqyPbODIBzY2km3h2PJw9sFmUPOvg3JNT0rf2Nr3FnQYPZAymgmpsK
 mQBk59byj462SKfD5MP0ou1GEnQa8NXJm46j0+G3svcbLxrX6OLIU+npjzYx+37b4zIb
 bpaw==
X-Gm-Message-State: AJcUukcvenDOIoDydpOAhbY1ZUx6uY13TOepE0qnihZ/kxSjCZhxtgJ9
 Ns2RlMuM0zgeArwOoaljE0id+UnKD0BaSHMbZoM=
X-Google-Smtp-Source: ALg8bN4Tcw9HDIoapB7MuAWG2VV78bc4r7NqYlnepWvt9ph8hOZQ5WJoqrEpETHahfxCo6RFRg4xwGkLyr/USHRgwaw=
X-Received: by 2002:a67:f43:: with SMTP id 64mr12335445vsp.166.1548836512519; 
 Wed, 30 Jan 2019 00:21:52 -0800 (PST)
MIME-Version: 1.0
References: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Jan 2019 09:21:41 +0100
Message-ID: <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com>
Subject: Re: [PATCH] PM-runtime: fix deadlock with ktime
To: Vincent Guittot <vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_002154_075028_66F92065 
X-CRM114-Status: GOOD (  15.46  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:TI ETHERNET SWITCH DRIVER \(CPSW\)" <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vincent,

On Wed, Jan 30, 2019 at 9:16 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> A deadlock has been seen when swicthing clocksources which use PM runtime.
> The call path is:
> change_clocksource
>     ...
>     write_seqcount_begin
>     ...
>     timekeeping_update
>         ...
>         sh_cmt_clocksource_enable
>             ...
>             rpm_resume
>                 pm_runtime_mark_last_busy
>                     ktime_get
>                         do
>                             read_seqcount_begin
>                         while read_seqcount_retry
>     ....
>     write_seqcount_end
>
> Although we should be safe because we haven't yet changed the clocksource
> at that time, we can't because of seqcount protection.
>
> Use ktime_get_mono_fast_ns instead which is lock safe for such case
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks for your patch!

/**
 * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
 *
 * This timestamp is not guaranteed to be monotonic across an update.
 * The timestamp is calculated by:
 *
 *      now = base_mono + clock_delta * slope
 *
 * So if the update lowers the slope, readers who are forced to the
 * not yet updated second array are still using the old steeper slope.
 *
 * tmono
 * ^
 * |    o  n
 * |   o n
 * |  u
 * | o
 * |o
 * |12345678---> reader order
 *
 * o = old slope
 * u = update
 * n = new slope
 *
 * So reader 6 will observe time going backwards versus reader 5.
 *
 * While other CPUs are likely to be able observe that, the only way
 * for a CPU local observation is when an NMI hits in the middle of
 * the update. Timestamps taken from that NMI context might be ahead
 * of the following timestamps. Callers need to be aware of that and
 * deal with it.
 */

As this function is not guaranteed to be monotonic, have you checked how
the Runtime PM code behaves if time goes backwards? Does it just make
a suboptimal decision or does it crash?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
