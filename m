Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFB6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:06:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813612146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eb3D82CL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813612146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gBDiB6BhRrXX5Cg+JySvOUns/vN7NgKbQwM891UMBMY=; b=Eb3D82CLPD/2Xo
	A2XJX7YcBu8mckhnxYof9xj6mNxqSBUaMGYpuLWF1fovXuPq7eX7lzNa9prax3XFjMTWUcMGgBRKJ
	grsdJjjuRLZRBXOrLFA6SvTvf5Ey/k4WVM5kZPsUWZuhwGtMKT+EwqARkR8THoM80EpD5iF0fnAFM
	mpDe5PWEOvKodlHNqzYGYNQ45uXN0Esj+4wcjRu8nH1i9FfBktmn3ICbLGtSNln4A3wUAq02X3oQ+
	gcYnzvXrDkAeyeDQOQ8rXZN1SWFgRDTjShLzk3rWfvittLQbHUiZpb38wDmnHgXpDSlm/Uze9WmW6
	L/cop986pv+jNHCZgSVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw62t-00078W-Sf; Tue, 19 Feb 2019 14:06:51 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw62p-00077y-CK
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 14:06:49 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 443jGC2Cs2z1rQYy;
 Tue, 19 Feb 2019 15:06:43 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 443jGC20dMz1r2Hh;
 Tue, 19 Feb 2019 15:06:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id BRVYrSNVUsHr; Tue, 19 Feb 2019 15:06:42 +0100 (CET)
X-Auth-Info: zNXrNbqHiG1EVMRQ/xHMjj4kZYtzarX9CEBf1Te65Cc=
Received: from [IPv6:::1] (unknown [195.140.253.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Tue, 19 Feb 2019 15:06:41 +0100 (CET)
Subject: Re: [PATCH 1/2] of: Add vendor prefix for Menlo Systems GmbH
To: Rob Herring <robh@kernel.org>
References: <20181004224227.16836-1-marex@denx.de>
 <20181016223249.GA14545@bogus>
From: Marek Vasut <marex@denx.de>
Message-ID: <e5476463-05ef-8762-3b7f-5df30f5fe11d@denx.de>
Date: Tue, 19 Feb 2019 15:06:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181016223249.GA14545@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_060647_572357_20EF562A 
X-CRM114-Status: GOOD (  14.94  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10/17/18 12:32 AM, Rob Herring wrote:
> On Fri,  5 Oct 2018 00:42:26 +0200, Marek Vasut wrote:
>> Add vendor prefix for Menlo Systems GmbH, http://www.menlosystems.com/ .
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Could this be applied separately , so I don't have to repost it ?
It seems I'm not getting any feedback from the iMX maintainer for months...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
