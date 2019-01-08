Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B472C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:04:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6A820700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DAiuT2ao";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="IWRPiJzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6A820700
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oKEPjAXPzAbFZs9DISytH4i49Fhxt7AFkOt+5uXfn0M=; b=DAiuT2aoLMGyAa
	SfoxBW52tCF15/fDtcw6ifs8wJL3LTICNMfZKEEU71YBSO5U6gc39aYu8p9o/OTZnEGjuF2FPRViA
	fenyZtIrgZr2cXOB6B6rvvMUMH83MMjALGgJ8xouD6CcXOfCghoHWsF1iimKl1b9camNj3PgwKqGD
	JH9AgxDb/dQnRiNgI6/bL8nxz3hJBp+c0TpmVLMv9oaDjdBTTjGVMimLt0TX0PMdngM+lQvy7af2v
	dBAH8bDRKqjm1RV1D9+L5qzlIp68U3y2NYYhW1EM8zMdhGgJUbiQ8mY6myHmLNuT3ZBN4lZgQyY3c
	n6M+E+Wj8Ba/zcInjC3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggkUm-0007It-Sh; Tue, 08 Jan 2019 06:04:12 +0000
Received: from ni.piap.pl ([195.187.100.4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggkUi-0007Hd-Rk
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 06:04:10 +0000
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ni.piap.pl (Postfix) with ESMTPSA id 3EA33443165;
 Tue,  8 Jan 2019 07:03:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 3EA33443165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
 t=1546927437; bh=/a+fZV4LEXWJGBv9TW3VNKi/vmQ1PNr7F62p1j0LRIE=;
 h=From:To:Cc:Subject:Date:From;
 b=IWRPiJztPsyLfoyH8zcU6K3ukibSF2zi8IHaYaP5Glr1H0+RNxpj7xjBC8DGUcD3T
 RfrWIXGbx6dE+KEJBfA+bvwckHEZ8r1+nDrAihVqkXisy0yNjzCVZRX3OZ0YQjbHnl
 rNvnHfVybndmLwekR0pMH1ojFRTQWAkctfR464ys=
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: i.MX6: EPIT timer as a clock for an external device?
Date: Tue, 08 Jan 2019 07:03:55 +0100
Message-ID: <m3h8ejfzxw.fsf@t19.piap.pl>
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 133775 [Jan 08 2019]
X-KLMS-AntiSpam-Version: 5.8.3.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 232 232
 27ac0ce265d8cfe64c397d431e1d2387c92c9415, {Tracking_DKIM, one},
 {Tracking_marketers, sender}, {Tracking_ sender_matches_from},
 Auth:dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2018/12/29 09:49:57
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server,
 version 8.0.1.721, bases: 2019/01/08 00:26:00 #9315795
X-KLMS-AntiVirus-Status: Clean, skipped
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_220409_232190_8DFCD6DA 
X-CRM114-Status: UNSURE (   8.33  )
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
Cc: Colin Didier <colin.didier@devialet.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Peron <clement.peron@devialet.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

I'm using an i.MX6 design with the CCM_CLKO1 / EPIT1_OUT / GPIO1_IO00
pad used as a clock for an external device. I can't use the CLKO1
function which is basically fixed at 24 MHz, I need much slower clock
(below 2 MHz). I have verified EPIT1 can provide it for me on this pad
by using the IPG (peripheral clock) with a specific divider.

I think there is no software support for such setup at this time. The
question is, how should it be done? Should I add the relevant code to
the drivers/clk/imx/ infrastructure? What about the upcoming EPIT timer
driver?
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
