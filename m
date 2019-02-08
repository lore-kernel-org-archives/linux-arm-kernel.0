Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAFCC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:25:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5DA2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JnWpNiFd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=integrasources.com header.i=@integrasources.com header.b="XrHQ24S9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5DA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=integrasources.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-ID:Date:MIME-Version:Subject:To:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z98Ag2XS8VmepXsFMXsrFsfRs+2oBVU2b7xTbgNM1S8=; b=JnWpNiFdSUwUyy
	wsbc+P8jSEzpKpnAZQDVv2vvg7CN5OW9brdOYpwmyjV4oLO5LO1mjLJpcglgg/DHOWSKhQ2T8OddP
	1vyKtXEsQUDMF83v8ujXeTIFTUnkSStVwHZ7/p66EJh54ohSHEXvfgDihB8vdmsf+NS+ylo/CBpJJ
	JlpLLVHAx+BywB5b+xJy1q5JtxOANqBehIb+9iuODCYp2gd+dEn4uQBVrKByBW+D1r1mE/fVXDzb5
	EPTS1+M/f5g2wrCDrU+OB7ldf4+cSHjq0xvEmzMYq6W+lI5ASH3Gk8fPVs1ZT1n0kqxJ2nOEeR+Ww
	r21fPLf4Lt+MCzJQrZag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5Dk-00071g-C5; Fri, 08 Feb 2019 12:25:28 +0000
Received: from f417.i.mail.ru ([185.5.136.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5Db-0006Ro-CH
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:25:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=integrasources.com; s=mailru; 
 h=References:In-Reply-To:Content-Transfer-Encoding:Content-Type:Message-ID:Reply-To:Date:MIME-Version:Subject:Cc:To:From;
 bh=N3gKPYOli0yEJ5MvrzjchIUIipmf5htolGRIja7BS3k=; 
 b=XrHQ24S9p3EECrx/xPxIvOS9CxP/St+uW9KezXAwuMPyudzIl5Py1JmQZfWzJbMfFubc9yOHYsLTNirOyYQRJSB8baOa0VYRplIpZs9zOzrwmkgsMCPRO/snLtJ2aOSnEif0PcXPMwflg3hbvMy0QojylRRdDemkCVhgtWnQOGs=;
Received: by f417.i.mail.ru with local (envelope-from
 <k.sudakov@integrasources.com>)
 id 1gs5CX-0007GY-25; Fri, 08 Feb 2019 15:24:13 +0300
Received: by e.mail.ru with HTTP;
	Fri, 08 Feb 2019 15:24:12 +0300
From: =?UTF-8?B?S29uc3RhbnRpbiBTdWRha292?= <k.sudakov@integrasources.com>
To: =?UTF-8?B?TWF4aW1lIFJpcGFyZA==?= <maxime.ripard@bootlin.com>
Subject: =?UTF-8?B?W1BBVENIIHYyIDkvOV0gZHJtL3BhbmVsOiBBZGQgUm9uYm8gUkIwNzBEMzAg?=
 =?UTF-8?B?cGFuZWw=?=
MIME-Version: 1.0
X-Mailer: Mail.Ru Mailer 1.0
Date: Fri, 08 Feb 2019 15:24:12 +0300
X-Priority: 3 (Normal)
Message-ID: <1549628652.999919948@f417.i.mail.ru>
Authentication-Results: f417.i.mail.ru;
 auth=pass smtp.auth=k.sudakov@integrasources.com
 smtp.mailfrom=k.sudakov@integrasources.com
X-77F55803: E44FDC668C02387C7F9F52485CB584D72AF743E69CD487470AE84837B0FCC917A11DCB768DF822F2BB526D81CBDCFB8E08D917D6130B1AFB
X-7FA49CB5: 70AAF3C13DB70168C09775C1D3CA48CF3F395433950BAD63CEDC9CE4EAAF8441BD4B6F7A4D31EC0B5B47ED7565F4D52D9742502CCDD46D0D2A336C6518635091B2086D80B05047785571747095F342E8C7A0BC55FA0FE5FC3505511532D93C9FF0D1DDE111F6E89A9AE0E22BC9650452389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0ECC8AC47CD0EDEFF8941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C34964A708C60C975A117882F4460429728AD0CFFFB425014E40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE799CA1CBE58F98F4ACAB052749D88E88D75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF572FE522B81756EA3300306258E7E6ABB4E4A6367B16DE6309
X-DMARC-Policy: none
X-Mailru-Sender: AAD8E2226B689FDAB33CC05F77CBC91E889D206E7508094C33F9B4F684FC245B8908BA391AA6219F57BE63593B17739F2C9F54B9DBDCEB51B4873B7769F3E5F805C459423DECFE6322DF1A08BD40178C9DFED97C59FA62B9BC879F90144AC781E4A3161861B40CE50DA7A0AF5A3A8387
X-Mras: OK
X-Spam: undefined
In-Reply-To: <3eff6d6164845eee5636d7451b0fe08b09d1cf07.1549619502.git-series.maxime.ripard@bootlin.com>
References: <cover.23dbbc9b943ff8f36253ac7c617e2eda142b1b69.1549619502.git-series.maxime.ripard@bootlin.com>
 <3eff6d6164845eee5636d7451b0fe08b09d1cf07.1549619502.git-series.maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_042519_929749_9F2CD925 
X-CRM114-Status: UNSURE (   1.07  )
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
Reply-To: =?UTF-8?B?S29uc3RhbnRpbiBTdWRha292?= <k.sudakov@integrasources.com>
Cc: bbrezillon@kernel.org,
 =?UTF-8?B?TWFhcnRlbiBMYW5raG9yc3Q=?= <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?B?UGF1bCBLb2NpYWxrb3dza2k=?= <paul.kocialkowski@bootlin.com>,
 =?UTF-8?B?Q2hlbi1ZdSBUc2Fp?= <wens@csie.org>,
 =?UTF-8?B?U2VhbiBQYXVs?= <seanpaul@chromium.org>,
 =?UTF-8?B?VGhvbWFzIFBldGF6em9uaQ==?= <thomas.petazzoni@bootlin.com>,
 =?UTF-8?B?SmFnYW4gVGVraQ==?= <jagan@openedev.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello, Maxime!

>+mode = drm_mode_duplicate(panel->drm, &default_mode);
>+if (!mode) {
>+DRM_DEV_ERROR(&ctx->dsi->dev,
>+      "Failed to add mode " DRM_MODE_FMT "\n",
>+      DRM_MODE_ARG(mode));
>+return -EINVAL;
>+}

Just small fix: DRM_MODE_ARG(mode) -> DRM_MODE_ARG(&default_mode).
The "mode" variable is NULL, it leads to the UB.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
