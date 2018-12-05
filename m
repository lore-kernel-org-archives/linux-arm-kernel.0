Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07BDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:16:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16A520834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PkxOlxNY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tf44rfrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16A520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kFSY39iNjBmPaqU+7R5831xD/Ud9+W1+HIn+o62m8Jw=; b=PkxOlxNY2qskGG
	PElTsY/CxW88m1NS3HkCmu9/S/73zVWZ+9J8kN6ozIqNpR0N2/A4QfwbNptVhSoAQaa/+28qFaAK0
	ARPUTim3thKQbwxvVBE+rKzmMqwVWREdcMWz2VEpM+gUcKPTfCwg333GtC1AJk/G0uGvSMroJ3qt6
	sQhiP0wWaTBJlspVLJeh5VWsrYUWLbhMECslqd36NClNonS4jSqu1Ra06iVjLuau6/CT21AvbOEeE
	3BbR5aEdNg/TaXvKXKEY5tR+H1TIGG6fh1aven+EtdZdDRQdjilW0sJSurLC/3HWuUmf0SnN0r9+6
	GDMid0yPbiKp6Ytc35ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gULnW-00042B-Da; Wed, 05 Dec 2018 01:16:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gULnT-00040r-6a
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 01:16:16 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 46EC220834;
 Wed,  5 Dec 2018 01:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543972564;
 bh=lByJGk82oohRj4/bN9/42+06EoEpV7mflIBNykS1fgI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tf44rfrB1zylAv4eShk2rmJIKrQNiTdLrcq7f2x2ir9SL2RjO1kFP0rRpEZ/CqS2D
 4PmU2B2KPpAnwr0O9IL/0Hiqmuix/V5wMuKLST6wIvzr5+QN56r8O1jroVQXAaYGJ3
 F1GjVdbA5AN5hpRZGIoIzEBP7WTtBqc0hXj6GuKk=
Date: Wed, 5 Dec 2018 09:15:26 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH 1/1] ARM: dts: ls1021a: add nodes for PWMs
Message-ID: <20181205011524.GC3987@dragon>
References: <20181127140944.31018-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181127140944.31018-1-patrick.havelange@essensium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_171615_305947_97668177 
X-CRM114-Status: UNSURE (   8.91  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, matthew.weber@rockwellcollins.com,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 03:09:44PM +0100, Patrick Havelange wrote:
> The LS1021A has 8 possible PWMs, so adding them (disabled by default)
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
