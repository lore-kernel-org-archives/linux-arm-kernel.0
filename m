Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BD7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:35:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308B22146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p1ZddeK1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="F6AFswdr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="hPbDvnBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308B22146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=raspberrypi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=q6JVvOlvcoO4eAZMmjOe5zhQp5p5fA9nblGzoY/KsQ8=; b=p1Z
	ddeK1EVFHPwfFJHZAXooHhrPMt5XK6iikVopc2JMBVHmyQK4XEIYghfUT+B8bjOAjg6aMEnfngPN7
	j735ICLl3eUhbkTznrMNP6TDmkgm4Au/ls/08kk1lN5J5gc0vPpYj6WyROf0r9PxgUCS/6qKuQJgg
	stx/T35QtCVhLGRA1GOUrFBwPM/xVemQBiUZErP7bhdSMja7haNqHWMkN4Eodr6ehkcS/zVaaJPky
	hIcYdsnZ08p/NtMj5Leb76ZBnkFPFYUGWiYwfUKcCfGxjgo/5XVZv8Rc9XL2iNzlDpcNK/Oj1gk1W
	UYJ0iQWJwk7OcVR3U3Qq+HQ6rapA45A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghv5i-0002Bc-9z; Fri, 11 Jan 2019 11:35:10 +0000
Received: from mx08-00252a01.pphosted.com ([91.207.212.211])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghv5d-000179-44
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:35:07 +0000
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
 by mx08-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0BBND9H010768
 for <linux-arm-kernel@lists.infradead.org>; Fri, 11 Jan 2019 11:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org;
 h=from : to : cc : subject : date : message-id; s=pp;
 bh=QooJ2+oMCgy72PaxJ/VJWzV3+0zvKgI1mojlS+3lljk=;
 b=F6AFswdrcA4FsoyX0lkW8MA5v26p+s3gM1xvRAnpIap6uAWL8W0IQjtEGc4LjG1SLHsq
 jSPBklsMbjN7T4BPxl7xeSj/720nRsZgpf7IMmwUvwcN0UVI7stz4hgqiQPyp66BqlAz
 bNKFOxtBkIgq+ot7lwqPNR4oIZuuexTXKQesgGdzUdtW07LBh6Xhm32qNCRzffkyQ4Mj
 wNdndriNsDqa+RNIN3vqxbLtDcdmpA9zVDJujljcISZ1mYk+0RdHpTF9byY44WJSrucg
 WtVNyKMJU38Tfyv5OJ/c98Ax56xRShQtVWQLkDq2PlRfYTbHN8lIZbUVREiwnYvK8f9q CA== 
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by mx08-00252a01.pphosted.com with ESMTP id 2ptjuub14g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <linux-arm-kernel@lists.infradead.org>; Fri, 11 Jan 2019 11:34:59 +0000
Received: by mail-wm1-f71.google.com with SMTP id l17so681748wme.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 03:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=QooJ2+oMCgy72PaxJ/VJWzV3+0zvKgI1mojlS+3lljk=;
 b=hPbDvnBbXbE3cVvNDMHOHEDbnPNNPkdP+fS3YDMQzQQ/TvyT10UoVVSTgQfHHPYuA3
 opwKLsFvbfWWnqMw++WHpiFeLg6qC1SWKhbRpQRVY9LL3pPx7Hzrb/B5jMWRJCEfq7vF
 yZQbXbBMCAhVajhTZMCegacbfOfWispPnuruMJ2E+4ORJaA7IHM5hyH3Yzx2vvGZHSSN
 nPwGpGP043+eM8aNMTY6QIpLNPB1PWBmKlPoedUcXU+/vCsoW/FuKP3Twijk0eWWIMRl
 OQ0Kf8omrDYP/NTxC009D3sPw6ias2+PYIWl1+eoTBzkEdUu+xLCZsYRc39dMDpW6eCX
 +lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=QooJ2+oMCgy72PaxJ/VJWzV3+0zvKgI1mojlS+3lljk=;
 b=Fe8krdM2jvjgF/vc+C9xBrdapVozzPYTAtFxPm64OrTBVnehnwb6vWyI8RGLauY74u
 +oFRKiE3UjllR28QFS8lNKdWQoQU2YG7zRbNABm04Z/oXeo3QIXTPhmJjZO3sNILT+Dj
 Vd9Ii+lapGgW/xx+EvqwPljY/g3ZGsvJJJR1vK08R/ObtRYv6a7EyE5DN5xXFG/FHPkm
 C1HwlDZqgfbDoPM3Mcpx4q93YfXC5K9vGOOGZgVo40ibpXVV80soJiCGuIkwUQJzQU52
 fgn2WHO6X5KN7mopCWh38W7r5OvLrnKSPRJydeQiEzrQYQqGUHkklPMNYX+SnRbi/CcO
 E/8w==
X-Gm-Message-State: AJcUukfSdeM+ZtXEMmoupZ23rZveWRHwdkBQVeE9XUN3QI7RhD/FA6jC
 5VMzo6xoFmCMsnM1Tm9tl/QdIimhiuMEJyY286HLTTB7s6EVRodGnSOLeWFGTM8esxKrpQXhTEP
 h2L2eBYJRz8Lr0kGhDNXkzEM07MaademYnvU=
X-Received: by 2002:a1c:c707:: with SMTP id x7mr1905573wmf.120.1547206498170; 
 Fri, 11 Jan 2019 03:34:58 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4yCzUIrfeJCzCcxg7bHe0+0j0incOkO1DWe5lzzTs9nQlhw0ixDKN2baDFK/hkjy6vluMNVQ==
X-Received: by 2002:a1c:c707:: with SMTP id x7mr1905552wmf.120.1547206497889; 
 Fri, 11 Jan 2019 03:34:57 -0800 (PST)
Received: from localhost.localdomain (cust51-dsl50.idnet.net. [212.69.50.51])
 by smtp.gmail.com with ESMTPSA id
 x186sm19403931wmg.41.2019.01.11.03.34.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Jan 2019 03:34:57 -0800 (PST)
From: Phil Elwell <phil@raspberrypi.org>
To: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dominic Braun <inf.braun@fau.de>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq: Fix local event signalling
Date: Fri, 11 Jan 2019 11:34:53 +0000
Message-Id: <1547206493-105303-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-11_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_033505_482078_3C46C9DA 
X-CRM114-Status: GOOD (  18.11  )
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
Cc: Phil Elwell <phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Prior to the recent event reworking (see Fixes), thread synchronisation
was implemented using completions, the worker thread being woken with
a call to complete(). The replacement uses waitqueues, which are more
like condition variables in that the waiting thread is only woken if
the condition is true.

When the VPU signals the ARM, it first sets the event's fired flag to
indicate which event is being signalled, but the places in the
ARM-side code where the worker thread is being woken -
remote_event_signal_local via request_poll - did not do so as it
wasn't previously necessary, and since the armed flag was being
cleared this lead to a deadlock.

Fixes: 852b2876a8a8 ("staging: vchiq: rework remove_event handling")
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 9e17ec6..53f5a1c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -446,6 +446,7 @@ remote_event_wait(wait_queue_head_t *wq, struct remote_event *event)
 static inline void
 remote_event_signal_local(wait_queue_head_t *wq, struct remote_event *event)
 {
+	event->fired = 1;
 	event->armed = 0;
 	wake_up_all(wq);
 }
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
