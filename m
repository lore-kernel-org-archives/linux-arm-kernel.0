Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F541C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:09:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105D920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mcabca+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105D920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:To:From:Message-ID:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4eN23ePn75l/mQjor5azLeB4waVxsr3iN3aNikhP0bY=; b=Mcabca+jnNf6eh
	SLfitbysCeUufF7zyPcHzEGKkPk7biGrnKEK6GGx7VOFwdpt71ZetK5VArr/yW5Zmb1UpfkLep042
	yYZ+EQ3QTri+8wIKkVBk0OTq9QXVA3ODGUad023GepHXKk9wEXFnxtsx8qGlVPgZSkMa/F4M+BCKq
	vt+bYGH6HsqVf2i8LG31fV41FbXSNvsYI168YjYIETW9vsV4zw4ct+D7TIjleuWpWaHut/MwYsy1P
	8wB/s2X17m6W5ppj8tOYISwLxSHI7/jEH6XcsNrDpP5C7+oMDOwPyUGqc+dDSMilFfkT3Qkq4Snfg
	Kub33ZowgLiAbmA1xXhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glyc8-0002zG-Dd; Tue, 22 Jan 2019 16:09:24 +0000
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glyc3-0002yg-WF; Tue, 22 Jan 2019 16:09:21 +0000
Received: from [91.14.89.174] ([91.14.89.174]) by web-mail.gmx.net
 (3c-app-gmx-bs21.server.lan [172.19.170.73]) (via HTTP); Tue, 22 Jan 2019
 17:09:09 +0100
MIME-Version: 1.0
Message-ID: <trinity-76e7f2ce-27ce-4f3b-809f-7da9a35e5210-1548173349245@3c-app-gmx-bs21>
From: "Frank Wunderlich" <frank-w@public-files.de>
To: "Joerg Roedel" <joro@8bytes.org>, "Matthias Brugger"
 <matthias.bgg@gmail.com>, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [BUG] "access dev->iommu_fwspec" cause crash on BPI-R2
Date: Tue, 22 Jan 2019 17:09:09 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:9+allI/Tfg/FrW4dJ6O05+us0VMhCXjjMzGp0AbgDel3cqRAwVOLDM0LicCnx72MNI3em
 yheK5IUr5jrh10PgyP3mL//j6p0+QTJl9y0v/QwIb7ACEqGo19NLkw3S6SVXgFpQSaqgHOLMJKG8
 21PU5eab6tjt5U22k95bjro3XWqFSdkDs25iYRaxAa454tKUFMRnmUDwUvGLe3UyCdCb/tC07PUG
 VL/003DbgjWD2PIU4CrenIBVH/5wA3LnwhO7ujUMfHYU5hxsccM4lZBmFHdD6JGLIyD7fiSXH+IN
 3k=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZXoZnQYyRZM=:pYg39yDcx38Rue5mlj4a8g
 XmeELkoaZDz58eIDwpwf1fWnzaHca5o2JdACup/24mE+48YUzZVS3l2NcuNsb74xkDSu5HfJa
 LCFDiWVbam00Tk9DMgWzER1vlSUazgo9hGQdRRwS+vxzA9OSg6yHhWOh82PBF8oLJ3WBr8lwa
 klUQ0SaPpGSkFT6/KzdLRQvWVr+l/qtRFGuACEzzkWUH4F/yV/6uHRkNjNxUpGgHPzSR5Rxxk
 I1Y42+1gLp0R0evsT0XOkVEVjV7bBaCzD1HjDj4v+FNr82GJOeVathxaCoc+FX+S408VKOAeZ
 9pxwW3mjnyfo16BpxsJX6OSnwlPt2uDgmL3Wfjx0xDbfj1ViimTpLxO1fIaqmsZ3HO02rtCMI
 3B1LMbXZQxiW6H6S6972WtVrGVF7WXQmyZgH1B9OvaK8V544xaXapfGcPUur+qoUzShayuRlo
 PaFJVj0uwKEPd/liwUR755IfTJ7jKoOfAA4xRLPGwfxMjsw8Ih5Xow7DIwjZsX4hi0urxXxvA
 ElfiiBsACHyGZxG8bw2VRbOkD1uFyx76R1QgUWZ19IpvR8IgMLT5XoljqZNZFzlu+gRWlZ5qF
 DAiy660HYGMWs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_080920_330036_9A781285 
