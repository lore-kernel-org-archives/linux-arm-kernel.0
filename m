Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E43C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:47:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF9A205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GCGIiP9J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="RlZ8R1JK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF9A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s8b0d/Bu5Cx4rRTHc7HzghYlv9E6wDUYuVLkPiHDIfk=; b=GCGIiP9J5hf7NW
	n0dq1d2LgMbq7dSE5O/P3IhpAgVCJ8IDv795J/5obJf+toLCIW4EqBWfTzMWNIEVjXx1/iuRE231C
	SDftd3SFVmoXTgBaLygA/TAgZqQBDIFzVH7Oxel7OM3MxWsQI/kJUgoBhK1dD9KAA50baUTYeG7/a
	EJPzOCOdPKM8LRnup5p7SK/dKM0ma508cOu+L41Cn3IfaVv3cAnUWHKNH9i/P7LZIporRW56NRqoS
	3ebpa/A8hnX74EF3YfWcpR3zW3wqPCwzNMfgHJonSSpFsVs1k/gHtOWrUHehJmyY60pTOKJlFBetl
	08iXsuxthDOYotHpE35g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjxiN-00007F-HG; Thu, 17 Jan 2019 02:47:31 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjxiJ-00006n-Vl
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 02:47:29 +0000
Received: by mail-qt1-x842.google.com with SMTP id l11so9844763qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 18:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jhUYHlWsp4dPPCUUpYGivzzrUbq5nG0j5/GyKUMF+SE=;
 b=RlZ8R1JKHdUHs1UOia+dTIgj4dWHMJN220b4Zfmw0OoGXX8CW3WsSHtH0CX5n7YaAO
 sTQaJ2V+dzEYl+w6UmgRjlJxlhxBYs35b/WqWxYZZr6pdHoMPvwLaKNQNpjtmlRprC2Z
 4zP4XW0CJFhAiVlfjnCgmx3s9vQsgZ9yY8b7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jhUYHlWsp4dPPCUUpYGivzzrUbq5nG0j5/GyKUMF+SE=;
 b=miQrIf5zIfn4H1vqWLjKsKkl60FRYASC/QC2EFSwxf4G3M72fg+UV/ax94tQJfk5gy
 MBHt9TjPq/HljGGdtmdPr355xBCLcC1NvsYWqmtA22gL3P5o5ce9FTE6hkF0gKXLm6cA
 7IyECkik2H6EuiuESUStggvjLFk+SddbGN1EH81FDpHlWdIiL+CFZ4nfDFr3yb5g6DNo
 UT02S4dLz3ZwTzxZFStOBBq/NWZASiq5sl0W1I0+CHhSMFSc/B0Jj/jyB0IJr3g+XT0g
 pPU7x6uhwHLaqXJJnYtiDdBtmI30SuWnX6ycqpItK16pqRkSka5ZoAanIpY6e5YQOZwT
 Q4WQ==
X-Gm-Message-State: AJcUukfjgB8u3t7c9JW18WUujhBjrhJ+A1cG7yQDG4HDVVZ689hPw9LV
 EVtGCzAJnFezYx86uis/87yXvprL8lmcYjWx23w=
X-Google-Smtp-Source: ALg8bN5/9+t2WoEt4JnZeWiSXM/fyx3B4LuA6Q61b5VpQmLE39xvSZZiUASfk9dyCE7X8KzSY6olpwG7yy5+rcT1wTA=
X-Received: by 2002:aed:2764:: with SMTP id n91mr9903046qtd.37.1547693246995; 
 Wed, 16 Jan 2019 18:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20181217200405.2904551-1-vijaykhemka@fb.com>
 <20181217200405.2904551-2-vijaykhemka@fb.com>
In-Reply-To: <20181217200405.2904551-2-vijaykhemka@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Jan 2019 13:47:15 +1100
Message-ID: <CACPK8Xe2SbmxoY+Fj3jr7eZ7qA9bqgSgpuS=L9iVcL+wu26_wQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ARM: dts: aspeed: Add KCS support for LPC BMC
To: Vijay Khemka <vijaykhemka@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_184728_015962_E641A317 
X-CRM114-Status: UNSURE (   8.92  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@aj.id.au>,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 18 Dec 2018 at 07:04, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added kcs device support for lpc BMC.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied to the aspeed tree for 5.1.

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
