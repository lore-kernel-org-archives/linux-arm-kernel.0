Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67590C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:46:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3755020838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PUg0b4OA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FyahtIvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3755020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DedjLkpVt4rlx9aSHgwo3yt5ps9BCKBkPWEqcnjI+FI=; b=PUg0b4OAygPMIw
	tf7bN/+i4RI2t+OHFID8fFdvbXFbZhHROJ4ZTFAynyax/oO1dgwRKJGDSUVTAaUr6FvYDAyJLIySu
	gGwyWd2qZ/bIY3INN97ytt2LmPt2PAY9j7an8661bZzTCjwclMpcRIu+XHhpbkFg1Bb3NwkElIpEK
	zrdENH9a50usL/Hsxv8H6ThI7x5ZyTAog06PWT0zOPE1sWGL3V6yoi/FMP+I45uqtb985mX2NvYMy
	KvTA6KoTmFKKOfidGsf97G7hjSCmcJeTVdJgAT8pUjCKG7nrIeGRml4R2eBnfRCmLf0Zk7pfuyyMI
	EORumqIumH7BAAnWdLzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwnO-000882-5R; Thu, 06 Dec 2018 16:46:38 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwnK-00087O-FK
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:46:35 +0000
Received: by mail-lj1-x22a.google.com with SMTP id s5-v6so969932ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=moQEmg6U8aNA/s7O0hpS5fqf4f4z82peEZQmioDjw3o=;
 b=FyahtIvUUIjKude/V9Vsp11dxcOfsNkDyfz2JbZSFKT5Ybt+4Faib7feQN73Sr3HE6
 3hj2hPdr+lcYB0jPyZlHEYACQHWiRJWUIFaxKiSjvTQnydXvSVQh4QQ6ttBs5rqnyHKk
 MeZSdJRxMPa0PruECYTi4NlRbwshjgPJJ2b74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=moQEmg6U8aNA/s7O0hpS5fqf4f4z82peEZQmioDjw3o=;
 b=UPDRS1FFLDr9uzgdkN3PIoMC25Nrn0R1avWxqzkgcUkwZexmuxMgLZhZXGNm9URsgg
 PcMwalfcOy0myTioM3FXEA9LIClNGXIYoVWLP8gM1lF+cu3nNtQ6EZK4h99LukVFMI5x
 wRhO6ySoEkdjwvzET4hwzU2T5rhRUUYCCWVa0vZTVk9bMZTm1rgwPyxtoryVKlqcgQLs
 MNp5T8Rr9Xhrk5vjAmJQaj/+4RYe9ABx+Izfbeem2Jsxy9SXRzHe64/IrAyxt4EOnMHo
 1lFZuu7SwLq7una+d4x3rG/XQnZO6/8A1wqi6WztEr1dEWsn4k5RAZJNaXg/jccKDKQo
 0CZQ==
X-Gm-Message-State: AA+aEWZ3u2roBpUYgH4oSs0IbnFuaGVaGO7dvNebBM4HJKuEdMQd+/2E
 gQ/AvZZGJRWxOZtXCaltk26V2Qat1/o=
X-Google-Smtp-Source: AFSGD/XJ+422fgtOMVMobkUD/DVGmdmhE4/Bem9QdQtdq3e94t5jTtg1dDDhdNyUpOWMAVuG3MZZgw==
X-Received: by 2002:a2e:2a46:: with SMTP id
 q67-v6mr16011366ljq.38.1544114782014; 
 Thu, 06 Dec 2018 08:46:22 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com.
 [209.85.167.51])
 by smtp.gmail.com with ESMTPSA id y24sm147686lfj.17.2018.12.06.08.46.20
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 08:46:21 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id c16so847586lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:46:20 -0800 (PST)
X-Received: by 2002:a19:a60c:: with SMTP id p12mr18414889lfe.63.1544114780003; 
 Thu, 06 Dec 2018 08:46:20 -0800 (PST)
MIME-Version: 1.0
References: <ab9c8bec-35be-9e01-a567-bc2e4b2bef87@free.fr>
 <2b186a33-aea2-629c-6fbf-aefe16ff7b0a@free.fr>
 <bc40674c-9be7-3e5e-9409-42aa8bb0b376@free.fr>
 <ec633e12-b6c1-5de9-690c-a58b8ecdb2b8@free.fr>
 <48b1a7ce-afb7-18d3-6855-69196972d640@codeaurora.org>
 <a4c0c2e1-09d8-c48f-d434-6147c047c3a8@free.fr>
 <d99567c7-9c1c-6d7e-6dd1-2930b82db7d8@codeaurora.org>
 <0c189977-62dd-3539-3b5c-233773682e69@free.fr>
 <1dbb2f0b-0ad1-e622-a9c4-9ff7284dbee7@codeaurora.org>
 <7a7ccedd-c6b2-6789-c76e-ad2ddcd53e2a@codeaurora.org>
 <6b8898b9-a9cb-8a72-0c73-f8a956cf629e@free.fr>
In-Reply-To: <6b8898b9-a9cb-8a72-0c73-f8a956cf629e@free.fr>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 6 Dec 2018 08:45:41 -0800
X-Gmail-Original-Message-ID: <CAE=gft7Pd5u4Axa1XNf+tSYC_awxT8VLNXfJg7820LA1z9RtZg@mail.gmail.com>
Message-ID: <CAE=gft7Pd5u4Axa1XNf+tSYC_awxT8VLNXfJg7820LA1z9RtZg@mail.gmail.com>
Subject: Re: WIP: UFS on apq8098
To: marc.w.gonzalez@free.fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_084634_541608_7DD72086 
X-CRM114-Status: UNSURE (   8.26  )
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
Cc: jhugo@codeaurora.org, linux-arm-msm@vger.kernel.org, sboyd@kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, nicolas.dechesne@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 8:18 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 04/12/2018 18:31, Jeffrey Hugo wrote:
>

I'll throw my random thought into the hopper here. With one particular
brand of UFS part on SDM845 we needed to make sure we banged on the
ufs_reset pin before the device would re-initialize fully. My hunch
says this is not your issue, but it can't hurt to make sure this is
happening.
-Evan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
