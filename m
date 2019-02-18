Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74458C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:25:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF2421773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cTRHWCs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF2421773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ncoyu8stk+JZEX9n9iYf9jrxvn0zFCXNRsOIVc07Dxk=; b=cTRHWCs5Jk10v9
	AK7fRflOXPwv2fa/EHs5h4nBDg4kuvU/3zA8GQWsF94HvDLeVQ/jw3JH+WkZLiCu507dWZ8pncjld
	f8TerkntGybEhAAifMrhJnuu7q5LNWK5Xy0YTsaZhYNHeJ/cPr+ntOzNG60n1V87HBK01kIKjzG9p
	LGIDzFQ7MVxk7MJEaeMpi15FT3GgaTDyigD1l+gm7uNOzx0g00wp/o+cKxnukDYzghkrnK5UTH6ci
	gLEjulw+X0NhpbRoClrMpO0mwbpxK4Bfwe7zXQ0krWSO434iq9O1qX1NW9xM/EQYyx6aQwZFSnOBC
	ImYz/wonLcHQ3asPHDOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gviv2-00069U-4u; Mon, 18 Feb 2019 13:25:12 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gviuz-00064a-Dy
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 13:25:10 +0000
Received: by mail-qk1-f195.google.com with SMTP id x9so9953641qkf.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 05:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7IHqtkRVEVTHn+9+sptNlIIeyHGDO852sAgGsEy3y9E=;
 b=uZOGyrV+iHOEqVvubTkAdd72u5ypPyQ/ZN8noA1bvEG6wG4d7Swu95WbOFyeOjJend
 KsCLrmqbu0toGWgd2VLlwUNzfd+NIq1xTfkJmWE794mUJdS/677S2fejd3KWdbnuFQ6l
 R+ZWSlATBUHhQG6uZ6Qw+8hi1RXk5mL+yB2Nto4xeHy49TmbRLEGBB//uFyUOj8Yj5Zd
 69fizg9aLUfey1U/4U6ls0ZLDxn0uALTa48nrz4naFalHiqWovPhXPRtyye7B02U+JzE
 l3gxmn2i9levGFOYl+HYH9TetOGCW+i7DTewtBkNIJsdNLdVWmuPzB/KjsucurfkKS7Q
 KbdQ==
X-Gm-Message-State: AHQUAua0W5cLtcv6qdcohJlFcj9OoS1/Flp43jZarQYLeZN610z2mgYg
 NmSkUykmzLxvuzMjNKmh89OlP8THi1HyzA5hXgM=
X-Google-Smtp-Source: AHgI3IbmOtPG4z580UVbFA84khRcARWVLwN/wqpDdX9DncilrSJZqfD3H/5NLHui6Y+XMk66WSDssFwjDNMKaIsRIM4=
X-Received: by 2002:a37:bdc6:: with SMTP id
 n189mr16207462qkf.330.1550496307084; 
 Mon, 18 Feb 2019 05:25:07 -0800 (PST)
MIME-Version: 1.0
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1548098268-982-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <1548098268-982-1-git-send-email-lsun@mellanox.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 14:24:50 +0100
Message-ID: <CAK8P3a3BEA+oESXONvuVHq5XJ8vne+-4yL78DXux9pXQdybq3Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] Mellanox BlueField ARM SoC Rshim driver
To: Liming Sun <lsun@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_052509_470210_A992E67D 
X-CRM114-Status: GOOD (  10.66  )
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
Cc: DTML <devicetree@vger.kernel.org>, David Woods <dwoods@mellanox.com>,
 arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 8:18 PM Liming Sun <lsun@mellanox.com> wrote:
>
> Liming Sun (9):
>   soc: Add TmFifo driver for Mellanox BlueField Soc
>   arm64: Add Mellanox BlueField SoC config option
>   dt-bindings: soc: Add TmFifo binding for Mellanox BlueField SoC
>   MAINTAINERS: Add entry for Mellanox Bluefield Soc

Could you send the arch/arm64 changes to soc@kernel.org for
inclusion? I'm not sure what the status of the rshim driver is now,
but we should probably merge the base support through the soc
tree.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
