Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:00:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9F0218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tBOxDkaw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYL63tw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9F0218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1DpWRYqTTw5hFo7Q3oYtunCYVoc6VXxR9XNDRnMPN4A=; b=tBOxDkawfDSFGV
	wsW636ekTmTEbgJe9xgpCWS2/U1HJS46ZYKdZEUlgObLe897MNQ8gr/lDyU5uMsyMkDTKbm3Cp5Mx
	xBXl2fOGtqrCBg17shS2zt36hPGdYSxxgPZ/0fMukIWYMulJGWDYTpNV3dCtMJuK2wRAb6e4aGCo5
	bw0Ewev2trAG3+aJhenIZUq/8tk/ThXfthlMcSTMU03wydywip+PjgQq2VoF82vndHT1sCqKa4zWW
	22taK5rWwEzqI7FQLg430YVGoHXT881kZVIcoZsSy+JSP0F9Nl5RNSTK1xOyOsGcphNN8u/DuZc1j
	R1DBbI2wlE8x+7QFcZlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggmJ6-0002mG-V0; Tue, 08 Jan 2019 08:00:16 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggmIz-0002dG-81
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 08:00:14 +0000
Received: by mail-io1-xd2e.google.com with SMTP id f4so2477283ion.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 00:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n80u3Bj0sRgCZ2Ib0Abtxqm5mtdRub1PL/fORDN6hnY=;
 b=FYL63tw/QA90Ex09/G/sBbeL30LHGYI+8z03Z1/5O/1TtRMLuUNTgTE8VumYE/cXlL
 nPU9jRF5B/ofMmki6ZZl227e7+f5XdetHdD4Ihri/acNdR3FvyMlhMfQQWc8RDgDJRnJ
 stp71yeQIw7IF5rcPshtpeb1dfBtXUWb1U3lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n80u3Bj0sRgCZ2Ib0Abtxqm5mtdRub1PL/fORDN6hnY=;
 b=gSJwcox+X+JAck0w1Bz+KIrogNDRLfrQhSzKG7tSLp0tOCrbfwv6OnmOSoKGH2gZRj
 o6IPTDi523/kCSEugV5ZMV8CsrSa9UBNFaBC0hxatgwqh+L3QddaC2OZYbQlDgTV7B7L
 I4AMLbzpgFM0j0YvnsJzrwOr+E5Zxfth578Pf+yIea5zwE7EgRateVTmhFrPR6SN2vSW
 9tXP39ynE9AM0lugalKugpfb+DEq7NCqCYsUSU+kI5ByZ6t89KyaHJPqyErJb6GVeS0U
 2OhB50omdlkxi3oWI3/2F6pEhjjLZlcK2Szt3LzB32kYQu3cn4gGZx5nYSV2XBFZ6EQh
 it6A==
X-Gm-Message-State: AJcUukeZvCldmk3T/WlunTwIxTFld+K0MafoaiLGVUVOGzE6MoqkVedf
 qpSHb1Q4aOhpuQgEFzjjGYV3jaE5CdL9X1TbJE+l1Q==
X-Google-Smtp-Source: ALg8bN4EOpyRuSmrkPIRDEuI583rUwwU2H+mu6bJCCzwD1t2lBoGJOUM1na1y6cZpu0cWPcPpYtwAjKUj8Umw+rFSUY=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr375125iof.183.1546934407614; 
 Tue, 08 Jan 2019 00:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com>
In-Reply-To: <20190107233833.GI5544@atomide.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 8 Jan 2019 08:59:56 +0100
Message-ID: <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_000009_289593_F6443FFE 
X-CRM114-Status: GOOD (  12.01  )
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
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
 LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Tony,

On Tue, 8 Jan 2019 at 00:38, Tony Lindgren <tony@atomide.com> wrote:
>
> Hi all,
>
> Looks like commit 8234f6734c5d ("PM-runtime: Switch autosuspend
> over to using hrtimers") caused a regression on at least
> omap5-uevm where 8250 UART rx wake no longer works. I have not
> noticed this happening on others so far.
>
> The devices I've tested all are using 8250 with dedicated
> wakeirqs configured for the rx pin. I can see the interrupt
> increase on omap5-uevm after some one or more keypresses,
> but then nothing. It seems that the uart just falls back
> asleep right away or something.
>
> Any ideas what might be going wrong?

What is the autosuspend value ? Can it be that the autosuspend is set
to a short value but was finally greater than 10-20ms on arm32. And
now the autosuspend happens before and this has changed the sequence ?

Regards,
Vincent
>
> Regards,
>
> Tony
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
