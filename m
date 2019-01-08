Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13649C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:09:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1310214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AK7FYvpp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jkvRP2c0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1310214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P87uz1TrSWCdy0QRgWzSGnzjW0J8VA7XJWvt2NGRSGE=; b=AK7FYvpp+NK0Z2
	9Mn8bPXy1GaKW5LadPl7Zgh821RiEvOsYo6JQLLf5+xfcej+P9Eh9uRcWCw+BupVXwG2GTnPxRVPx
	jEINJT3n17H9jVFM9AftBWzS9m+B/AvO4vjk2aLGPh0Qzai5DHg/TmxQSzHPSx8AvGI/+walPvywN
	msFad9L+WNg86LvAZrAhnL8LWD5ZYXRMiY4qebTh3TE3z59K19S8z4nnieHPCqEnQAGSg/b8XfPXz
	F3ltFqzRWrWeCnprLEnlkwWo5rme4pBc9tjdWWSe+xq2aJCtGfaqqef8fILM58Euffsg1PPAbI3Zn
	xLNbKWt+SHMC8EYK3H1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh0Ul-00077t-H8; Tue, 08 Jan 2019 23:09:15 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh0Ui-00077O-Lb
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 23:09:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=sD7XBIRCD2+98r7mljHYsnMyGuXtM5B54h4tEq8abPU=; 
 b=jkvRP2c06TVldv4TVYjwbVGWQT3fIlNckonmREEf4bszpXY38j5hcFJu0q2dEGhYFtvLQjO2jCwrETEGL7CeWT2V8+rVOb1zX4Ngeupxy7UBPbjcyJdhobylahu07Wo1Dr7m+zpG5WlcbVw32b9MvkDweXVyXu04KCS+obJWsYI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gh0UY-0000R9-ES; Wed, 09 Jan 2019 00:09:02 +0100
Date: Wed, 9 Jan 2019 00:09:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: dts: kirkwood: Fix polarity of GPIO fan lines
Message-ID: <20190108230902.GC16047@lunn.ch>
References: <20190107230818.6020-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190107230818.6020-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_150912_862660_6BEB662F 
X-CRM114-Status: UNSURE (   8.98  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Jamie Lentin <jm@lentin.co.uk>,
 linux-arm-kernel@lists.infradead.org,
 Julien D'Ascenzio <jdascenzio@posteo.net>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 12:08:18AM +0100, Linus Walleij wrote:
> These two lines are active high, not active low. The bug was
> found when we changed the kernel to respect the polarity defined
> in the device tree.
> 
> Fixes: 1b90e06b1429 ("ARM: kirkwood: Use devicetree to define DNS-32[05] fan")
> Cc: Jamie Lentin <jm@lentin.co.uk>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Julien D'Ascenzio <jdascenzio@posteo.net>
> Reported-by: Julien D'Ascenzio <jdascenzio@posteo.net>
> Tested-by: Julien D'Ascenzio <jdascenzio@posteo.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
