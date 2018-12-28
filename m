Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345AEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:19:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0182C20857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pKtB6vMo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgFJH9Gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0182C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zQbjKVFXCUCeS35FGEie4VKsXArkfraiz7XMb9bjKjE=; b=pKtB6vMoQr8G3H
	ywR6N0w6qJN5b2ypxrG6HUt6aYh5DhlRTUz6VXT/1Bm8dMfTEm0rkJuwQJRnqawvJnGIAA6o7/bHU
	9ZmS4iwPd5pU73JPNsBy85VHY3WVf20HbjlK4Cpr9Sb+HlIquHlOQEroik3waKHRJydUL6NAfie6z
	0y57hxzgHBp7R1EClyfs9p+zKmcC+CEydjAGoESS4OUmquaK5jIg3CeMYdS92LFygn37iAC9ewwGH
	KXJuoIlgniIPQs+pTzqA4UIwbyk923BZdLwGqWSxl7evuuLq8RWatCM14Q0hVW0qqsZ1F7CIhuSrB
	TprxLl8j4nQrEdnaA/Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcuqk-0004WK-On; Fri, 28 Dec 2018 16:19:02 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcuqS-0004EU-2w
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 16:18:45 +0000
Received: by mail-lf1-x142.google.com with SMTP id i26so14868716lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 08:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=otuHlPExgvwh1mlMZzgUgoZRtdmzR3U/LJ6rxovEI4k=;
 b=AgFJH9GqPOnlCudwvqJ2wWGD5eaKd7XDH+yUqrlr2uPTSI5ttY9oCeU8/p+waF5VFF
 48pLfKJ5pfMIbTDWFR4YiS0+/Fz4wRADQ4mtNExI6fHQVbcTIvqEKft6W4wHcOeQxhLs
 JeSqO18I/EDm+zHSxYv9pqzTTe/oOSBBbC55NEi9T6cUI/t9jiTBpoZ9jh4zuOCvl8b0
 6vb/S0Xl6n9o3a9jjKZJ9JjbOkQurzuINPPfY4GQ7vX1O+lESmH6covdE/hd181lTwPS
 sTA04vNENZe7dsV9PtygE5IJ2f+49jIufCeEjEH+jloYb6EVKoAdVX9JkJnoc2MWl01A
 muzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=otuHlPExgvwh1mlMZzgUgoZRtdmzR3U/LJ6rxovEI4k=;
 b=ozSKe3IbAPX2k/k5VrnMJXJ5Wc/howEPnhRba/97HT+FrjjnK0iCxKVoUOWx9Nd8gg
 uSqzaLWg//FRoJRYBLqEG3k+NmxFvTcP7Yd8gX/oKQ0vnrHpAGwoF93crij/gsp34OqH
 qLupxhTDT3wWKqUNQYuH8HbtAk1qaIugTgNGvIqm3SjV2zvhJPSOzVftq6EaSBQ0PZU+
 pKJgWsEAxdjfg5PGW3QCiRws9sRtwOYYep5OUzK+zXEpbuDhr1d8MYX2dw3rq7vkDuac
 os6d0mu8QPvS1JSUchSYNNwwprzVGLoYeAz2F7C6lqK9+K1qWwWXTrdGhbjUyLk8y3S4
 wC5g==
X-Gm-Message-State: AA+aEWZEc6h6aN1v80HduDjAFkaVTRQIa7pselqeZb2TB+j6Dm61F3Tz
 DSRXO8TVbG/SMS/PTkL/WmY=
X-Google-Smtp-Source: AFSGD/VAaDu5yC4knlwspbo7uIKQpQuFB3SeF5DYHpLGiiBQp7pVbb02sHPiA3WtFhV2XKVUM+/4cQ==
X-Received: by 2002:a19:d145:: with SMTP id i66mr15013769lfg.97.1546013912224; 
 Fri, 28 Dec 2018 08:18:32 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
 by smtp.googlemail.com with ESMTPSA id r4sm8136502lfe.60.2018.12.28.08.18.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 08:18:31 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH 1/6] ARM: dts: s5pv210: Use correct fimd variant
Date: Fri, 28 Dec 2018 17:18:14 +0100
Message-Id: <20181228161819.18931-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_081844_131049_ABE4E47D 
X-CRM114-Status: GOOD (  13.59  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, xc-racer2@live.ca, linux@armlinux.org.uk,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org, pawel.mikolaj.chmiel@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

U2luY2Ugd2UgaGF2ZSBzZXBhcmF0ZSBjb21wYXRpYmxlIGZvciBvdXIgU09DLApsZXQncyB1c2Ug
aXQgcmF0aGVyIHVzaW5nIG9uZSBmcm9tIGV4eW5vczQyMTAuCgpTaWduZWQtb2ZmLWJ5OiBQYXdl
xYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5jb20+Ci0tLQogYXJjaC9hcm0v
Ym9vdC9kdHMvczVwdjIxMC5kdHNpIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIx
MC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC5kdHNpCmluZGV4IDc1ZjQ1NGEyMTBk
Ni4uM2Q2ZTVhZDFlYTM1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLmR0
c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC5kdHNpCkBAIC01MTEsNyArNTExLDcg
QEAKIAkJfTsKIAogCQlmaW1kOiBmaW1kQGY4MDAwMDAwIHsKLQkJCWNvbXBhdGlibGUgPSAic2Ft
c3VuZyxleHlub3M0MjEwLWZpbWQiOworCQkJY29tcGF0aWJsZSA9ICJzYW1zdW5nLHM1cHYyMTAt
ZmltZCI7CiAJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZ2aWMyPjsKIAkJCXJlZyA9IDwweGY4MDAw
MDAwIDB4MjAwMDA+OwogCQkJaW50ZXJydXB0LW5hbWVzID0gImZpZm8iLCAidnN5bmMiLCAibGNk
X3N5cyI7Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
