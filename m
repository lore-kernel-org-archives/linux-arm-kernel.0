Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072CCC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:54:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8CB2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Assofgax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8CB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JnZ4LwzzFglR+8VoYRCMa0gmjBFoAFQgW0I3rhcWM64=; b=AssofgaxEqp13E
	vybpZQXIkxcW3BbnwlWT4N3xREFnFItkwBGBS1exEDT/cSTjUmVybC6HB1rZ9UbQ0Bv/ngouOOnKM
	dax20dw4bJhSFibxRJOTK1TPWmoaLMEUN+ioiqp2gcQfzGoDk4lUyDeFZhAalMe6Kv00r3V4HVNX4
	sxt/1XYQks9Nrh9wtMfxvgL5OJzO1vbHssZOpxF1dId3TCR4y0z7PgT1IHVJawHDfMuDI4KVGy40H
	sIxp6fTgQRdKLuFCbamg7PbLhyf+DClneKfH+iD2PFWXhw8XJV3A/6YFiROvB1o52WmRrijytP9Bu
	xA1Z9u1LRPA4dIgClxog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJO5-0001sm-3C; Fri, 07 Dec 2018 16:54:01 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJNu-0001iK-3T
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 16:53:51 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 8753980C0;
 Fri,  7 Dec 2018 16:53:42 +0000 (UTC)
Date: Fri, 7 Dec 2018 08:53:36 -0800
From: Tony Lindgren <tony@atomide.com>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Fix audio permanently muted
Message-ID: <20181207165336.GP6707@atomide.com>
References: <20181123111945.6016-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181123111945.6016-1-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_085350_180123_0B271C37 
X-CRM114-Status: GOOD (  11.88  )
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
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [181123 03:18]:
> Since commit 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused
> GPIOs"), on-board audio has appeared muted.  Believed to be unused GPIO
> pin "hookflash1", apparently set high regardless of the corresponding
> bit of "latch2" port attempted to be set low during .init_machine(),
> has been identified as the reason.
> 
> According to Amstrad E3 wiki, the purpose of the pin hasn't been
> clearly identified.  Original Amstrad software used to produce a high
> pulse on it when the phone was taken off hook or recall was pressed.
> With the current finding, we can assume the pin provides a kind of
> audio mute function.
> 
> Proper resolution of the issue should be done in two steps:
> - resolution of an issue with the pin state not reflecting the value
>   the corresponding bit of the port was attempted to be initialized
>   with,
> - extension of on-board audio driver with a new control.
> 
> For now, rename the pin to "audio_mute" to reflect its function and,
> as a quick fix, hogg it as output low so on-board audio can produce
> audible sound again.
> 
> Fixes: 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused GPIOs")
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Adding into omap-for-v4.20/fixes thanks.

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
