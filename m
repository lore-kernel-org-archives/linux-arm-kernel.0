Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A02C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:53:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58E620828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qv1JRMBF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lds4DTdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58E620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:From:To:Subject:MIME-Version
	:References:In-Reply-To:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=elAt/7o//9akBAQl5o+FzrGrh2KVdG1YFzUJmDwBeBo=; b=qv1JRMBFGoa9zY
	aZ8W65TAN8HqF288kfa6Wt6xiqa8aHyNLG9i3E4g0LHH5cs30OdJ6HmfEWASe4Po+S+LZIvK0ywRX
	GWv+mywVPAfg9AQWVQvt8egU0ht3NisxOSZjjGHSz2ovXGpFkOURdaymIdFYTD46QDtCdI2PIi09c
	Eox8pPrLI7nt8qWcxrDANUar8tPMjaXvElP3bVaF/1ZITGtFIVLeONzNAliIg5jllWb6MMrnICrk6
	alhIvSS7VT0qWlbFpVlelFpseJSHsrLseNqndeu5BZYIXQQn+/CMJgc1XC1BWzTdvNkZuOeJmEB1Z
	Q3FK6NROcYpughtJ5dsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdy0e-0000CT-Ah; Mon, 31 Dec 2018 13:53:36 +0000
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdy0a-0000Bm-N3
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 13:53:34 +0000
Received: from [192.168.0.104] (unknown [78.130.214.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 882C01EC02AE;
 Mon, 31 Dec 2018 14:53:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1546264402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDGFarEqBTIVBc440gKwnKsVyV0Mt0fkgmO27WZg9YM=;
 b=lds4DTdtxJHxCdKoNJAJxXd8FScRN5eVYTTdXZpHwg0l8zYFxz1iKFFos9auG39J06ine3
 EKfz2ZPWp9y7A+LE5opdg27WHzLGUPBwC5aZNLbYcvfwGSSYqNoXB0FLz1kOue8vz9NSnm
 awIpPQu9v8rmR9ZIEi2OcL1kiKKJxEk=
Date: Mon, 31 Dec 2018 15:53:20 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20181231132000.3894E6E85603@corona.crabdance.com>
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-2-git-send-email-schaecsn@gmx.net>
 <20181231132000.3894E6E85603@corona.crabdance.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] EDAC: Add Aspeed AST2500 EDAC driver
To: schaecsn@gmx.net, Stefan Schaeckeler <schaecsn@gmx.net>, robh+dt@kernel.org,
 mark.rutland@arm.com, joel@jms.id.au, andrew@aj.id.au, mchehab@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-edac@vger.kernel.org, sschaeck@cisco.com
From: Boris Petkov <bp@alien8.de>
Message-ID: <107B9625-83E8-4791-AE21-F7D089DA6D97@alien8.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_055332_902459_20941671 
X-CRM114-Status: UNSURE (   6.14  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On December 31, 2018 3:20:00 PM GMT+02:00, Stefan Schaeckeler <schaecsn@gmx.net> wrote:
>Let me start with reviewing my own driver. Perhaps someone could review
>it as well, please?

Someone will review it when the merge window and vacations are over.

-- 
Sent from a small device: formatting sux and brevity is inevitable. 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
