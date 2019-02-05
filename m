Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69B5C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:18:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31CE2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LiNt0Jep";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULMvEypi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31CE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=KTMdc3NygcVv2VtCh1R88wXwJeTBI5P/Fdz4PHzSNqM=; b=LiN
	t0JepCFjYUd5m/Q75xdOyuopPJ+c5YSy53Qve0tihb/Ra4w2Dn/ZkickcgNw71ANaLEEOMqgLeD24
	rSXi/Eoq2uXvRwhAlUW0CwMkzTVO32eXbQRwZHVCCZ/tErxz4Z2BiC0pQ3H6AWRAMx494q6CuWP3m
	JtBaq7qcVk1kaaFjsRfzo6wq5Ol+2tVVnh4Lrz1vyLC0qVfyvamp/KTlj3rBU+i+yV77Q/X9YeNW7
	QiqLRKpcGVW95IJEuUnnwcqjjLMaCM7CcKPTW+IXrPCNRChzy//g3jsB6YiNQbrj1pzZe9T7fvbrc
	SovM5FRzN6RXEbFvq0tiGI7RgMRUkOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxo4-0003No-Bt; Tue, 05 Feb 2019 10:18:20 +0000
Received: from mail-it1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxo1-0003NX-Jx
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 10:18:19 +0000
Received: by mail-it1-x12f.google.com with SMTP id a6so6804806itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 02:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ydQY5hwpOhSZ+Kk1uERSjvhMsPHc/RfjVbaD335EnuI=;
 b=ULMvEypiZn6uxohydKg23NpenE2OtOZJLjS9vmdNSwDQteFZeVdE1xWh8s28uVg1vc
 Jp0Lmv24gp/tYPQOXeILYqqrPibae662N8VvUYB8pBazbhjKdOA5OxAfMBCUM7S3G4lL
 Fl+dQMkEEfEX00Df0Ojp3k+KzzirbtX1LCPl4EaN+fzy6Gv8DBw9nJCv0CsubKXIEpVZ
 APKsQp0Ll+tNIOYiCN3F/lH3GWjdn+hFPxmByzYGbKXuMNiuOMr1jCefQ1+7J3edCpWD
 ZQIGKUUEJ6x6UxBjMlKl3yWD8pY4CaVbT3GGNWEbvEK++Bx3oo5169BXemqBSM8pLLsa
 odNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ydQY5hwpOhSZ+Kk1uERSjvhMsPHc/RfjVbaD335EnuI=;
 b=MeE0k9fbivA7aLyPPg0XoFwilTO1eWp/K3ItLsOQEBXaYxCPkUmfnZHUuhbtFTjuOW
 QTAdkrBh8Qn9nSR5PjZbC784KKfloQdF1Qm8APogoGBTaC0zZid1PkvfSrUnePhndnkR
 ggZQoxedKzIcpREivuEs5OvvrpusLPapSjNoCIXc2PI3KhebHvP21lWNWxnrfWkwmQYc
 lcFV+DRdQShx3cWwwvlKk8n/XjYB+hOSiXEDXosb4cRpd+96sHZl9H10QqDzzUT7kuL2
 cAyIufAJNlybeU9nuGCWz0dpEbGe4pVzJJKwCWby5vsaPJrZUAeh9jXz2+wfzxsqDYp7
 l2GQ==
X-Gm-Message-State: AHQUAuYMIHggkeZBOfsj0tEnAJEZMZpIKF5WETpG6FakyOJew+XZsqP7
 bvHv2KdvWGdnORw2RDLB6hzAL86KpTAVzYoRUlydqiPYGDM=
X-Google-Smtp-Source: AHgI3Ib1Z4ZcMBz3PEm2ZZfSnA0NlEw00eoPCEKjl9jzc4MGk16ZDs9LHO0Ku00REi1wEW1FQw2lFfudfjPrYmHYhec=
X-Received: by 2002:a24:a507:: with SMTP id k7mr1931627itf.98.1549361896111;
 Tue, 05 Feb 2019 02:18:16 -0800 (PST)
MIME-Version: 1.0
From: Roman Rozman <rozmanro@gmail.com>
Date: Tue, 5 Feb 2019 12:18:05 +0200
Message-ID: <CAEHvULnPFtCK9cD3GtFKoZ+OHaqN1ZJMmPxK+OPnYqhptk8t7w@mail.gmail.com>
Subject: I2C bus locked: marvell mv64xxx i2c controller driver
To: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_021817_708387_E15CD4C5 
X-CRM114-Status: UNSURE (   8.05  )
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

Hi all,

Having an issue that i know was found many years ago, and there were
patches along the way for it, but i'm still having an issue.

I have a SFP connector connected to the switch, the EEprom is fine & readable
,the connector is working.
But after i reboot the device from user space,on startup an I2C bus
locked issue is happening.
And the EEprom of the i2c device is no longer readable.

see screen capture during the reboot:

[ 5.663823] i2c /dev entries driver
[ 5.852006] usb 1-1: new high-speed USB device number 2 using orion-ehci
[ 6.058964] usb-storage 1-1:1.0: USB Mass Storage device detected
[ 6.065221] scsi host0: usb-storage 1-1:1.0
[ 7.112857] scsi 0:0:0:0: Direct-Access Generic Ultra HS-COMBO 1.98
PQ: 0 ANSI: 0
[ 7.122702] sd 0:0:0:0: [sda] Attached SCSI removable disk
[ 7.752006] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
[ 9.832006] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
[ 11.912005] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
[ 11.918603] lm75: probe of 1-0048 failed with error -110
[ 11.925496] orion_wdt: Initial timeout 171 sec

[ 14.472004] i2c i2c-1: mv64xxx: I2C bus locked, block: 1, time_left: 0
[ 14.478563] sfp sfp: failed to read EEPROM: -110


I read regarding the known "possible solution" that the master should
send nine clock pulses((SDA) is stuck LOW). And the device that held
the bus LOW should release it sometime within those nine clocks.

My question is there any GENERIC way to do that for the mv64xxx driver?
Or maybe there is some other solution for this.

Thanks in advance.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
