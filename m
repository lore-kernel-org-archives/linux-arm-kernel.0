Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6109CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:24:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309A32147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yz3M4plr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309A32147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZcZ6L60jSkzAzo/BBmUxOJlh8pJKoAvEmx7cOZj1+4o=; b=Yz3M4plrnz9lKQ
	Vf0czm0Ukytio/qwraMAmkR3VU+Elww6U4Y8Rk0gVEzVnfVMp+OxrMd0d64Bslzy5D6n9CvVBKxg1
	HvhkVDVhe9wniekLZFgWjTwvSAhfQw86sJmU0ru7M4goOtjPimOuSOMsk0iGruggOLbl8W0qzytSG
	6xXCDj0EMQVqlBHoLdSLxaOarQ422qKPym+12zXTWiLlUMxPjLjFF/8xIiz1hN6spTEsDQ92m59HT
	PaGEhf4iWcxBGqbtOFBY2U0UrMhGZEHS8gJzBWszBLBVh4uPOPwi4nv6TSOr1P9HDYN9tg/m/L4Bu
	C54rqk6pepRbBbMzX6tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyDQp-0004Lu-2J; Mon, 25 Feb 2019 10:24:19 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyDQl-0004L6-5A
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 10:24:16 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Feb 2019 02:24:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; d="scan'208";a="124990832"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
 by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2019 02:24:10 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1gyDQf-00081P-LS; Mon, 25 Feb 2019 12:24:09 +0200
Date: Mon, 25 Feb 2019 12:24:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v5 0/3] i2c: at91: slave mode support
Message-ID: <20190225102409.GQ9224@smile.fi.intel.com>
References: <20190222092522.4913-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222092522.4913-1-ludovic.desroches@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_022415_248125_E01A5A1E 
X-CRM114-Status: GOOD (  18.19  )
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
Cc: alexandre.belloni@bootlin.com, wsa@the-dreams.de,
 linux-kernel@vger.kernel.org, me@jue.yt, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 10:25:19AM +0100, Ludovic Desroches wrote:
> [Ludovic Desroches: see Changes section]
> 
> Based on the discussion we had on the i2c-linux list [1], I wrote a patch for
> AT91 hardware and tried to fulfill the Linux I2C slave interface description
> [2] as good as possible. This enables aforementioned hardware to act as an I2C
> slave that can be accessed by a remote I2C master.
> 
> I have tested this patchset successfully on an ATSAMA5D27.
> 
>                                  ^  3.3V   ^  3.3V
>     +-----------------------+    |         |         +-----------------------+
>     | Slave: ATSAMA5D27     |   +-+       +-+        | Master: ATSAMA5D35    |
>     | with i2c-slave-eeprom |   | | 100k  | | 100k   | with i2cset           |
>     +-------------------+-+-+   +-+       +-+        +-+-+-------------------+
>                         | |      |         |           | |
>                         | +------+---------|---(SDA)---+ |
>                         +------------------+---(SCL)-----+
> 
>     Schematic: Connection of slave and master with 100kOhm pullup resistors.
> 
> On the master the following BASH script has been used to stress the slave.
> 
>         root@emblinux:~# cat ./stress.sh

>         #!/bin/bash

Not everybody has bash in their environments. See below, how easily to switch
to regular shell.

#!/bin/sh

>         I=0
>         while true
>         do
>                 if i2cset -y -r 1 0x64 0 $I w | grep mismatch
>                 then
>                         echo "$(date): Error in transmission ${I}"
>                 fi

>                 ((I++))

I=$(($I+1))

>                 if [ $I -eq 65536 ]
>                 then
>                         I=0
>                         echo "$(date): Sent 65536 transmissions"
>                 fi

This one can be optimized to

for I in $(seq 65536); do
...
done

>         done
> 
> After running the script for some time I had the following output. To me this
> looks promising :)
> 
>         root@emblinux:~# ./stress.sh
>         Thu Nov  9 13:58:45 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 14:35:20 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 15:12:11 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 15:49:04 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 16:26:00 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 17:03:07 UTC 2017: Sent 65536 transmissions
>         Thu Nov  9 17:40:15 UTC 2017: Sent 65536 transmissions
> 
>         If you have some hardware with an at91-i2c interface included at hand, I really
>         would appreciate if you can run the test script on your hardware and test this
>         driver.
>         Thu Nov  9 17:40:15 UTC 2017: Sent 65536 transmissions
> 
>         If you have some hardware with an at91-i2c interface included at hand, I really
>         would appreciate if you can run the test script on your hardware and test this
>         driver.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
