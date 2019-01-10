Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937A4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:09:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CD320879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FvmJI7QL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPAk5BGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CD320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TPgV0nTBmWG6vH/PWxUxGTglUrKinSzDQRtW4gL5YYc=; b=FvmJI7QLces7Kc
	j17dTeCwJyubnml3bXi2qsXiDt1zQJKJX8ngTxrB0ybKU1hgPTg6s7kbiLD+Ly0cFw5AzX4CLNuaH
	uQB9PgeT7fkah4nDQ5wkoTsSCNTTa4P5eToM8TvQh+NKd9sX4WPNw9GGixFZ4zuTrAhCDQ0F4m7i4
	JkoByQsbdYH8t3Y57fa1ULXGjodDm/JucbBhZEKm66DWU3r3tDeu80tpF71+oY9g0b2jZa0Omz1o+
	1FPJSE3zdmTB6p0BOqwVBaMJS++6FClMb+mlazYdskoBwaxb5AoobTrPpT+Dl1z9YQe5PEitDPj1k
	7oDrjOmyig/SZSTJcqvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghReY-00055U-46; Thu, 10 Jan 2019 04:09:10 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghReU-00055C-Af
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 04:09:07 +0000
Received: by mail-vs1-xe43.google.com with SMTP id e7so6211342vsc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 20:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ONXri8yfCzc7g4L+BmXg6aEfyeyOi0gl32oHD8VH+s=;
 b=bPAk5BGgJXNxII7J5QUs2i3Hhuk3vqJlaXkBmtOi4fgENPiWsAWiWMoGcP05LqP7FS
 1YtC/Ce3x9pk0hSN2h/adAnfE9U1ez0Paa+Ht6kI2L/ERXluM7jJGrnOarDiozcjKcZJ
 AZkOvfpG0j6dhGn0u7vDKVoU2r+LJSIdNIWRr8mqR9jfpEQu+hFkZrk1FTSKl7Jep0GO
 MZxzL5eTrVoMmhyNaMVg39JIxwouCims9QtD4WPyIPUZRSEXPKpPNPU+gOVrIK8x6Q4l
 Gj9QQztV6kGdlrUogbM8oxmhRMczaChbHy8FheDWnkODoGPiF1yb+Mwb4/Keof9s+Zxi
 ztyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ONXri8yfCzc7g4L+BmXg6aEfyeyOi0gl32oHD8VH+s=;
 b=ABCpyLoBJQyt+qqQ3PlsqZh2pjb/9U90hn/mdY5sh9D//ufB+k36ESnVtNDJGrVEUy
 EsuB7K26T9HJ3+Yt3g41voETzdE51adEw90KzW9UoEl+Z6JZUEwnxauIaCjazHBIuCcG
 YjgIO9Lrfl7I3AvRUOEvtQW+XLQ0CNIfiqFGk9lGNXnTPuVi1HJo5uzFm1nxyp4hjyoe
 BMaIz6YVamr/COKYGkmkUThXE8HLf6VmkyMUXRF0IndHCDtm7W7ngroPAqoVSlnHTmif
 Ktf96fNng19wb8y9D5PFHvLJslHC8U2/T2qxKpnhPK5IAoLvXmLkukSTCuz+3FFKAila
 bA7Q==
X-Gm-Message-State: AJcUukeCQXDnQXm9Hj/ZPma5lnNpFBTHlj0OPiN0lKN0M31IKSOaaLrF
 QaPuhsHcn8bKFRRFRtfpBnMbxdKGvJY2ffKgtiY=
X-Google-Smtp-Source: ALg8bN49VxW3M3lo2uKe+yruNIrfnr85MAvyZZSTRYraMNm+e748y+2SCx05NWYozPxDSWgL/b8TBeoYcKXxhTv6H8Q=
X-Received: by 2002:a67:b44:: with SMTP id 65mr3572384vsl.77.1547093342773;
 Wed, 09 Jan 2019 20:09:02 -0800 (PST)
MIME-Version: 1.0
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <CAKv+Gu_wsK1UNXSp=5Hvd7XCHKC3cVkYjTYHhvqM4Xt09A9iKg@mail.gmail.com>
 <9129b882-60f3-8046-0cb9-e0b2452a118d@huawei.com>
 <20190108135444.GB14476@fuggles.cambridge.arm.com>
 <cd5bb83e-bb0e-b348-5365-095c5fcd9648@huawei.com>
In-Reply-To: <cd5bb83e-bb0e-b348-5365-095c5fcd9648@huawei.com>
From: =?UTF-8?B?6IOh5rW3?= <hhtracer@gmail.com>
Date: Thu, 10 Jan 2019 12:08:46 +0800
Message-ID: <CAAq-RfT_Kjd8hbm=BaRg5a6uvTGLzZipt91wpSPXCW51hGTnNQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: "huanglingyan (A)" <huanglingyan2@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_200906_369635_AD57984D 
X-CRM114-Status: UNSURE (   5.42  )
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
Cc: Zhangshaokun <zhangshaokun@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

hi, huanglingyan

Have you verified the correctness of do_csum?
I validated it on FT2000+ and do_csum got the wrong result.

You can test it by increasing the input length to more than 60000 and
setting all buffs to 0xff.
I think it's possible that vpadalq_u16 will overflow, and the code
doesn't take this into account.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
