Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33715C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:59:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073722083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cA5HV4CC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073722083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gXrMIuo4aPSmFmX7Gfr1d7aA7HGLIZIMRAiJjoOgacw=; b=cA5HV4CCs2bwTt
	TToNs9HIwEtFhgqC5w1fc+mB/dQAxgfgD+Cc9d5RMNHe9cAh865iE3w7wxa5z5c9gq5JM21D70Con
	udheR0waBHqbEP6FvCCTTTJ0WjHLoPGkkr1FCXHzlGtJZrFyUf4nseq0GsyvSFk7be3AbhqFxEq0U
	XbeNzSt1gAIc0Kli5rueOYrqQhUKGOnVEDXD01kANx0yW4bH6p7T+H5fFpvGNPEPczfwht3pLr7lm
	YGJGePx6QpeZfxvlJwSDTm/PgnH6St1aCS2XHQf3zRuaGlDCadN7umbho1WazMpUIB5rWOYcGkSUa
	NV/hUr05yRcplleC4J1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr6s3-0005p1-2i; Tue, 05 Feb 2019 19:59:03 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr6rz-0005nn-NU
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 19:59:01 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gr6rx-00072Q-Ok; Tue, 05 Feb 2019 20:58:57 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gr6rx-0003cL-9u; Tue, 05 Feb 2019 20:58:57 +0100
Date: Tue, 5 Feb 2019 20:58:57 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Roman Rozman <rozmanro@gmail.com>
Subject: Re: I2C bus locked: marvell mv64xxx i2c controller driver
Message-ID: <20190205195857.oadxiswya5wq5hca@pengutronix.de>
References: <CAEHvULnPFtCK9cD3GtFKoZ+OHaqN1ZJMmPxK+OPnYqhptk8t7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEHvULnPFtCK9cD3GtFKoZ+OHaqN1ZJMmPxK+OPnYqhptk8t7w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_115859_916444_3B09B803 
X-CRM114-Status: GOOD (  14.15  )
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
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cc +=3D linux-i2c

Hello,

On Tue, Feb 05, 2019 at 12:18:05PM +0200, Roman Rozman wrote:
> Having an issue that i know was found many years ago, and there were
> patches along the way for it, but i'm still having an issue.
> =

> I have a SFP connector connected to the switch, the EEprom is fine & read=
able
> ,the connector is working.
> But after i reboot the device from user space,on startup an I2C bus
> locked issue is happening.
> And the EEprom of the i2c device is no longer readable.
> =

> see screen capture during the reboot:
> =

> [ 5.663823] i2c /dev entries driver
> [ 5.852006] usb 1-1: new high-speed USB device number 2 using orion-ehci
> [ 6.058964] usb-storage 1-1:1.0: USB Mass Storage device detected
> [ 6.065221] scsi host0: usb-storage 1-1:1.0
> [ 7.112857] scsi 0:0:0:0: Direct-Access Generic Ultra HS-COMBO 1.98 PQ: 0=
 ANSI: 0
> [ 7.122702] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [ 7.752006] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [ 9.832006] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [ 11.912005] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [ 11.918603] lm75: probe of 1-0048 failed with error -110
> [ 11.925496] orion_wdt: Initial timeout 171 sec
> =

> [ 14.472004] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
> [ 14.478563] sfp sfp: failed to read EEPROM: -110
> =

> I read regarding the known "possible solution" that the master should
> send nine clock pulses((SDA) is stuck LOW). And the device that held
> the bus LOW should release it sometime within those nine clocks.
> =

> My question is there any GENERIC way to do that for the mv64xxx driver?
> Or maybe there is some other solution for this.

The relevant keyword here is "recovery". The i2c core has some helper
functions that make it easy to reset the bus if your pins can be driven
using a gpio functionality. See i2c_generic_scl_recovery() in
drivers/i2c/i2c-core-base.c.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
