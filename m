Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B35BC07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:16:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D1F20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GrgFolLX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UytB8Qkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D1F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mp0hhNbOzi19wD7dCI4xjQFesIRQibuW3Lu+VoDJMds=; b=GrgFolLX9WjOAi
	skot/uTXkdOtgs44XoJlHZQfHOsZ/sZ1Sh8GCur6BUakpwgw+39Wv4RUGXz9qjIXRU+nsjiKhisAZ
	yEgsdHo653zYRZQ5aTRx4pA4Zxdi6lp/DOvXdHYR/OKLI/5PDCErexFTtY0KJHat0aQjS6a0kf8Cw
	qBOyW1WtaUJr84a1JozUHb0MyVbuYjoXmM5AabThslO62j8yuUkkuW+VC/NFNcY/FofOLCLWWp+Pa
	aEnHxuV3CkTJElseu9IOZw6Cv21qb1V76p70n267UBnX3QZsQOwTEhyefVzAevMKvxvtFF/Qsk0GA
	N7dMmkpebLTcfyOGAppQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkYgZ-0001nh-CX; Fri, 18 Jan 2019 18:16:07 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkYgV-0001nK-HX
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 18:16:05 +0000
Received: by mail-lj1-x243.google.com with SMTP id n18-v6so12403076lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 10:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JbuMDh62Bl9UBEecI/smNrqHrt5PFEqkU025XFrUPsY=;
 b=UytB8Qkhfyc5ejZsvOG4ji99JmSuWKM2iw1N90zLPptzQqOOec1c1WgxFTU3qoTXkC
 VyXsre9HvWgafZKsXkRl5gS3DiFiWISu9siocB5/xHCeZLfUOo2SeKk0VLfJxeEzM7m8
 XJGnRDN7t6QGGF/lRWu4iAeHZ3+vowO8wSwEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JbuMDh62Bl9UBEecI/smNrqHrt5PFEqkU025XFrUPsY=;
 b=eHyJKfIyA2oUre3NGHOtj3hw8qgc5cONHfKIbCmGdyI8rDnk/InLuXjtbzNHgOo1qd
 IrQHYsnFgGf60fo3YA9rSockVnC+QK5E9+daKgDg/v0P1jR5PeFmleNSGMOBEMf0Rtxs
 a8+s1cy1F9LGK8NnVujX+4lps6Err9Q1TZu1DoolD4ITdMBc3FP6jcZii68OAhG0JM2H
 UGCzd4x+jD73bWt5inzyNKK8SgypRL72OdQzpeS8wfsmSSdLaJaCJh4amND7ZXBkcHnu
 ileIAbl+j0KKKrfx18gMIgZd/oRFdqAQBPDkutagPbg++ufEOoAZKxyeVvK5mql12qmP
 XeJQ==
X-Gm-Message-State: AJcUukc/Q82dUxwtwGbR1bDjWHVvo5CAgCyuuXReXY9d+Q1Uhv+EcxSS
 Q1CQrmEVippQjAlC0sYA0jWdLPnNPsk=
X-Google-Smtp-Source: ALg8bN4CN8VGcDnnMaaPJWqtm3GYqMEYwI2EFIpStAxrV5Y5bv9W5s4hrjtZylQtFnRhW+Cn3nm1Aw==
X-Received: by 2002:a2e:b1ca:: with SMTP id
 e10-v6mr13817310lja.16.1547835360102; 
 Fri, 18 Jan 2019 10:16:00 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com.
 [209.85.167.41])
 by smtp.gmail.com with ESMTPSA id 4-v6sm836511ljw.84.2019.01.18.10.15.58
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 10:15:58 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id y11so11175155lfj.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 10:15:58 -0800 (PST)
X-Received: by 2002:a19:1f54:: with SMTP id f81mr12979411lff.153.1547835358395; 
 Fri, 18 Jan 2019 10:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20190115225447.75212-1-swboyd@chromium.org>
In-Reply-To: <20190115225447.75212-1-swboyd@chromium.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 18 Jan 2019 10:15:21 -0800
X-Gmail-Original-Message-ID: <CAE=gft6wHBzN6BK40vcRODGebRmozpOvSk_QHccJms_kLRP8wQ@mail.gmail.com>
Message-ID: <CAE=gft6wHBzN6BK40vcRODGebRmozpOvSk_QHccJms_kLRP8wQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: qcom: rpmh: Avoid accessing freed memory from
 batch API
To: Stephen Boyd <swboyd@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_101603_585999_B2C5E88F 
X-CRM114-Status: GOOD (  18.04  )
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
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 Matthias Kaehlcke <mka@chromium.org>, Andy Gross <andy.gross@linaro.org>,
 "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 2:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Using the batch API from the interconnect driver sometimes leads to a
