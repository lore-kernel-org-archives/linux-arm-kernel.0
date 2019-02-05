Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2768EC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:58:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A692083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WCwfjdCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A692083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uChVzX/ZAQBY+16gbNyqOqK76N5Q77MHn+/FoXGR9Y4=; b=WCwfjdCTwRx/Fo
	q85N9jUZITIYm7EaVHYs96FKsvzRly36gOlYdGp3uOtag3c5Hmk3FnFSbav7qi85KE2/357dHPP9e
	+Z3/tzcbCQMkRIqxayyb9AXObFwwVTTrJ9BhIPGG7PCXO9meQowkQ2eZmHeZyAlasEBjKSHuZmlLa
	/+3j1mkEu3V4/HHNgcWhXyKSbmT9orVcbtE6YPvmNvBh1Htp31V/pru+Uab3n7t/H9BkY55vx1XZ+
	ktp7XmKmKI+6rAtDYU8YKhssFf6Qd5qPv6QFM/spESn9VtaPrl0HD0Vnz/XEVHzIOV4BnQvT+Mosn
	p6XXXQLt0ty46xqIiV6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr6qx-0005Qh-Ft; Tue, 05 Feb 2019 19:57:55 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr6qt-0005Q1-8f
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 19:57:53 +0000
Received: from oxbaltgw37.schlund.de ([172.19.246.45]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MEFjJ-1h0hks3QaT-00AGgD; Tue, 05 Feb 2019 20:57:39 +0100
Date: Tue, 5 Feb 2019 20:57:39 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: netdev@vger.kernel.org
Message-ID: <71485139.238913.1549396659042@email.ionos.de>
In-Reply-To: <958035754.310420.1546378307673@email.ionos.de>
References: <1082628525.187562.1546041777025@email.ionos.de>
 <86efa0brfx.wl-marc.zyngier@arm.com>
 <BN6PR1101MB21305BBBB3F617C9C49141E4E7B10@BN6PR1101MB2130.namprd11.prod.outlook.com>
 <958035754.310420.1546378307673@email.ionos.de>
Subject: RE: lan78xx: WARNING: irq 79 handler enabled interrupts
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:ncgfMOVpDDwiGRQ++N4Pk3GQU8bsakSZ8ym1TbnFVhKNasZ1VvQ
 I16ynuaY1vyV/z+fUYDNvAZrY117lYiWxIAm/iF++vHpKb3nHgZrtTrwnnRp4qhrLqwNdEl
 g5UBgOC2hTzL8W5TT4p1/B1xt1dPf2y15jgBXDlliq95GHv3FoHHIHywVwojUZB1t9fl6fM
 gakILfu7UYhIbwUXnLe0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0demJO31Jss=:28U538ruA07j7hm5FR4Qq9
 /jBVYYZIiZJrj4zj3rOjCsB0dQbD3Gap+iqKPZX9amaXcxHm5aBjEZjzTwudyo+Y+Hx2lN3kj
 CsgzsbZuwGhY7GfTGUONPtPzbEj756mRKPBy1JenKB7MH8tgj7l6zez9P7vg0ZhIznA+mrQLO
 he+lCBjg0+oiujPQMZX9cMPopMKkMGWR92cGPM28PqTMqNK1irknQcGqYsr09nAPgucXjuCH/
 WCmc5s0XcePgawnGK2zM3ojFq91wF1fk2LND+934sFA3XVHIUW3mCgCGjC/w9ZQp057grtoG4
 BD+/zboIMntu93LgZS55ncj9+zI3czBBP8XI9hHeTBmk0nSuezoS7gEQX014X1fZDNuE4PYJU
 xW4qngKcnaUhW6igP7Ck9LOA3ZKCew5LuQ1WFgndVIbE619Gdyo+xmNJ4Lh9mHQxQOEOKPr84
 vH7+pAQ4+jQ/1+O8tAH1qwGIETm18Sw4qGeu+1YM5FIFN/RKKc4+whyDCl/2Zgrb5qy78GwFX
 Mun45rhwWX/0Ke+h7fCFhM4diCQ2kq1kax/ePnRgwiOmwcKgAXSwGwlfpDpl/UfiV1ZTSmw6e
 Quid6M7UKKc7RlLARv7M2/uuocbWvlkjYtAOkTUOKfYgacWgd9049rvY7aKb1+RQpEoTvviUw
 qHhHHkxSQPl3vy+ggGTS4U6BMUXMAHA82MGhU3U0UsXyABEfuhMAyeM2kqtpgEUYvDb1vdvZ8
 yEmpk5njAubiElrAdBMDsKNuK0KKSDmGX+e/P0uQC9SsYfroSBVJZQH85YE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_115751_608175_D298760C 
X-CRM114-Status: GOOD (  15.17  )
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
Cc: marc.zyngier@arm.com, eric@anholt.net, Woojung.Huh@microchip.com,
 linux-arm-kernel@lists.infradead.org, UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 1. Januar 2019 um 22:31 geschrieben:
> 
> 
> Hi Woojung,
> 
> > Woojung.Huh@microchip.com hat am 30. Dezember 2018 um 04:25 geschrieben:
> > 
> > 
> > HI Marc & Stephen,
> > 
> > Most of engineers are out until New Year's Day.
> 
> thanks. I didn't expect a reply that fast.
> 
> >  
> > LAN78xx driver uses irq_domain for phy interrupt, but smsc95xx uses polling.
> > Need to check flow again, you can try that comment out "lan78xx_setup_irq_domain" to
> > make dev->domain_data.phyirq = 0 which forces PHY polling.
> 
> I tested your suggestion with multi_v7_defconfig (32 bit) and arm64/defconfig.
> The warning disappeared and Ethernet is still working.
> 
> Only the old issue that we can't receive until a first packet has been send out reappear. But this should be manageable.
> 

i got informed that the engineers are busy with other issues and come back later to this :-(

Since i'm getting requests to provide my PHY polling patch, here it is:

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index e96bc0c..a5bb292 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2982,13 +2982,6 @@ static int lan78xx_bind(struct lan78xx_net *dev, struct usb_interface *intf)
 
 	dev->net->hw_features = dev->net->features;
 
-	ret = lan78xx_setup_irq_domain(dev);
-	if (ret < 0) {
-		netdev_warn(dev->net,
-			    "lan78xx_setup_irq_domain() failed : %d", ret);
-		goto out1;
-	}
-
 	dev->net->hard_header_len += TX_OVERHEAD;
 	dev->hard_mtu = dev->net->mtu + dev->net->hard_header_len;
 
@@ -2996,13 +2989,13 @@ static int lan78xx_bind(struct lan78xx_net *dev, struct usb_interface *intf)
 	ret = lan78xx_reset(dev);
 	if (ret) {
 		netdev_warn(dev->net, "Registers INIT FAILED....");
-		goto out2;
+		goto out1;
 	}
 
 	ret = lan78xx_mdio_init(dev);
 	if (ret) {
 		netdev_warn(dev->net, "MDIO INIT FAILED.....");
-		goto out2;
+		goto out1;
 	}
 
 	dev->net->flags |= IFF_MULTICAST;
@@ -3011,9 +3004,6 @@ static int lan78xx_bind(struct lan78xx_net *dev, struct usb_interface *intf)
 
 	return ret;
 
-out2:
-	lan78xx_remove_irq_domain(dev);
-
 out1:
 	netdev_warn(dev->net, "Bind routine FAILED");
 	cancel_work_sync(&pdata->set_multicast);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