X-CRM114-Status: UNSURE (   3.82  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

the following Patch breaks hdmi (at least) on Bananapi R2 (mt7623):

a9bf2eec5a6fc01a0a5250eaf0bf61dfd382a78a "iommu/mediatek: Use helper functions to access dev->iommu_fwspec"

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iommu/mtk_iommu_v1.c?id=a9bf2eec5a6fc01a0a5250eaf0bf61dfd382a78a

[    5.363509] Backtrace:                                                                      
[    5.365946] [<c05a6010>] (mtk_iommu_domain_free) from [<c05a1544>] (iommu_domain_free+0x20/)
[    5.374670]  r4:decd57a0                                                                    
[    5.377192] [<c05a1524>] (iommu_domain_free) from [<c011b85c>] (release_iommu_mapping+0x24/)
[    5.385922] [<c011b838>] (release_iommu_mapping) from [<c011b8cc>] (arm_iommu_release_mappi)
[    5.395943]  r7:00000000 r6:decd5780 r5:00000000 r4:decd57a0                                
[    5.401567] [<c011b89c>] (arm_iommu_release_mapping.part.0) from [<c011cb4c>] (arch_setup_d)
[    5.411412]  r5:00000000 r4:dead1410                                                        
[    5.414968] [<c011ca7c>] (arch_setup_dma_ops) from [<c07d2764>] (of_dma_configure+0x27c/0x3)
[    5.423521]  r6:c0b58e20 r5:00000000 r4:00000000                                            
[    5.428109] [<c07d24e8>] (of_dma_configure) from [<c060a63c>] (platform_dma_configure+0x28/)
[    5.436838]  r10:c107efdc r9:00000000 r8:c10c0008 r7:00000000 r6:c1117b34 r5:dead1410       
[    5.444612]  r4:c1117b30                                                                    
[    5.447131] [<c060a614>] (platform_dma_configure) from [<c06079ec>] (really_probe+0xc4/0x42)
[    5.455602] [<c0607928>] (really_probe) from [<c0607f70>] (driver_probe_device+0x88/0x1e0)  
[    5.463814]  r10:00000000 r9:c060a25c r8:00000000 r7:c1008c48 r6:c107efdc r5:c107efdc       
[    5.471588]  r4:dead1410                                                                    
[    5.474107] [<c0607ee8>] (driver_probe_device) from [<c06081fc>] (__driver_attach+0x134/0x1)
[    5.482663]  r9:c060a25c r8:00000000 r7:c1008c48 r6:c107efdc r5:dead1444 r4:dead1410        
[    5.490358] [<c06080c8>] (__driver_attach) from [<c0605510>] (bus_for_each_dev+0x84/0xc4)   
[    5.498480]  r7:c1008c48 r6:c06080c8 r5:c107efdc r4:00000000                                
[    5.504102] [<c060548c>] (bus_for_each_dev) from [<c0607344>] (driver_attach+0x2c/0x30)     
[    5.512052]  r7:c10bff30 r6:c107fad8 r5:decde780 r4:c107efdc                                
[    5.517675] [<c0607318>] (driver_attach) from [<c0606c68>] (bus_add_driver+0x1d0/0x274)     
[    5.525629] [<c0606a98>] (bus_add_driver) from [<c0608fa8>] (driver_register+0x84/0x118)    
[    5.533666]  r8:c060a20c r7:c0609c60 r6:c10c0230 r5:00000002 r4:c107efdc                    
[    5.540323] [<c0608f24>] (driver_register) from [<c060a538>] (__platform_register_drivers+0)

after reverting it i can boot without crash and start x-server

my repo just for reference (revert not pushed yet): https://github.com/frank-w/BPI-R2-4.14/tree/5.0-hdmi

i hope i had chosen the right way to report this...

regards Frank

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
