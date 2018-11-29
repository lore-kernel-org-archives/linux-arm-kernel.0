Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D437C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:50:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD17120868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jrnllicL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="t1fqHYVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD17120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MTP31yycqxKRNtcj0H1p86Qgd3vqJ6IjtJbNJojdgs0=; b=jrnllicLepYyp1
	Ba4n+qiIGa3YfcJEFNcAtTZiDLJZ+5jGtivKj8qlw6Mm07NrcLeHdOze4zrj6IT7oVJpBalZo4ZyB
	AV/szI6SshZEcb3+biqdBzMbd/bpfy13ExJ0d7ktbQ2loge814W2UpTmEbFLp/zeySg5P2XJDOfOT
	qwz4f7lgYz68qMagnzfyqIgMKhdKgETjtNTYY2963NcDhgoFB7++1cBVBOLbZf0lGP2DRMyp/v2Pe
	g0w6Y5XA/QxK+dvlO9f7/ILqdZHiNBGGBkl0zAnI2mlNdEWJCDA6Ye4Zy6+zGVuE7vTG7TAWZesXi
	VhQ1qRNVBBfXNHCR/8aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSTGU-00011q-3h; Thu, 29 Nov 2018 20:50:26 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSTGQ-0008B2-2n
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 20:50:23 +0000
Received: by mail-pf1-x42f.google.com with SMTP id u6so1607709pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=yC7v9NYZvDxzd3HHsRGbs36yZ369uXAKhQgSnKMWzgA=;
 b=t1fqHYVhV/dy+ApPO2tDKJ4dzuf06Aije+OS64kXxle2geC6FXUM4LZyMTEDK0WpCW
 MAJHIvXe3fUjXXu9lIdtnaNV/OOD2KK7FfJ0ziP4jgpKJzjDDOet2g+d13kwqA1NEkaa
 TwkRNCDA9gCRGaEhu7pvlOgRumgFp4yqk90yY4G7/cdjAeZ0GPYuqgCHeSZbMmJSNUXT
 +Oza858+3GCpOA8JFC5B0RU64IJxUaawb0MmKuBqVBEwxzzymzomAUVftyd0A5MxeM8l
 wwDthAvoJqCKkchPl6nEF0tiXkwyaSjuF2MU5pBvKT0MqhgNh/qrh4LMKuRdRlPz6Dpe
 L9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=yC7v9NYZvDxzd3HHsRGbs36yZ369uXAKhQgSnKMWzgA=;
 b=Qz4dtl0lXwTcWp6ffh7HV9jlulmz6GivbRe1AcUBqI1fa2YweBol8QIDZ7gt0aXzRf
 g3JoWoDZzGsmUL5TBB/kMc2VJs0GdnDv/5gjfgRDtDZMY+eu5RU6QTWSATf1Ttsso0V+
 /QuIMZNT2lRdW4a/JMIGtNgApbcKvvVXct+wijoOY7W4EliHZKgsjaQbykI9lH8qXQkf
 vlFsJ8Rc83/soEtK9pGgT0KTNDuqlgJLc+tB+P5E12pbxjt/Gc9lKVWNG76+Lglmbkkr
 VbzwZAk31CrelhtqPA3pqMcCP/SQSbpyPGvZygg/Zpy8xfCEVVxRtW8tCyRdJdR32ntd
 6ghA==
X-Gm-Message-State: AA+aEWZgOWiQnWAfcRH4AWLRwUmdfGBR+khl9PgtY+bRNr/VnwMwyxPZ
 b2PIqOut81qtnRMZs7vZX79TqOjIXgPtxEw9hN4kBg==
X-Google-Smtp-Source: AFSGD/XEgRELXVPEREHORHwjGmPsAnMgdghqcNWzqJXlbjzP4I2KjzmYU6MNrIV7WFsllsrmkQZ0ykKanPK+L+uZ5D8=
X-Received: by 2002:a63:a064:: with SMTP id u36mr1343931pgn.145.1543524608509; 
 Thu, 29 Nov 2018 12:50:08 -0800 (PST)
MIME-Version: 1.0
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 29 Nov 2018 12:49:57 -0800
Message-ID: <CAKwvOd=uhn-PUs==kVGnXg4W6UwuGvSn+EWUzK4Q8wMr9mzFpA@mail.gmail.com>
Subject: LLD and CONFIG_RELOCATABLE
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_125022_153383_DF18B582 
X-CRM114-Status: UNSURE (   5.72  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ard,
I'm hitting a few different issues trying to link
CONFIG_RANDOMIZE_BASE=y (KASLR, selects CONFIG_RELOCATABLE) arm64
kernels with LLD (LLVM's linker).  I've filed a bug:
https://bugs.llvm.org/show_bug.cgi?id=39810, and am getting feedback
from various LLVM folks, but thought you might be able to provide more
insights?

-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