> KASAN error due to an access to freed memory. This is easier to trigger
> with threadirqs on the kernel commandline.
>
>  BUG: KASAN: use-after-free in rpmh_tx_done+0x114/0x12c
>  Read of size 1 at addr fffffff51414ad84 by task irq/110-apps_rs/57
>
>  CPU: 0 PID: 57 Comm: irq/110-apps_rs Tainted: G        W         4.19.10 #72
>  Call trace:
>   dump_backtrace+0x0/0x2f8
>   show_stack+0x20/0x2c
>   __dump_stack+0x20/0x28
>   dump_stack+0xcc/0x10c
>   print_address_description+0x74/0x240
>   kasan_report+0x250/0x26c
>   __asan_report_load1_noabort+0x20/0x2c
>   rpmh_tx_done+0x114/0x12c
>   tcs_tx_done+0x450/0x768
>   irq_forced_thread_fn+0x58/0x9c
>   irq_thread+0x120/0x1dc
>   kthread+0x248/0x260
>   ret_from_fork+0x10/0x18
>
>  Allocated by task 385:
>   kasan_kmalloc+0xac/0x148
>   __kmalloc+0x170/0x1e4
>   rpmh_write_batch+0x174/0x540
>   qcom_icc_set+0x8dc/0x9ac
>   icc_set+0x288/0x2e8
>   a6xx_gmu_stop+0x320/0x3c0
>   a6xx_pm_suspend+0x108/0x124
>   adreno_suspend+0x50/0x60
>   pm_generic_runtime_suspend+0x60/0x78
>   __rpm_callback+0x214/0x32c
>   rpm_callback+0x54/0x184
>   rpm_suspend+0x3f8/0xa90
>   pm_runtime_work+0xb4/0x178
>   process_one_work+0x544/0xbc0
>   worker_thread+0x514/0x7d0
>   kthread+0x248/0x260
>   ret_from_fork+0x10/0x18
>
>  Freed by task 385:
>   __kasan_slab_free+0x12c/0x1e0
>   kasan_slab_free+0x10/0x1c
>   kfree+0x134/0x588
>   rpmh_write_batch+0x49c/0x540
>   qcom_icc_set+0x8dc/0x9ac
>   icc_set+0x288/0x2e8
>   a6xx_gmu_stop+0x320/0x3c0
>   a6xx_pm_suspend+0x108/0x124
>   adreno_suspend+0x50/0x60
>  cr50_spi spi5.0: SPI transfer timed out
>   pm_generic_runtime_suspend+0x60/0x78
>   __rpm_callback+0x214/0x32c
>   rpm_callback+0x54/0x184
>   rpm_suspend+0x3f8/0xa90
>   pm_runtime_work+0xb4/0x178
>   process_one_work+0x544/0xbc0
>   worker_thread+0x514/0x7d0
>   kthread+0x248/0x260
>   ret_from_fork+0x10/0x18
>
>  The buggy address belongs to the object at fffffff51414ac80
>   which belongs to the cache kmalloc-512 of size 512
>  The buggy address is located 260 bytes inside of
>   512-byte region [fffffff51414ac80, fffffff51414ae80)
>  The buggy address belongs to the page:
>  page:ffffffbfd4505200 count:1 mapcount:0 mapping:fffffff51e00c680 index:0x0 compound_mapcount: 0
>  flags: 0x4000000000008100(slab|head)
>  raw: 4000000000008100 ffffffbfd4529008 ffffffbfd44f9208 fffffff51e00c680
>  raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
>  page dumped because: kasan: bad access detected
>
>  Memory state around the buggy address:
>   fffffff51414ac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   fffffff51414ad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  >fffffff51414ad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                     ^
>   fffffff51414ae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   fffffff51414ae80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
> The batch API sets the same completion for each rpmh message that's sent
> and then loops through all the messages and waits for that single
> completion declared on the stack to be completed before returning from
> the function and freeing the message structures. Unfortunately, some
> messages may still be in process and 'stuck' in the TCS. At some later
> point, the tcs_tx_done() interrupt will run and try to process messages
> that have already been freed at the end of rpmh_write_batch(). This will
> in turn access the 'needs_free' member of the rpmh_request structure and
> cause KASAN to complain. Furthermore, if there's a message that's
> completed in rpmh_tx_done() and freed immediately after the complete()
> call is made we'll be racing with potentially freed memory when
> accessing the 'needs_free' member:
>
>         CPU0                         CPU1
>         ----                         ----
>         rpmh_tx_done()
>          complete(&compl)
>                                      wait_for_completion(&compl)
>                                      kfree(rpm_msg)
>          if (rpm_msg->needs_free)
>          <KASAN warning splat>
>
> Let's fix this by allocating a chunk of completions for each message and
> waiting for all of them to be completed before returning from the batch
> API. Alternatively, we could wait for the last message in the batch, but
> that may be a more complicated change because it looks like
> tcs_tx_done() just iterates through the indices of the queue and
> completes each message instead of tracking the last inserted message and
> completing that first.
>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Fixes: c8790cb6da58 ("drivers: qcom: rpmh: add support for batch RPMH request")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>  * Incorporated needs_free check earlier
>  * Simplified logic to no longer flush everything out on failure
>
>  drivers/soc/qcom/rpmh.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
