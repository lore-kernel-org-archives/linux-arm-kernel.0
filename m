Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9957C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:11:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A6F207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mVVRvej/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizzup.org header.i=@wizzup.org header.b="HyTkqgYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A6F207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wizzup.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2mXR+OhsuPMO85w+r5D7arZXEanhtt8NVElyAAlrh78=; b=mVVRvej/UJEBQSxBK3lxldltOY
	nWeMAh4kV4k90+CXH5B5d3vwqTYdztKuby7G5/LnC+HesdNKCpsKgnCoRV2lZLDuuQrtHTYKg4nc4
	MwHertAzycCcpAQQDESqz3saxOOBiWUG6VPCHvjMT3qs9U5vJGNGrHJQfpacdsyyKbYSYBNcJTVcs
	NTPnmo/Hk9LXZ6oVCsE6fpqVpNYvClGmXF4IxkMYUvMG9g/62/XDHmd64B8twO2H5GtI7rXZTg90N
	jayA+FqGBbI8ZgtdCtVExL/zKg0/ye0x5OMLJUxADzZDNVAQiwV4TOYErqONgKTS0c3mVE0pRIImf
	xIiJ2QoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmo9C-0001Ob-Hn; Thu, 24 Jan 2019 23:10:58 +0000
Received: from nala.villavu.com ([188.165.243.101])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmo99-0001NP-6W
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 23:10:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org; 
 s=mail;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NEKPgRzoUv+80WZISdXianijI8erhBww9QDgsrZnhOY=; b=HyTkqgYEd9dQOSi4StQtAXKogf
 cZ5DrJ5PcUylQ9++Sexx5/efiaJ0XMTaxNRJr9Agc3YIwJm1i5izbFk5YmSaERZ/SS3+lfMr4yDQ/
 /2tJ8dGAXfLTG3bsprJzFgSx6FV7SuwULXv5tqarwemloToh5mXCLZfeutEn7b/kOPtzj8OtJr6ck
 t/UbfLdDohNSVDvfC93YB3I+dycJnDkBxAqoxOTtwIFRVI+6mEjGm1SuKWzMrYHuj02kdUNRmiZie
 lWkanhQyhI+f65yl2c4b0Dcdnea5eqWZL0SqFx9wqHTd2xzuobeR7ZYpoRIIlpm1hAxUrRIo6FmN5
 Krwztndg==;
Received: from a82-161-36-93.adsl.xs4all.nl ([82.161.36.93] helo=[0.0.0.0])
 by nala.villavu.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <merlijn@wizzup.org>)
 id 1gmo90-0002y4-B3
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 00:10:46 +0100
Subject: Re: [PATCH v6 00/22] drm/sun4i: Allwinner A64 MIPI-DSI support
To: linux-arm-kernel@lists.infradead.org
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
From: Merlijn Wajer <merlijn@wizzup.org>
Openpgp: preference=signencrypt
Autocrypt: addr=merlijn@wizzup.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <730abbd4-4881-0f63-3ba4-bcba445e808c@wizzup.org>
Date: Fri, 25 Jan 2019 00:12:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_151055_395911_2CDEDBB9 
X-CRM114-Status: UNSURE (   6.32  )
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

On 24/01/2019 20:58, Jagan Teki wrote:
> Here is next version changes for Allwinner A64 MIPI-DSI support

Tested-by: Merlijn Wajer <merlijn@wizzup.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
