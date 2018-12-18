Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F96C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:20:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4374421848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="th/PjC2m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyY+rJPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4374421848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FLhnoB0b/Cv5Q+kMQJyfV3F1opFtoZlazx7yfdB77Ig=; b=th/PjC2mJqUPDFv/FxpgiKCul
	2oC74iix5SCQ3G9KzTo88O25CE9FrMhlj+aeoN/dgHMpzuGXAZuFbPt+gZEQShynl6J9k1rFZQ/RA
	fjeBt+40DLTMyqBvVwa+WMyWmhRlQfVJJwWCk0ObWXerbvUmyZd22L5u6U1JPAqgWaKcCu67WY0Vh
	Z3Q8Ry8ClDhPdZUABU67YCRL9niUkbs2uQSYiPUX1o7GSwMbICgYx/mUSSoLOgH+BciFoFaTJtMPT
	Dym/luq0nKK9SiJIKELjCgQPtdB22i7Plp9egyX8/zudrqn18JGLS7qY+JiXw7NpyGVhRe0A/yBVr
	UxQKK/uEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ37s-0006Hd-AH; Tue, 18 Dec 2018 00:20:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ37o-0006GL-N1
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 00:20:42 +0000
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E12820874;
 Tue, 18 Dec 2018 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545092429;
 bh=JAIgOIQfFXT9a1LOTaslhoxR4QxEfjnFoh9E9BsFKjQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fyY+rJPNl9WQ5S9QTFuxS8KGRppfxeAJhjpUXUoEhQnCfkajXtfxX06e42Zge6BLh
 MIrDd24i/4eshp79OXy9Oqn/4sU/cdswE8M90yaseRVpnzItDqF1jA7nUnSFsZr91K
 S+Dp4fYUoum/K7CLKfC8bcv54hF/MKuf+Jo2lmJM=
Date: Mon, 17 Dec 2018 19:20:28 -0500
From: Sasha Levin <sashal@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/7] v4.19-stable randconfig fixes
Message-ID: <20181218002028.GX2746@sasha-vm>
References: <20181214221023.3878670-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181214221023.3878670-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_162040_768470_3A58EF56 
X-CRM114-Status: GOOD (  11.69  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-aspeed@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, David Brown <david.brown@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-i2c@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Daniel Drake <dsd@laptop.org>, linux-scsi@vger.kernel.org,
 Jens Frederich <jfrederich@gmail.com>, openbmc@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>, Andy Gross <andy.gross@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Lubomir Rintel <lkundrak@v3.sk>, dou_liyang@163.com,
 Rob Herring <robh+dt@kernel.org>, bp@alien8.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 freedreno@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 11:10:05PM +0100, Arnd Bergmann wrote:
>Hi Greg,
>
>I did some randconfig testing on linux-4.19 arm/arm64/x86. So far I needed
>27 patches, most of which are also still needed in mainline Linux. I
>had submitted some before, and others were not submitted previously
>for some reason. I'll try to get those fixed in mainline and then
>make sure we get them into 4.19 as well.
>
>This series for now contains four patches that did make it into mainline:
>
>2e6ae11dd0d1 ("slimbus: ngd: mark PM functions as __maybe_unused")
>33f49571d750 ("staging: olpc_dcon: add a missing dependency")
>0eeec01488da ("scsi: raid_attrs: fix unused variable warning")
>11d4afd4ff66 ("sched/pelt: Fix warning and clean up IRQ PELT config")
>
>Feel free to either cherry-pick those from mainline or apply the
>patch from this series, whichever works best for you.
>
>The other three patches are for warnings in code that got removed in
>mainline kernels:
>
>3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
>972910948fb6 ("ARM: dts: qcom: Remove Arrow SD600 eval board")
>effec874792f ("drm/msm/dpu: Remove dpu_dbg")
>
>My feeling was that it's safer to just address the warning by fixing
>the code correctly in each of these cases, but if you disagree,
>applying the mainline change should work equally well, so decide
>for yourself.

Thanks Arnd, I took the series as is.

We really need to discuss how -stable deals with removed code upstream.
For some cases, we should probably follow suit and remove it from
-stable as well (I'm mostly thinking dodgy code with potential security
issues).

--
Thanks,
Sasha

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
