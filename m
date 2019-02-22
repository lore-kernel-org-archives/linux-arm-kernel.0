Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251F6C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:26:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C7220700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jNTsZh0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C7220700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NWV+E9oTX9yrQloOWHw4p7MiQDmKouzOcA/T7kE3sHY=; b=jNTsZh0Bh+RRsA
	9R1o5sd7bMY3ciWQCx08xd6dDP44D6WZ7s0MvH1hASsztBfz9ozyV3TpyCh6m05EQCAXrUqoeMjAR
	TcfiS31nK7Bi/Ta+e0+VumEyTVms9zK1FrUKfTQ0IGWSE8Pe42RH2/XEvxP6kMk/eaxr3W991WX5C
	uAGPkQsPHmEsIRu4NrcXLwGT3oP+e1us1otvBbGQMgl1qzfpnOqJl3gHHLXItgaDp4upWgzLcCdQr
	crUwozM/57k1LtQeSDyYRtpbaGvheinr4HwbJ+9tUnN0Ct7/EGMjxbiKrCehnqVN1BfK7YkALoxbg
	PMgSPU8KaMofK3HhTJOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx75h-0005I4-U0; Fri, 22 Feb 2019 09:25:57 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx75e-0005Gx-WD
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:25:56 +0000
X-IronPort-AV: E=Sophos;i="5.58,399,1544511600"; d="scan'208";a="24284338"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 22 Feb 2019 02:25:52 -0700
Received: from M43218.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Fri, 22 Feb 2019 02:25:46 -0700
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/3] i2c: at91: slave mode support
Date: Fri, 22 Feb 2019 10:25:19 +0100
Message-ID: <20190222092522.4913-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_012555_075716_6D49E0BB 
X-CRM114-Status: GOOD (  14.52  )
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
Cc: alexandre.belloni@bootlin.com, wsa@the-dreams.de, me@jue.yt,
 linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[Ludovic Desroches: see Changes section]

Based on the discussion we had on the i2c-linux list [1], I wrote a patch for
AT91 hardware and tried to fulfill the Linux I2C slave interface description
[2] as good as possible. This enables aforementioned hardware to act as an I2C
slave that can be accessed by a remote I2C master.

I have tested this patchset successfully on an ATSAMA5D27.

                                 ^  3.3V   ^  3.3V
    +-----------------------+    |         |         +-----------------------+
    | Slave: ATSAMA5D27     |   +-+       +-+        | Master: ATSAMA5D35    |
    | with i2c-slave-eeprom |   | | 100k  | | 100k   | with i2cset           |
    +-------------------+-+-+   +-+       +-+        +-+-+-------------------+
                        | |      |         |           | |
                        | +------+---------|---(SDA)---+ |
                        +------------------+---(SCL)-----+

    Schematic: Connection of slave and master with 100kOhm pullup resistors.

On the master the following BASH script has been used to stress the slave.

        root@emblinux:~# cat ./stress.sh
        #!/bin/bash
        I=0
        while true
        do
                if i2cset -y -r 1 0x64 0 $I w | grep mismatch
                then
                        echo "$(date): Error in transmission ${I}"
                fi
                ((I++))
                if [ $I -eq 65536 ]
                then
                        I=0
                        echo "$(date): Sent 65536 transmissions"
                fi
        done

After running the script for some time I had the following output. To me this
looks promising :)

        root@emblinux:~# ./stress.sh
        Thu Nov  9 13:58:45 CTE 2017: Sent 65536 transmissions
        Thu Nov  9 14:35:20 CTE 2017: Sent 65536 transmissions
        Thu Nov  9 15:12:11 CTE 2017: Sent 65536 transmissions
        Thu Nov  9 15:49:04 CTE 2017: Sent 65536 transmissions
        Thu Nov  9 16:26:00 CTE 2017: Sent 65536 transmissions
        Thu Nov  9 17:03:07 UTC 2017: Sent 65536 transmissions
        Thu Nov  9 17:40:15 UTC 2017: Sent 65536 transmissions

        If you have some hardware with an at91-i2c interface included at hand, I really
        would appreciate if you can run the test script on your hardware and test this
        driver.
        Thu Nov  9 17:40:15 UTC 2017: Sent 65536 transmissions

        If you have some hardware with an at91-i2c interface included at hand, I really
        would appreciate if you can run the test script on your hardware and test this
        driver.

Best regards
  Juergen


[Ludovic Desroches]
Changes in v5:
 - use SPDX for licence
 - replace IF_ENABLED par defined to solve compilation issue when
   selected as module.
Changes in v4:
 - rebased on next-20181224
 - update Kconfig part to state that this feature is experimental.
 - tested quickly on a single board, SAMA5D2 Xplained, i2c-gpio as master, OK.
Changes in v3:
 - rebase (cherry-pick was enough)
 - fix checkpatch errors
 - tests:
   - hangs with a SAMA5D4 (master and slave on different busses) after about
   100 transfers. It's the first time I do this test.
   - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
   I don't know if it's a regression. I don't remember having seen this
   behavior previously.
   I think it's worth taking those patches even if there are some possible
   bugs. It'll allow to get more people using it and so to consolidate the
   slave mode support.

Changes in v2:
 - Implemented all suggestions made by Ludovic. (Thank you!)
 - Reworked the IRQ handler completely. Have a look in patch 3 fort further
   details.

[1] https://marc.info/?t=150824004800001&r=1&w=1
[2] https://www.kernel.org/doc/Documentation/i2c/slave-interface

Juergen Fitschen (3):
  i2c: at91: segregate master mode specific code from probe and init
    func
  i2c: at91: split driver into core and master file
  i2c: at91: added slave mode support

 MAINTAINERS                                   |   3 +-
 drivers/i2c/busses/Kconfig                    |  13 +
 drivers/i2c/busses/Makefile                   |   4 +
 drivers/i2c/busses/i2c-at91-core.c            | 376 ++++++++++++++
 .../busses/{i2c-at91.c => i2c-at91-master.c}  | 459 +-----------------
 drivers/i2c/busses/i2c-at91-slave.c           | 143 ++++++
 drivers/i2c/busses/i2c-at91.h                 | 175 +++++++
 7 files changed, 721 insertions(+), 452 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-at91-core.c
 rename drivers/i2c/busses/{i2c-at91.c => i2c-at91-master.c} (66%)
 create mode 100644 drivers/i2c/busses/i2c-at91-slave.c
 create mode 100644 drivers/i2c/busses/i2c-at91.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
