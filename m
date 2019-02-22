Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19944C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:41:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E542070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e7sZTnls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E542070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y5jbvVFsXPLQQsG/xv/mcyMSJWViBvvNGP44osLE6Qk=; b=e7sZTnlsiPd8yv
	tBKAAJtORp048/wErntXBbnXpUQ8eFT7zOCrrhfU13c5AkvDsvei2st9mIQkjUq7urnCI7jdkgpPR
	ZFm8OR8Fe7u+gaPtfwU+6zYTJd+eZHevci1utZCep8gZ73q35A/CfNLu7t/ECmeMHCbWysxVAlJLs
	GsgAvGI5ZWoJ2Z8Bjdt+xIAxKVSV/qHKxa1mK7jLoXLy9cdX3EozNe37z2N+JujK+TFqk7LTRh39m
	I/KUXxQXH31d0ecZL55zh6q/7oIEogc7SbAmFBxmwxY5mKzzL3+dMI2ro/BCCoFeqo68UJbI3iNaX
	Pc7uSX3gbSUJoA46stCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxHdJ-0005vn-Eu; Fri, 22 Feb 2019 20:41:21 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxHdG-0005uq-HC; Fri, 22 Feb 2019 20:41:20 +0000
Received: by mail-ot1-f67.google.com with SMTP id q24so3034715otk.0;
 Fri, 22 Feb 2019 12:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3+gCNdMA0pa6pnYLwz1SdMO+iPmhzsS3hSVhIJ8YpgU=;
 b=KUZXohD2rD6LRZur5b6OzWKjWiyOh34PE2IGGcbbyBd7p/Iolt5KtnuK4Q3Y7PfkZF
 o4i4nxTiiLC1LS+nAIVh/azUzItAbdvirxS7MqyKStJktz1wQ5il9Tv7DXwnHDZY5Z7V
 0mRKqGnpZUrCDzEPcyOuEFh9qgiQb8o7CqiE9PhpSt6VjfjzPBiUTtwLqkQttGXoGgJd
 We3PFcf8+9vWvSV5TcAWWn6fksInh/h45YEsyhGVu9YzqAfGDLaPyNsr47o1+bErAT6q
 ioLi2zjh19Kg5VOS+lAK6Aa8IhczjSdmwrNd0u14CwU1BIlOPqCWUk2Pp3y52d/nzh29
 BkVg==
X-Gm-Message-State: AHQUAuZpP9EiOro2bDhaPOpR46aF2+R0M0iIn+r+GMBZvWpbwt7F87Kp
 hFOSHJwX1IcxTD5s4yfT1A==
X-Google-Smtp-Source: AHgI3Ibeg6o4/louD6BhwdNQigpsOTGtd2UDAEKCGh4dhyC6/WmltldZZjDh39Y7/Y6MlhcWAacOFQ==
X-Received: by 2002:a9d:4e8b:: with SMTP id v11mr3779521otk.316.1550868077377; 
 Fri, 22 Feb 2019 12:41:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m89sm976461otc.7.2019.02.22.12.41.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 12:41:16 -0800 (PST)
Date: Fri, 22 Feb 2019 14:41:16 -0600
From: Rob Herring <robh@kernel.org>
To: michael.kao@mediatek.com
Subject: Re: [PATCH v2,6/7] dt-bindings: thermal: add binding document for
 mt8183 thermal controller
Message-ID: <20190222204116.GA25502@bogus>
References: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
 <1550665893-22561-7-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550665893-22561-7-git-send-email-michael.kao@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_124118_563608_B62EB283 
X-CRM114-Status: GOOD (  10.52  )
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
 linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, Michael Kao <michael.kao@mediatek.com>,
 Eduardo Valentin <edubezval@gmail.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 20 Feb 2019 20:31:32 +0800, <michael.kao@mediatek.com> wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> This patch adds binding document for mt8183 thermal controller.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
