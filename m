Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B360C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:51:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BD620878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U/Egbi+4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3lAodn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BD620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:To:References:
	In-Reply-To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xhO0udmvRe9k2/NAFJORkT1F1k8Gv6V8kEgCu01hxOI=; b=U/Egbi+4ufgWAN
	+9NMhDI1UbvUXJyF4Ep1fAxAxkv6VRsiRnPYZK1YjRffgRrERzgRNAsTwApybxZ2913VcNRDYaxkp
	qyDYcXeufCCyCwzDdBSqp1O4W8ktvxTHRx/sYaFqRE6PTWfVevcv/60RusEJis829ovIUwcyta1bq
	oYMjdEP442onQuNleZ2Pi4aZWcobH2R0tBgGyQz2CiMZ0AqmHz2AzCFr0SxuCvay+JclKnGEqolRZ
	2ew70OqrP4Kfy6V6gDuZPnn+hpn0uGqQBtLPYGEAUftMMOrQiFx/lvOeJjCMT8uJ+enxYNAj2ddnK
	sXpA8WwajvIwpImzEfVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi5du-0002Mq-8e; Fri, 11 Jan 2019 22:51:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi5dq-0002MN-Cx; Fri, 11 Jan 2019 22:51:07 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 613F220878;
 Fri, 11 Jan 2019 22:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547247065;
 bh=Z1lCTTPpnhTR+sgeALta1GhiVWo3H7WodAW1f8zhS2k=;
 h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
 b=a3lAodn1vtqMQjapK779eJy4pbWsfNGb8HMUdR2LMTOgdg8fNyiSTjMyr0pCYqYsj
 xrlqqUc8emJL/elboDmH3LwHOELKXBdgZlRLpSNCm9J/LV9863LyDjvZqFZme0HbkE
 /nALD28Q3qbZ7pcbz5m4C5K0ypAbwKJPQgTGeGrM=
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] Add clock support for Actions Semi S500 SoC
User-Agent: alot/0.8
In-Reply-To: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 mturquette@baylibre.com, robh+dt@kernel.org
Message-ID: <154724706468.169631.2903523518830581075@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 11 Jan 2019 14:51:04 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_145106_450783_76637E78 
X-CRM114-Status: UNSURE (   9.35  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Manivannan Sadhasivam (2018-12-31 10:55:11)
> Hello,
> 
> This patchset adds common clock support for Actions Semi S500 SoC of
> the Owl family SoCs. This series is based on the initial work done
> by Edgar Bernardi Righi. https://patchwork.kernel.org/cover/10587527/
> 
> Since there isn't any update from him for long time, I took the liberty
> to modify his patches, address review comments and send to list for review.
> 
> This series has been tested on Allo Sparky SBC.
> 
> Thanks,
> Mani
> 
> Edgar Bernardi Righi (1):
>   dt-bindings: clock: Add DT bindings for Actions Semi S500 CMU
> 
> Manivannan Sadhasivam (5):
>   clk: actions: Add configurable PLL delay
>   ARM: dts: Add CMU support for Actions Semi Owl S500 SoC
>   ARM: dts: Remove fake UART clock for S500 based SBCs
>   clk: actions: Add clock driver for S500 SoC
>   MAINTAINERS: Add linux-actions mailing list for Actions Semi

What's the merge strategy for these patches? Some are for clk, others
are for arm-soc, etc. I see a sandwich of patches too so it sounds like
I can't even take just the clk ones for fear of breaking something that
the dts bits in the middle clear out of the way.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
