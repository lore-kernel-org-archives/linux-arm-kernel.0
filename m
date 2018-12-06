Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF527C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:32:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B30120892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TouQ5cxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B30120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=F6IEawwJwtZYqanFtZWvzEm0v1/iZEV0aVOBP8OFxjo=; b=TouQ5cxPKCCBLIm6VlQK9Punu9
	6EFXMyaxnw0vrflA1POu4fqWAO6XeYfZ3nyZ6xp623Niq1s40h0zhbjBkQmebDxSFZmEoGOriQMhI
	Hzk683qoIMMRzcqwt3JpsCfYQmm056mKVyPK4yT1QZ4/FNXVvuOrCEVWWE39FgsM+OW0qLyVb/npm
	GDN4LLMtCEKL/QtrSoD+OsUAna5s1JNEvq6LawannQkDQAH+dF9bc5Jxv4TrKnNHx3r8vKiRaFSCL
	IUQLPdtYpBIq6psL7BF8eMAMkkiG8Ah/jUYhAy6emjyqt9mIR3GZNzRJOlCjRRx5LunOpKOENpKgQ
	oEaKVtKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyRW-0000AS-8k; Thu, 06 Dec 2018 18:32:10 +0000
Received: from mout.kundenserver.de ([212.227.126.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyOx-0004ow-IB
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:29:35 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MW9zm-1gy1Yi0U8I-00XZQ4; Thu, 06 Dec 2018 19:29:10 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 10/10] staging: bcm2835-camera: Add hint about possible faulty
 config
Date: Thu,  6 Dec 2018 19:29:00 +0100
Message-Id: <1544120940-13716-11-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
References: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:bFbhHBlh0Cu3o2Sb1PomtWj0Qs6eFQK8I4iv9TBUzu/EazXbwBS
 2KhcS/EPgxlxTIACQuJVYPora4jPQ4V8GvMqbf7ggSI7G/1kZHlyYs7TZKAGgbBnKfQHq0p
 L2/E+TGoIxv3zU9b92d5E5d7hCo3r5/Dte3df28UNG0VxYJ4mfcUZXTfpl0WSPNM/vV67X0
 2snQbyBT+A0McVIg0cahA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:orSZP+W48ac=:nADR6WKxBEDTXHFzLVWBHV
 Nb3AttcR7Ol8b4ngUHD8ssYECY49EyyVD9yarYqXn7o0lHDqPNl9F2ouL/W4K4d8zTprsQq5H
 Gr15uameq6Korbeee8GXj3XJ5Bs+twT2QE+oSeuK7vjwQsmDVl1+qujM3+6ru3nE/ZdZeCPcf
 JB3MOBcOgai03QaT4uq42y10/cE0akFPoP3+xXSejs/Pylx4VKehuLwNlrFG4mQfwCMPjlEn9
 djdPOb4+m6cfhpMJIKu3E+Dm9FgT/vgxHa4Rkg16GKtWyb4Mtyf68ncQ39yQqaIpRdmoGPIvv
 Vb6f6p6wPT1yHm+K2sNh8n+airn7mNhgFgXs/LImW1pce9ucehEFz+fwqRl+Iim4vsYyXsw+H
 YC4dX7MRU1I3q7TLix58h/5HlmP/l0aG1tk5GTA4c07EOFD55p/PAtOKwXU7OquFKtc9PS/iI
 0bEtR/zXS/eAbyWJGV0P1zb54+6yKa+twgeKxTGl/L7JYiNQ8ArV9wETUBL6iI1rC3O2J4JCD
 KrZvPYYCXdXhnZSfe1VVK+5ui5awcp+hhSeS9SZhnijrcfAx6Rau15kFGDbGeAGFOM02oNNCW
 lg1rigXjiKWTcVo4wDIIzGW5QkPtQCbhpAuo+R1YKM+D/tTwFdEygEIwIBH5LQPcybkaywAwu
 glCFkrrPWfNxCsROsl3QhsmVYcumyVAYFxmMlJ2GXIUPfJGfAxKYVJOQz4HzBnEVXLpLUXe6w
 WW4NxD+K1lTKBwi65R9hTQeaLacwP5x196ZyGoIqaye6N6wg6J2Y+bqDijI=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102931_897316_B93ACF27 
X-CRM114-Status: GOOD (  13.20  )
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
Cc: devel@driverdev.osuosl.org, Stefan Wahren <stefan.wahren@i2se.com>,
 Takashi Iwai <tiwai@suse.de>, Eric Anholt <eric@anholt.net>,
 linux-arm-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As per default the GPU memory config of the Raspberry Pi isn't sufficient
for the camera usage. Even worse the bcm2835 camera driver doesn't provide a
helpful error message in this case. So let's add a hint to point the user
to the likely cause.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index cc2d993..bffd75d 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -1623,8 +1623,11 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 	component = &instance->component[instance->component_idx];
 
 	ret = create_component(instance, component, name);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_err("%s: failed to create component %d (Not enough GPU mem?)\n",
+		       __func__, ret);
 		goto unlock;
+	}
 
 	/* ports info needs gathering */
 	component->control.type = MMAL_PORT_TYPE_CONTROL;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
