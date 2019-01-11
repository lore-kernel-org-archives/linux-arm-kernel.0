Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA50A20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AvU4E9xa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA50A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pDcdWdPdiKbz1aiZP0BNxsUZD4CbZpOxjf6VdfrEDbQ=; b=AvU4E9xacIuN4L
	ZPwJcdRLXbahZXGk7E4DwTxcYksUhNbthegoXQrpfEn+BtNGHVzD/Qi5Dsx5UB/oxdTJG229iCDSH
	Dfkp5Va5QvCulUWB5q/y8UMwx/9qzbnowVSv+cnB1T4syMXzOP0f4Fg2ZVKPl9L0dNVW4F983pyj8
	hvR+Efwsk6VmQxAh6kGSXk8x2IYNZcSBZS1uIc5x3ud1B8Md/rrGzobPaBiCB9u9dEcO343hBHzSm
	fA+1ICFU0RfFRYpVeuvVNDnWQTVRG3U8hjAZXFhJXpHlhuQE7RKzn2ChUlZreE4L5eHoLjmvYDYbT
	w3jJejb3HoQeyA6RjHRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtW5-0000ua-3d; Fri, 11 Jan 2019 09:54:17 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtVs-0000hu-Sp
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:54:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 650C8EBD;
 Fri, 11 Jan 2019 01:54:02 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B4AD3F694;
 Fri, 11 Jan 2019 01:54:00 -0800 (PST)
Subject: Re: [PATCH 0/2] System-wide mute of hotplug lockdep during init
From: Valentin Schneider <valentin.schneider@arm.com>
To: linux-kernel@vger.kernel.org
References: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
Message-ID: <0f2b6cc8-ad2f-bd0b-fe51-c333a8033452@arm.com>
Date: Fri, 11 Jan 2019 09:53:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_015405_654729_798ECF38 
X-CRM114-Status: GOOD (  14.37  )
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
Cc: mark.rutland@arm.com, cai@gmx.us, marc.zyngier@arm.com,
 daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, peterz@infradead.org,
 longman@redhat.com, tglx@linutronix.de, mingo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 19/12/2018 18:23, Valentin Schneider wrote:
> In [1] Peter had a suggestion to broadly mute hotplug lockdep warnings during
> init instead of going after every single warning and wrapping them with
> cpus_read_{lock, unlock}(). This is implemented in [PATCH 1/2].
> 
> [PATCH 2/2] is a logical follow-up as [PATCH 1/2] is the generalized version
> of the reverted patch.
> 
> [1]: https://lore.kernel.org/lkml/1543877121-4098-1-git-send-email-cai@gmx.us/#t
> 

Gentle ping - I suppose this flew under the holidays radar.

> Valentin Schneider (2):
>   cpu/hotplug: Mute hotplug lockdep during init
>   Revert "sched/core: Take the hotplug lock in sched_init_smp()"
> 
>  kernel/cpu.c        | 9 +++++++++
>  kernel/sched/core.c | 5 +----
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> --
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
