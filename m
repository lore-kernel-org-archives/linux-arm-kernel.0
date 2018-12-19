Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BA1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715C5218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s8F0hqfm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMHg0kdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715C5218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=nHho0qL958X88tcXXuHA7ptAxloeR8aMpat7WVK1bjQ=; b=s8F
	0hqfm9LpIHanhrcOPn6Yj2Gsa2q0Xbx29fIgfQEg5YsewKrjBYrYNHsIA9kWGJRCSWuGQ12Us5ePw
	s2HiYOP12NTKVj5Oe/ZwKKtw54uLuK8sz+GLtVw/0e8of8w467I8ud2CCP7tBE7npDREHfmIC+tdi
	T3B4V+8V2P9C62Jvdig2QQJM9IqnHBUKftQbx+Sqfjmmq8UHWtfNqUJUI/qw8gj0OMDlNiK/T1eNi
	rUgg79iVBTn4RiBZq7ZMyOOZHwYINgC5y4FXFypIGGGlXqVFB/d6GjdDinX4EvhATGRew1p6deQjt
	+xSfam8/LTn4yDZXdJ+7FWQ3zO175Uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZeDC-0005QX-18; Wed, 19 Dec 2018 15:56:42 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeD7-0005Nd-IY; Wed, 19 Dec 2018 15:56:39 +0000
Received: by mail-wr1-x443.google.com with SMTP id p4so20035840wrt.7;
 Wed, 19 Dec 2018 07:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=MV+oFm4yA8y8FEtoATe0D53mseGlNWfcGlDfAub8P48=;
 b=oMHg0kdAErhUNdCUq+7umvuHdYqnusvyfwtEanSy6wXNKRQ4CP6P3vorViCa6E4e5l
 Yp/ulV60hM37Odi2XdPEBZjjnWxb1+hprYBS0seiZG4z1bIvj0nYk+xOCxuAo6erB0s2
 4zerz+r0veN4i0a0dFgLo52b8YIMTDgUmucnlcSj7ET5ShFpOMSv339wIf0CoAXTqm52
 NboM6vesgvxvT/spA3NDmeMuYRpY4idLC2vevwNLp1xB2YSX0pf9MUj0FX/QMPw2tTCm
 fQBc8RG/eQ4dEQwz6GIZ57g7lQwNecJ8JZPedsMNuSd0/uNjJ37EUNYTRO9RZ92+yiZY
 82WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=MV+oFm4yA8y8FEtoATe0D53mseGlNWfcGlDfAub8P48=;
 b=Fy+ermBrpn+btFCVF2ejzyY+dPBFuQeM2UWfbYX15M5c0ydCGpR4YtxSKpdV8lsiQ2
 VhCrt9JuJ91M7iJr+96r4tliqm1RILibd+Kqy3fFKr3DuW8eH6pX+ex0jrScgIPQYi4Y
 Cnt0sZPIMShkQXCav9q+pv83N3YRmsqbKqVTfSi4j/O3RpbjmXrdPWhGCvGs/39AWmjE
 gT/Qqzh0Zv1YNhhWGXBAojVziHHCuxNJbrNFsS+O5L/h17IUQ/iUVXiCqe355Ff2acES
 akMFFSx10WsgNlhK8+OvmHjISynfRKlpZ+4Xu4TrQitOkWV4YgpBzWl2hmI7ej8AwIYQ
 M2Lg==
X-Gm-Message-State: AA+aEWYqxPXDzRRdq+2HyK3C/Per2xMh4pIRzqvDK0HVjwTTHDxhQo/Q
 jpXhOzGI3pA5bVmAEcWX3go=
X-Google-Smtp-Source: AFSGD/V9t72oPZn3EwoWwcx+9tUVuayglwlMgO8Ft/5HO5e2+NZsh1MOzdsoqUPJFM06T+ZQh+tDsA==
X-Received: by 2002:adf:900f:: with SMTP id h15mr19015440wrh.18.1545234985104; 
 Wed, 19 Dec 2018 07:56:25 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
 by smtp.gmail.com with ESMTPSA id c9sm6836099wmh.27.2018.12.19.07.56.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 07:56:24 -0800 (PST)
From: Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To: starnight@g.ncu.edu.tw,
	jiri@resnulli.us,
	afaerber@suse.de
Subject: [PATCH RFC lora-next 0/4] Get sx1301 to transmit lora packets
Date: Wed, 19 Dec 2018 15:56:12 +0000
Message-Id: <20181219155616.9547-1-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_075637_610059_F4B23634 
X-CRM114-Status: UNSURE (   7.51  )
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
Cc: netdev@vger.kernel.org, Ben Whitten <ben.whitten@lairdtech.com>,
 linux-lpwan@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

If we ignore the first commit here which corrects style issues this
series gets the AGC firmware running then implements framing over
the lora socket to get the metadata the concentrator needs to send
a lora packet.

It could be that we need two protocals in the lora protocal family,
one raw and used for node devices, and one with framing and used in
gateways.
But it depends if node devices need information from the LoRaWAN
layer such as spreading factor and coding rate to initiate a
transmission.

I tested this with a tx_test userspace application [1] to adjust
bandwidth.

[1] https://github.com/BWhitten/lora-modules/blob/master/tx_test.c

Ben Whitten (4):
  net: lora: sx125x sx1301: correct style warnings
  net: lora: sx1301: add minimal to get AGC working prior to tx work
  net: lora: sx1301: add minimal to get transmission out
  net: lora: sx1301: introduce a lora frame for packet metadata

 drivers/net/lora/dev.c    |   2 -
 drivers/net/lora/sx125x.c |  20 +-
 drivers/net/lora/sx1301.c | 529 ++++++++++++++++++++++++++++++++++++--
 drivers/net/lora/sx1301.h |  44 +++-
 include/uapi/linux/lora.h |  46 ++++
 5 files changed, 602 insertions(+), 39 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
