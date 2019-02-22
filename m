Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7E6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:37:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C67207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J6ib1Zdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C67207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=atKvAXBcBp1LDKl1sQYl5g/iHBLKz+Sx3a6SA8RxF+c=; b=J6ib1ZdkB47TDK
	wgkeUOyInMKDLczKHRINmbCWDSWjsYMcIR0hXRWspU0TnCJGJ8GVB8AnM+mwu6Aft3pzW3QoZvtY2
	qmPz7P4D47Bn/EB2l25ZfHAl8ONuU+kWHlc38Da6ilPjq7vHftSo/osx/njR0VuIkawB67N1hxhq2
	WrlAANmXRNqa65ZfDxGSsRVZQKdRF8XCso2IQCaH0Xeb0hHrW9TmPFoBuNufU8t9NKZ9dcSB54vn+
	xlU6ARvVmaZX4oknjGGk2ULyZRB9HqsHwGADlCccUabYGlxe7fCfP35JPUn6PpMOBp4YOi46mnhs/
	q0lu4sI0N2qgzsItCE9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBwo-0001qy-Tc; Fri, 22 Feb 2019 14:37:06 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBwl-0001qR-LS
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 14:37:05 +0000
Received: by mail-qt1-f196.google.com with SMTP id w4so2717100qtc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 06:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N3FPBArLk4ttPExL8Gz4HLwKaY+a2vfyPrwmZUxcBJc=;
 b=bl+U22DBxI0CKRIZKlsQJ5SuxX2KWmz2lfSsx3YxKSz0jZwMGs1lF9VRzOdrQ0xrBN
 3aJQ5Lum+veBAf/tipzw1UTLJbNnwyfmJYBLlzcnJOxpFFH1o8fZ3wrvtlk3ZTNcTvQ2
 j6rZvIj58E+hqG8q+apU8l3X4X8bVaZzwXrqo+ra5HdQKTfNsp8sNZeKAu27iT5k1mfQ
 MEvDTzSMk4c97zvUWVNr7pROuc7Ud4z72+NrD8pOEVTyXQaS23DH0o0QSU2WmVS2aft2
 qUSawh3Bvsk85Ij8fmU5JvaeRQ4M+JFyAfF5nbGJuurQrBU6pZERwJEMrx5SbfWLBofp
 h+ww==
X-Gm-Message-State: AHQUAuYL8YHx5P9cGq0PPSKccgX78ZHsIIAg/PcMJ+aaQ2Qey3oL1zzs
 naELeUPiCmGG8gED3WUnTqwJcZVXhrMyTXhvOcQ=
X-Google-Smtp-Source: AHgI3Ib7raYOmePQ+u0ERjmE9P0JqOq7MX6rghPVtWA9spAisZVjOpsN3CMkmsCbY2zDShkPfUcF2w8Wmboyms+0Ozw=
X-Received: by 2002:a0c:e98f:: with SMTP id z15mr3406123qvn.115.1550846222453; 
 Fri, 22 Feb 2019 06:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <CAK8P3a1ssUdsqk7YW-tjD-dihEAP-voKLOEGO-W=TL7Lb8E7vw@mail.gmail.com>
In-Reply-To: <CAK8P3a1ssUdsqk7YW-tjD-dihEAP-voKLOEGO-W=TL7Lb8E7vw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 15:36:45 +0100
Message-ID: <CAK8P3a3wE1VzsAGjuFudYNDNWAtyubAiCsYU=Sd_40Nj6+-sfw@mail.gmail.com>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_063703_702594_A8B654C0 
X-CRM114-Status: UNSURE (   9.43  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 2:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Feb 22, 2019 at 1:25 PM Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> For __vdso_timespec, I see how you ended up with this
> redefinition, and it makes the current version of your patches
> easier, but I fear it will in turn make it harder to add the
> __kernel_old_timeval based variant.

I meant __kernel_timespec here, not __kernel_old_timeval.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
