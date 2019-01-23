Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927EEC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:08:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C84621726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P+dQXcW5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nn/MWsfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C84621726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qoPJ4pUNwTy/WsO+pn9dAdzPV5GFThRD72475tOHoLM=; b=P+dQXcW5rZojlD
	B/ILzX4h43Tl1q9XH1sUcDQTD3j3wHEc2Y2FggVMz3QzYpIibFxw3IMf3sw7oz1WdplHGLlxoBNQu
	IHFrbUadMnCu+ecg/R4gt9E4A8fEo+MPbC0IkH4IMjw5pj43PmPet58ahdVwSGkuSzTF8po4/tzvs
	8Vd0U0ETz2SS5ydq6F68C8wEPhrnKLleSiTleOWjxxNcLNhLg9G/5ov2Jy394u6wmZZ3HV9eew/PN
	6/9klYxfUntEZmsNStjMvQ9J3MVRIFKngGp0HpquemvfNJ0MIVFJ8kd4hVpog2p221fFaXbohR43+
	yFouuo0JHCJgZlFpLQWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmFSd-0000EF-An; Wed, 23 Jan 2019 10:08:43 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmFSa-0000Dp-BK
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:08:41 +0000
Received: by mail-pg1-x541.google.com with SMTP id t13so842202pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 02:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ihsk7jzukaXK8NDLm1gVpRPemabDHuHugNHDxbakah4=;
 b=Nn/MWsfq2wMJ5cafOFUFRLmxK6yUWJPmEpWdqAw107mnyulq48H4C08TPLyIhuIOPw
 NcF2BU5svQqwWGDo7CcLDS2q6T0F+29cWDCdvlnvnkHa/8e0tW+qk9KDjf0tVbhsBHYG
 w0S8uon984629DqOROoIYhp0mpeIYuraG4VmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ihsk7jzukaXK8NDLm1gVpRPemabDHuHugNHDxbakah4=;
 b=Un61HxkKDQU9l1bX16DzpZvGpAhOzbttKpXvH7kKNdnu3nld4/kDsyS0PKF1LKBplg
 IxC2jTlejDNT1CBm/2vIPlHwvzZIe5IUhS7rN+6FXh1Boo9z8OgPcm4c/PI+yNwuIip4
 UY6hmlRmyS/v+dSsEYtpT+gZ6WACleplCfdhhpaeuJSKofeWhBr2P6AEIVgZmVpKW/DJ
 gDRXcpkZ3+v9ESaLimEmNuIgsD8Odq+ASNMiZtxmqZitfrfHYKziKRP6evv/ZGG3w2+6
 ouBI8Y+KxbEImEpFazRKtT7HSnk1CnJpE+a/zCmQenV70zvXoFl2L/F5X60lX1TmwuX9
 vLCg==
X-Gm-Message-State: AJcUukcIC+GowNyIwbAbDY8qYCKT4MFccEpqwSc1iMp3LdSlnT/3EXop
 GY3hpgQLqmc9OjwV52fEZzbWk8hofqY=
X-Google-Smtp-Source: ALg8bN4k6jAgr+evXqWE7UmlXA3CE16EVOSRfR+gCY/xzaAS0RgTmYGPfYq6+RvWMf51utGrpHsGnA==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr1446528pgl.127.1548238118940; 
 Wed, 23 Jan 2019 02:08:38 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id r8sm23753753pgu.38.2019.01.23.02.08.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 02:08:37 -0800 (PST)
Date: Wed, 23 Jan 2019 15:38:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v5 0/2] Add cpufreq support for Armada 8K
Message-ID: <20190123100835.2oyldqvhsygoxzzo@vireshk-i7>
References: <20190118141140.30352-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118141140.30352-1-gregory.clement@bootlin.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_020840_388552_5DF1E7AE 
X-CRM114-Status: GOOD (  10.21  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18-01-19, 15:11, Gregory CLEMENT wrote:
> Hi,
> 
> this is the fifth version of a the series adding the cpufreq support
> for the Marvell Armada 8K SoCs.

Applied. Thanks.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
