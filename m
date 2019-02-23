Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF816C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:38:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46E9206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AwptSk9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46E9206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5HIph6gCisYoUzJcYX45SG36t9xPni0qI9QCjO4lIa4=; b=AwptSk9HC9OdKe
	nH5lAGHhaufOkyK+4MD2z0opE8tEd9+B6IgA4JpLsEFy+L9bqnauLPb61r1TNT2iY9DVdv+/FSTl1
	V7LU2j7Rpv1vij4b1BlnAjW5slqluNbmKdNhr5gETp7/nMW559t/vAcdHCeaA1NW8NbBHKMkExQGe
	8J1TR8PILFbppi+l+tEgVxBPIgkP7JzhW5W3LCkHh6nGJV/R7udxndxe/WEssqsGIQYaG5ZkwDWTj
	eGyal/5bUSaZGbBGdITkQIgkgsdiZdCkj7GdB0sIsYik1anPwXliMCHQlaqVeG82l7BMpYp07pH8a
	cS9edVBEsUV1Gb9XEFcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxVdC-0002qd-HY; Sat, 23 Feb 2019 11:38:10 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxVd9-0002qF-8K
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 11:38:08 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 74B58453CCF;
 Sat, 23 Feb 2019 11:38:03 +0000 (GMT)
Subject: Re: [PATCH 1/3] Input: lpc32xx-key - add clocks property and fix DT
 binding example
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20190126142921.16041-1-vz@mleia.com>
 <20190126142921.16041-2-vz@mleia.com> <20190223004158.GA3951@bogus>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <41befcd7-5ca4-34c9-6929-1ae1d706b108@mleia.com>
Date: Sat, 23 Feb 2019 13:38:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190223004158.GA3951@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190223_113803_517979_01355293 
X-CRM114-Status: GOOD (  12.90  )
/bin/ln: failed to access
 'reaver_cache/texts/20190223_113803_517979_01355293': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_113803_517979_01355293 
X-CRM114-Status: GOOD (  13.11  )
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
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Dmitry,

On 02/23/2019 02:41 AM, Rob Herring wrote:
> On Sat, 26 Jan 2019 16:29:19 +0200, Vladimir Zapolskiy wrote:
>> The keypad controller on NXP LPC32xx requires its clock gate to be open,
>> therefore add description of the requires 'clocks' property.
>>
>> In addition adjust the example by adding description of required 'clocks'
>> property and by fixing 'interrupts' property.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>>  Documentation/devicetree/bindings/input/lpc32xx-key.txt | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

can you please pull this documentation change through Linux input branch?

The two other dts changes have been already included into arm-soc.

--
Best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
