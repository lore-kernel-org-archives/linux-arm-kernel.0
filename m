Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14B6C61CE3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 03:30:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF9D2084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 03:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Aa0nCyOp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DCXt7pJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF9D2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UgI3ZxHEg0cVcviJlz3U9yLIhvSQfEX+gkzs9UbSKrY=; b=Aa0nCyOpOc1nRy
	qGUJCIeVakVaURasQsjSIFhTtQsJug4NoYPqGrsSeSKpIiqBVw+v8mO4SdGNymv2EmgtmvoFIHvkL
	o8DMQseMfx8nhzln+rh0+2jXO7Dqd01qH1Q6JPRUxCasPhyPBDM2MO/GybmSMPsGn04Q9IHKAOrUH
	TFBzK77DzxOQXmVxLPCT8siVueG7MXHXd2A3etOY/62+MY68jbgX5kdHvHZ8ZtzDg28s3zA7DWqNC
	Qsvcxpf8ukvKe5b1Mo/wW56ShMNvn9jzHxaDobNENMAkhCRPelzUGwG/58UR4Q07AErqe+SHMluS9
	k4uBfwi1bPBW/Jd6B47A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl3oU-0002Ek-6a; Sun, 20 Jan 2019 03:30:22 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl3oQ-0002ET-UG
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 03:30:20 +0000
Received: by mail-lf1-x143.google.com with SMTP id u18so13148435lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 19:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZHil3/B07qvaV0f5nv6g4tsoqrxMXGl73zytgQtPgCo=;
 b=DCXt7pJwVih8kI26AuyFgLiSi/4yiVQuHfnye2isrvOXqPoo7p/qsNyOum325NWefB
 wD0UEPSh1hMAVqxnG/+xtRfsdAWFVNEJlxiMbdqgNAjWNHyzoXstcrDJPbq2trpNworn
 /b7yxpynwdtuU0gE6MGUhaYcUDbfwshOX8efs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZHil3/B07qvaV0f5nv6g4tsoqrxMXGl73zytgQtPgCo=;
 b=goUZWw2NoQ14OwqZXhYuk1LlbM4cuT4zk3X1C8hIkdiDc9l6vy73wW3cyV74cjjnpB
 v5dNDcdsEvmtc/hy1ICyUq8Bsv9TJGBAj/DWjgCgBrl9Yn5ACcIIHJxyPnm+fTLQlbW9
 SQ6JAmc8jILzKXHOyPolSjTR9oR6cR08Sb2guALbhjKoBg6OmagBTTw9zzeRHkhoR1bo
 uORmPRM2TGOs7WWjOIjooSxO8lGHZJN2sr1JXrsUG0B0ZfiItRKw0jInhbbwj0lJNJwM
 g+jkVumRNUu0TY8yrXec6P/AewGSoM3VIxJjNUdRZ4o8E05BT/ylUTglzS8yfriuwZwL
 wDoQ==
X-Gm-Message-State: AJcUukdHqnewIkI//j8PajDpmHWZiv2djCuphG2S5FR60g0YD0cwubtB
 lp1I5b9qC+VCJAsJxKQXTh1ddEBE2PBPYw==
X-Google-Smtp-Source: ALg8bN7iBc7b+rVVPtXoKBenBsGZL507V+wDv2hYpBBD9ITA5qP6mLUQf7s3f1Kd87vsYgU2S1l4VQ==
X-Received: by 2002:a19:690d:: with SMTP id e13mr15526256lfc.84.1547955015129; 
 Sat, 19 Jan 2019 19:30:15 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com.
 [209.85.208.179])
 by smtp.gmail.com with ESMTPSA id b21sm1530227lfi.7.2019.01.19.19.30.14
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Jan 2019 19:30:14 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id v15-v6so14720880ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 19:30:14 -0800 (PST)
X-Received: by 2002:a2e:310a:: with SMTP id
 x10-v6mr16278165ljx.6.1547955013741; 
 Sat, 19 Jan 2019 19:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20190120000420.GM26876@brain-police>
In-Reply-To: <20190120000420.GM26876@brain-police>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Jan 2019 15:29:57 +1200
X-Gmail-Original-Message-ID: <CAHk-=wg=yY2DdU+G73O-r==G6tRYmh_d-uM7_N5mBRubzELXGQ@mail.gmail.com>
Message-ID: <CAHk-=wg=yY2DdU+G73O-r==G6tRYmh_d-uM7_N5mBRubzELXGQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: fixes for -rc3
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_193019_006190_FF4CEC2C 
X-CRM114-Status: UNSURE (   8.87  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 20, 2019 at 12:04 PM Will Deacon <will.deacon@arm.com> wrote:
>
> The kernel.org servers wouldn't talk to me from NZ (the keys appeared to
> have changed), so I ended up pushing via the UK which seems to have worked.
> Please shout if anything looks weird.

Everything looks fine.

Thanks,

              Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
