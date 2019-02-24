Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219D2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:11:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CC720651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N3K9zG8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CC720651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martin.sperl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Mime-Version:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jH8ZJafgzlLTm1QgYnj8qwHrQug2tokksktS30YExBE=; b=N3K9zG8wEyMZNi
	03Hq+hnyWfLHKNBP5aGRYvY9YLizdulsIpDkfvuqDXxmR8WaY+3uUEFkMVh3NHxnEZiAQFu8yTvzd
	MBTdd6RIRoHfGD3Up3409Bfvw7gbb1kYi0hvcxijyJInGRlExDjUrUsmH74a/D1MikQjL+BUuunhP
	7BmlKmzcpphpVlQY27TO3oHPG0mPf7bsQiQOs6FBMLB5iwM30MSMqEvmLWloKIB6R+XjdNwB7+bQe
	8LhnpeKsFDBgmhzSORPv16rxd+z47KFKh05TtCgI4kej6jjkJTJHZV08Te51w0E4IHJuwjHCeLZCK
	JVzTjW8gTqOpPvKBY5+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy07S-0008TM-OW; Sun, 24 Feb 2019 20:11:26 +0000
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]
 helo=cgate.sperl.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy07O-0008SV-NV; Sun, 24 Feb 2019 20:11:24 +0000
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11]
 verified) by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
 with ESMTPSA id 7757617; Sun, 24 Feb 2019 20:11:18 +0000
Subject: Re: [PATCH 0/9] spi: bcm2835aux: bug fixes and improvements
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: kernel@martin.sperl.org
X-Priority: 3
In-Reply-To: <1294540802.93488.1551036147867@email.ionos.de>
Date: Sun, 24 Feb 2019 21:11:23 +0100
Message-Id: <5A8B7C11-DB72-4384-945F-97D35554CFA6@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
 <1294540802.93488.1551036147867@email.ionos.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
X-Mailer: Apple Mail (2.3124)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_121122_935562_81D99CDF 
X-CRM114-Status: UNSURE (   4.41  )
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
Cc: linux-spi@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Hubert Denkmair <h.denkmair@intence.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> On 24.02.2019, at 20:22, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> 
>> Finally we remove some dead code.
>> 
>> Martin Sperl (9):
>>  spi: bcm2835aux: fix driver to not allow 65535 (=-1) cs-gpios
>>  spi: bcm2835aux: warn in dmesg that native cs is not really supported
>>  spi: bcm2835aux: setup gpio-cs to output and correct level during
>>    setup
>>  spi: bcm2835aux: add driver specific stats to debugfs
>>  spi: bcm2835aux: make the polling duration limits configurable
>>  spi: bcm2835aux: unifying code between polling and interrupt driven
>>    code
>>  spi: bcm2835aux: remove dangerous uncontrolled read of fifo
>>  spi: bcm2835aux: use BCM2835_AUX_SPI_STAT_RX_LVL
>>  spi: bcm2835aux: remove dead code
>> 
> 
> i consider patch 7 and 8 as possible stable candidates. How about rearranging this series that these patches comes first and could be backported?

Well - as far as I know 6+7+8 can get applied independently 
(and you will need 6 as otherwise you would need to apply
at least 8 in 2 places).

The one observation that I have made is that when applying those
against 4.14 you needed some more patches that have gone in since
4.14 to apply cleanly.

Martin
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
