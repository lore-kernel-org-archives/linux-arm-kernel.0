Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6320CC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:31:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBCD2190B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fo8a/lfR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ZmeCzXbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBCD2190B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:
	Subject:To:From:Date:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=myKagmQjEuUA3TNXCL0BFYUa6PCcpFVjybbkG0IKtXA=; b=fo8a/lfRlsUHO1
	Sjf8emDHXZK61rreTXMEv2smKfFmbFTsbrI9xNfGvSyS9KpNj470GlozdfsozPbTbG4mNJ2WuERsX
	c2AD+YZ2bB8q8NXuCN2iUdZQqdv6ekVP3ZS6hNa5KgtH4PkehYsBFr1s4swASsSHjDTRuPYHUoBrO
	P56RMUgnH6ZY5h3rlmAGOm8YVhwo600LTYyHwSYZGAFqhTC8zQKXD7J+UCD4zTKH54fZKB+dsMSLt
	7rSpji1Fb20LAs7MUJAWq170V1o7zJ4puGlReT33Lf5AZqgBSn74AdYIgJkucGDLptGe8jVqRne73
	svzH8l4s9s6LHY4U5YFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtdlx-0008U2-4O; Tue, 12 Feb 2019 19:31:13 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtdlt-0008TX-LD
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 19:31:11 +0000
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 209F85C026A;
 Tue, 12 Feb 2019 20:31:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1549999868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlRbHEOXyiu40U9NCbv3zqgTF73UAsRWJa7LCVDhGlQ=;
 b=ZmeCzXbAbdKcB+EezCMBjqPkU8P/iX6dt0PA+vkXqULIS2i6TcBnyrVh3IwsFD2mpzGJdQ
 FPmQ9WxidmZKbZEgWtaWrCg0GZaOz4IA68E6/8o06jbF+FvEc0ZeNPOYwgygkMmMxiM0kY
 rYZjDj1bfOsdoVu09IRnesL+O+xQdiQ=
MIME-Version: 1.0
Date: Tue, 12 Feb 2019 20:31:08 +0100
From: Stefan Agner <stefan@agner.ch>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/5] ARM: convert to unified syntax
In-Reply-To: <nycvar.YSQ.7.76.1902101620430.2213@knanqh.ubzr>
References: <cover.1549753425.git.stefan@agner.ch>
 <nycvar.YSQ.7.76.1902101620430.2213@knanqh.ubzr>
Message-ID: <da23b2ceddf2a73e1c772b7994f52d2f@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_113109_878368_44BEC346 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: mark.rutland@arm.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
 will.deacon@arm.com, julien.thierry@arm.com, ndesaulniers@google.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 natechancellor@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10.02.2019 22:24, Nicolas Pitre wrote:
> On Sun, 10 Feb 2019, Stefan Agner wrote:
> 
>> This patchset converts all assembly code to unified assembler
>> language (UAL) compatible assembly code. From what I can tell,
>> this mainly boils down to using conditional infixes instead of
>> postfixes.
>>
>> Most of the conversion has been done using the following regular
>> expression:
>>   find ./arch/arm/ -name "*.[hSc]" -exec sed -i -r \
>>     "s/^((\s*[._a-zA-Z0-9]*[\:\(])?\s*)([a-z]{3})(eq|ne|cs|hs|cc|lo|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)([a-z]{1,2})(\s)/\1\3\5\4\6/"
>> \
>>     {} \;
>>
>> The expression resulted in some false positives and missed some
>> instances where infix conditionals have been used. With this
>> changes applied, I compiled several kernel configurations
>> successfully and without a warning.
>>
>> The file arch/arm/probes/kprobes/test-arm.c is still using some
>> divided syntax assembler.
>>
>> This does not allow to use LLVM's integrated assembler just yet,
>> there is still some assembler which the integrated assembler does
>> not like (yet). But it is a big step towards that direction.
> 
> OK....
> 
> Please document why you added .syntax unified in the commit log of each 
> patch where this is added along with a link to the gcc PR.  Then you may 
> add Acked-by: Nicolas Pitre <nico@linaro.org> to the whole series.

Agreed, that is a good idea. Will send v3. Thanks for the Acks.

--
Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
