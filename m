Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C64BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:59:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635A620672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H2hCA1o/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6L+sTnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635A620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QcieGrZe03NB2gciyn3f/hmqPysywvhv5ZnyNMBTeeA=; b=H2hCA1o/ll1QCM
	o0YpogGRVcsIBrVGZ2M44kOclZvpuWFH5jmmiSiYjHD/Od2i5hXUYIuO678vbgGo+HDRIOxSntnf+
	9JRfl2d9EmkorBZ7/opge5u1n3KyLCCbOsxSpr/MAfqtr/xqQHwNRqElk7BS1ssdFnut1TaIL1beO
	3VOKYbCGLroHc428jIhxGIxceLNPY+0jwgxboRchx8AFbK+qW0KIaY4kChuIekCjnqBooQOAxNNU9
	a26YBnUhAF5ZCEHjvOpmW341rqRZwLnr3RFsW9OQK9ipZhWyfzMoolbnJQTLR3n/WiNoUQBeJVZI0
	8Pf5gGZxPqqJCCp31GRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZly-0002Dj-C3; Sun, 02 Dec 2018 21:59:30 +0000
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZlv-0002Bb-6T
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:59:28 +0000
Received: by mail-ot1-x335.google.com with SMTP id k98so9875823otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=TZiOhIBu/s1H84QVCXIifsTCsGuPKlnCq2C5SR0Pc+4=;
 b=l6L+sTnZiP0Th85jwhqG0A5MZvNZ05nIR69sU8dxjwHXQOmBNiE++VILEHD5nVFq1y
 rdMlM/mAKoOsb9eLfRrVr9R1hpJI7yB6I0zehz/8+AttwrnGufUd6iCllaEwF4Y2oDQS
 aVQqHTG/iYMU2hh766pyyQMNwyr0U7Mdr23/M81No04kDBa9O1x4HbIyoNPSrMteomfy
 3+YWS10QZrUuQ4MZUDneznHogVNIffYiHDoBVJ5PXX7w2aLTC/1jCD2pnul9BxcSYupL
 SOXVK64mQ0N6AHtrFDUNXGMiA7OV5sVe4Cu8AxKD0YSVrkeCi6FX8wQXZvxtU6KeaIu0
 KiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=TZiOhIBu/s1H84QVCXIifsTCsGuPKlnCq2C5SR0Pc+4=;
 b=qaj/62K3ib9mNr0qkIZrAwR7/80vfuqZweHzqSEmRjtsBuFXgokkKvRfkpHZy8yxQB
 p4JSme4g8hEKAEqbN7OyGwvuYAVD95VPh1V6a3B0G2bYackNPi1UFznvg9I3nwhxEqgH
 0CttkDpaRiy0329WjlhXmhCvIv7n4lk2zt6S4XbQKsqF94wjM+e8KjdoHLb+40W8lGSx
 zAIDR+pket+eyu1vWMNn92MHJtSrDf4RyOlER4tHsNxg0GJNALyphUe+7lMrffbX6ECr
 dPppE8QnWtKgnz8W/ojgs/F27KUNF/R1z0/iwX6/FiwoN2CU/HMCGacV3YjROoYQDbRl
 1iCQ==
X-Gm-Message-State: AA+aEWZsCNJxHU+vqmb23stXrAcVxKvYuDXd/bE6IhNUZRf/tEumK13I
 eiFeEfI708SfdtJ/WaIocpTk/fyUM3s2fOCR68M=
X-Google-Smtp-Source: AFSGD/V18QLqN/oTPOFSPlvnqeJYel6Nsg8PUIuKGsyP+7/Qh0i+qpVbwIp/DoeK8l4VjRiRBo7NRJ3xahp2qb5PSfU=
X-Received: by 2002:a9d:5183:: with SMTP id y3mr8022244otg.5.1543787955468;
 Sun, 02 Dec 2018 13:59:15 -0800 (PST)
MIME-Version: 1.0
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Sun, 2 Dec 2018 13:59:04 -0800
Message-ID: <CAH7mPvjbZoYYxS3mThEjS-uuLkemuts06pKaOWOw22hUzvAT8g@mail.gmail.com>
Subject: adding CONFIG_MY_NEWCONFIG=y to defconfig considered harmful?
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_135927_266301_622994CB 
X-CRM114-Status: UNSURE (   7.05  )
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
Cc: mark.rutland@arm.com, will.deacon@arm.com,
 linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Arnd,
I was looking through `git log arch/arm64/configs/defconfig` and
noticed a few commits like

41925a21 ("arm64: defconfig: Enable TI_SCI related configs")

that add new configs defaulted on.

How come these get turned on for the defconfigs vs a board specific config?

How come arch/arm64/config/ contains a lone defconfig (that appears to
be picking up everyone's wanted defaults) vs arch/arm/config/ having
many board specific configs?

From a continuous integration standpoint, I prefer a slimmer
defconfig, as the more we add to it, the slower the individual builds
get.  I would love to take a hacksaw to arch/arm64/configs/defconfig
(removing a bunch of stuff defaulted on), but maybe there's a strong
argument for this difference from arch/arm/configs/ that I'm not aware
of?

I was looking into this because I want to add CONFIG_RANDOMIZE_BASE=y
to the defaults, so RFC for that idea, too.
Thanks,
~Nick

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
