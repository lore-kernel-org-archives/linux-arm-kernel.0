Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D471C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:52:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBAC2206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a5xelMaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAC2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WA5EkBo/6wSYy41w6AcxZqkNUWHI6lNTFh6hAqP7DkI=; b=a5xelMaamxK4KS
	tL0OXcWYahRGV0t8eFxM0wek+wTJYfH4/NqlKdIt0li4uuRwFgZpVzZj5s+8+Rnkapi9GGB8x99dF
	sqmH+R4WYRfN216BO2o6YBbGjQeAIdTVPcVzWzi11D1/7F2ektu3+qis2w0kUmqAVH7Uhzr0pHXwM
	qvhD07+STgVhnlpmCdRCmySV3FeOjyzxgtECY2i4B9j+jAOBdpWEPppAbYJBsLhV9eXY4zDJuaKlf
	GsZXledQZIjcY7wPg3wKhWMJgXNDWKiaMD9b9ikPYp5nQFIuRJHoZjfWjdDZkn9Eidg+ff6vrkT2S
	EkuzVf/FMvfgwJyu7zTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdYr-0002ej-6N; Thu, 10 Jan 2019 16:52:05 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdYm-0002eC-2T
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:52:03 +0000
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.89)
 (envelope-from <logang@deltatee.com>)
 id 1ghdYg-0004VF-PC; Thu, 10 Jan 2019 09:51:55 -0700
To: Will Deacon <will.deacon@arm.com>
References: <20190109202100.6968-1-logang@deltatee.com>
 <20190109202100.6968-3-logang@deltatee.com>
 <20190110141503.GA31328@fuggles.cambridge.arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e272894e-31b6-2698-b6f5-5321b6853263@deltatee.com>
Date: Thu, 10 Jan 2019 09:51:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190110141503.GA31328@fuggles.cambridge.arm.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, linux@armlinux.org.uk,
 catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, will.deacon@arm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/2] arm64: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_085200_442221_B0DF835D 
X-CRM114-Status: GOOD (  10.93  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Stephen Bates <sbates@raithlin.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2019-01-10 7:15 a.m., Will Deacon wrote:
> On Wed, Jan 09, 2019 at 01:21:00PM -0700, Logan Gunthorpe wrote:
>> Cleanup the arm64_memory_present() function seeing it's very
>> similar to other arches.
>>
>> memblocks_present() is a direct replacement of arm64_memory_present()
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>  arch/arm64/mm/init.c | 20 +-------------------
>>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Did you want us to take this via the arm64 tree?

Yes please.

Thanks,

Logan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
