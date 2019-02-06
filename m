Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2D6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:58:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B3720823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CSNw37BP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zF47n9Cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B3720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a1d6x6w4u93v4EruM8bH/Ks7LuCzknW6DKWzgNbIr6Q=; b=CSNw37BPiLoEME
	So2L39fo3pgQTpm5bR3eALGA+YQkjYc5roaRTQCUi9EEny7bs5otXT7SwcFAo9UiPtKM/ocA4yTve
	Oet3uuCR6GB5pF9oGuN/ory93ziw1dOsbtZDHHzhEO7bNcO4zfADbWLeZTo6s718lhyLCUyvba6j3
	99Ujvi0oyIbtieEweuPYZ1T4Ay17goxaeSDKnGLFhZEi6xVZAdaFNMpipuzPi+Pja9QdO9wvh8kmr
	UMAPZ/ZLfoxR8e2/piQ6RLmkKupIE+tMTw6b6iBL89/uegzuQVnTDNmqa3RkiavigFRTgzGhCbl1n
	GTbuUin+/08DKCIF9mig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grUH5-0004sN-1o; Wed, 06 Feb 2019 20:58:27 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grUH0-0004o5-PD
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 20:58:24 +0000
Received: by mail-ua1-x944.google.com with SMTP id n7so2746143uao.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 12:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W4ctc2JQ3t3vtf/g9zMb1HzjTFoyLHUHO4M9eqCT3fE=;
 b=zF47n9CsELeXEx7d92ZdJ+DMNPUE0mUD4HfP7Z0qjPcQrBOI+vKJE+GmppaoLEb3qC
 KZIbXwQaR1JXbnVyLCLogOr+qx/oy4ImLew5r8tzryI2S8F18FTc0TJ00Ig4ofj6Jnpg
 Cf+d8nn9Kx5tOC+ZMNrF6q5aHvr3TtaQ+TZamwZM+WWz8tQ9Fgv5P20oUnOOitnanDye
 r6ZVVKBwkVa4Qk4t4rsPBsWo1kHpQDw+6Xy20vYuaKlQk1eU51rpb31k2XW16Q6RnuJU
 stygbpuf0wzaIA6n4c5lNjqm4at1R7a9Qoox48iWOGHXs7eX7LlUFJOuorHRNSozcRGt
 dQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W4ctc2JQ3t3vtf/g9zMb1HzjTFoyLHUHO4M9eqCT3fE=;
 b=RsQ2YPVnAoFZ2nhO8FnsHYnCbvOyVc+L567zHJcWgxvkPc0wI5ZSwJCAeJI2TTDG/N
 ReFa7MKzgBdaIkgqwiWGK5wQChwNezEhZ4SojG2qNdxPhjXsCmwibKebxOGkt41zkd7I
 R365aPHOlgCUtYgmQN4rwTENU59aX4UMnbQlIWWC1uCU5F8qSvtwkCN1KebhEF7gMKJB
 l2WsiBaj5qRPfKzy+IWyoum1E9k8dGpzkKqV2zHvaCNDNxym3IQ05pBfFeCOtUmuYGZI
 DmjmL5JiQH+IUey2XBYdVQ4YTp8dxH+e4wI5MSGC0DdslYgPQDXsduEx8Lt8t/Fs1Pb3
 +yJA==
X-Gm-Message-State: AHQUAuZX1wFsKIjDY4ldoW3Z1XygDSwfAyOjRaQ0Z/YjE8/6XAoQWArM
 3iDifjNShHKvD1IqUUFK8kdCL7L6ClQpXt2pstf9syJNB2k=
X-Google-Smtp-Source: AHgI3IZyFtdmeX+mhRloXEAd+DCkr+x8TK9qv/hXANRV35OX3ZjeWgXlSyW6eXCehiCZSzf7EWakPIAtCgRVMwRzW/M=
X-Received: by 2002:ab0:7611:: with SMTP id o17mr4607883uap.22.1549486701252; 
 Wed, 06 Feb 2019 12:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20190130234051.2294-1-mike.leach@linaro.org>
In-Reply-To: <20190130234051.2294-1-mike.leach@linaro.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 6 Feb 2019 13:58:10 -0700
Message-ID: <CANLsYkxrCpbzjjJ6=pDezsdC0eXyJ01NKu5jBU13Y8G0cc8etg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Update AMBA driver for enhanced component ID spec.
To: Mike Leach <mike.leach@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_125822_928469_0E11AB91 
X-CRM114-Status: GOOD (  17.07  )
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
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
 Coresight ML <coresight@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, arm@kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 at 16:40, Mike Leach <mike.leach@linaro.org> wrote:
>
> The latest ARM CoreSight specification updates the component identification
> requirements for all components attached to an AMBA bus. (ARM IHI 0029E)
>
> This specification defines bits 15:12 in the ComponentID (CID) value as the
> device class. Identification requirements now depend on this class.
> Class 0xF: Traditional components identified by Peripheral ID (PID) only.
> Class 0x9: CoreSight components may be identified by a Universal Component
> Identifier (UCI) consisting of the PID plus CoreSight DevType and DevArch
> values.
>
> Current and future ARM CoreSight IP will now use the same PID for
> components on the same function - e.g. the ETM, CTI, PMU and Debug elements
> associated with a core. The first core to use this UCI method is the A35,
> which currently has binding entries in the ETMv4 driver.
>
> This patchset prepares for the addition of the upcoming CTI driver, which
> will need to correctly bind with A35, and reported new devices that share
> PID for multiple components, while overcoming the limitation of binding by
> PID alone, which cannot now work.
>
> Patch 0001: Adds new UCI data structure and uses it with existing drivers
> that use private data field in amba_id. This fixes issue from prior set.
> Patch 0002: Implements the UCI matching code in the AMBA core code.
> Patch 0003: Update ETMv4 driver to use UCI as appropriate.
>
> Thanks
> Mike
>
> Tested on DB410, Juno; kernel 5.0-rc4
>
> Changes since v3:
> Fix UCI structure to allow CoreSight drivers to set private data. This
> fixes bug where none-UCI private data would cause a driver binding
> mismatch. (e.g. STM).
>
> Add CS_AMBA macros to simplify building AMBA ID tables, with and without
> UCI settings.
>
> Changes since v2:
> Simplification of amba_cs_uci_id_match().
> Fix CID class bitfield comments.
> Dropped RFC tag on patchset.
>
> Mike Leach (3):
>   drivers: amba: Updates to component identification for driver
>     matching.
>   drivers: amba: Update component matching to use the CoreSight UCI
>     values.
>   coresight: etmv4: Update ID register table to add UCI support
>
>  drivers/amba/bus.c                            | 45 +++++++++++++++----
>  drivers/hwtracing/coresight/coresight-etm3x.c | 44 ++++++------------
>  drivers/hwtracing/coresight/coresight-etm4x.c | 21 +++++----
>  drivers/hwtracing/coresight/coresight-priv.h  | 40 +++++++++++++++++
>  drivers/hwtracing/coresight/coresight-stm.c   | 14 ++----
>  drivers/hwtracing/coresight/coresight-tmc.c   | 30 ++++---------
>  include/linux/amba/bus.h                      | 39 ++++++++++++++++
>  7 files changed, 153 insertions(+), 80 deletions(-)

Reviewed-and-tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>

I am looking for guidance on how to proceed here.  Russell, can pickup
the AMBA bits in my coresight tree or perharps you'd prefer to see the
whole set added to the patch tracker?  Please let me know.

Thanks,
Mathieu


>
> --
> 2.19.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
