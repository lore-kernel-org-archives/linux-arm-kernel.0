Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C227C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:27:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85B621841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="loN8taUe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="exzbMQc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85B621841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vHVxrLWqf19rm6Q6clcJ3CpOSvETlpegh4gcxWRRBk0=; b=loN8taUe5TJ9md
	WKqgUHZ40wnc/ddfxMHviFRbfTCyK+2xI+sDRqWbJtHbg5xqH3IJZT0nEvFYxCnFn59rlLlquhGIO
	zYfPe22FVtl/qEvVOEn4xwU4HnL4dWGDyxht3iSHrxdIwbkdvdPOsjSXbrLTqLXMVZuBzFQDdtjkF
	FAnowCO++/V2iLKTFI6tDwupohjGkWRCW4PTkCBZpFn9LcwpBHj+aU4rKq38xgXtwGnlnidHqqN4x
	2183SilKvb3PDtKah0fE6CGdyXLUMHLjf8LEDsp2ASY+M3IOjgz2d8m9l99fBwGBdoLx+TCYZv6Mp
	gCGORRX8Fv76oxHyXNQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsGU6-0005yT-GQ; Sat, 09 Feb 2019 00:27:06 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsGU2-0005xD-Es; Sat, 09 Feb 2019 00:27:03 +0000
Received: by mail-wm1-x342.google.com with SMTP id a62so6311860wmh.4;
 Fri, 08 Feb 2019 16:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+y+hAziG5tjn4LBMnYeVXn/bTW2Hr2II1wyF7dPTcF4=;
 b=exzbMQc2W2jvOU2m/TvAgVFlPkdL/CIYPIWIMomOJUjlnyd+IBjNGtHNnhdlsi8Z7O
 IVAAZkodIaxMV/gZUFzK3GCF+ZoE+O1sVBlr4EkQAa/PeSc7/YDww/ibrBIiCi7hoMeU
 F/2ShwNuwXUqdhOLQvew9285f/lev0e+/OAwNXwalEIcc33JZuG5Jr0wgqr5f/kKZTAU
 Mainhz9jEcOjZB4fZt1eleUub6/+L99bgfE8huH+xIqqzCVgDH8EHOCVP0aN5tZkE+Ie
 kxnhO3LcIaNUS3gX11jfqK3Ymrc4SVxULks6F///1fdKMn+W1S/LVhnpkN1zJgKewR4B
 JsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+y+hAziG5tjn4LBMnYeVXn/bTW2Hr2II1wyF7dPTcF4=;
 b=VVQmS8Svhrn04t036QnpeQQ+cyPRZfBi3D7UADRhTvvhbBZ8UYCttifQVvmjVzsQQG
 zXmOTpSG72rbMd7/3Thk1TyWf0aVu6zdrINdw8otrsckvH8doDe++AQocMVtiPHO0N5v
 FvCBDq7/9zhizkTxImCNicCeyNoVRBq6FHy7iHEDY8UMaTk32tELYq3zenOegIUxceuW
 vAxZ9ac6vATfTmQe7chCmEs5+8IRhZV//qcImcxiAnnkKOdAdqvVUZVnuwahlm82gmb1
 v6CqUc9/g0tKBPe3P8ixTIN8WpwZd8a34EIME50nOqlH7cpXzKZB+Thi5ulWBnbBoEz+
 l5ow==
X-Gm-Message-State: AHQUAuZBdIXu5J8ez3Fpf5xKPL2sq6tjrkSZZZgmoyysdc3qVr2PpRAR
 glsKRTRKmag//wP0CPpZOG/ngMmY
X-Google-Smtp-Source: AHgI3IaaVdnmTQHaB51uwU+iqkrmy/O7M46PCKgsr9lgCYyqThznOKbMhIj+vGVE507e5grU4nB8Hg==
X-Received: by 2002:a1c:5a42:: with SMTP id o63mr811345wmb.88.1549672020701;
 Fri, 08 Feb 2019 16:27:00 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD70B4600C545FEF64E1C6C81.dip0.t-ipconnect.de.
 [2003:dc:d70b:4600:c545:fef6:4e1c:6c81])
 by smtp.googlemail.com with ESMTPSA id a12sm6569066wro.18.2019.02.08.16.26.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 16:26:59 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 0/2] ARM: dts: add the clock measurer on Meson8/Meson8b
Date: Sat,  9 Feb 2019 01:26:39 +0100
Message-Id: <20190209002641.9105-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_162702_503104_99BEC085 
X-CRM114-Status: UNSURE (   7.70  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The 32-bit Amlogic Meson SoCs also have a "clock measurer", just like
the newer 64-bit ones.

Add the node of the clock measurer to meson8.dtsi and meson8b.dtsi
so we can see the measured clock frequencies in:
/sys/kernel/debug/meson-clk-msr/


Martin Blumenstingl (2):
  ARM: dts: meson8: add the internal clock measurer
  ARM: dts: meson8b: add the internal clock measurer

 arch/arm/boot/dts/meson8.dtsi  | 5 +++++
 arch/arm/boot/dts/meson8b.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
