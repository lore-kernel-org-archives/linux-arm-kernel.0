Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C827DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:22:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7212080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dsVRDvp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7212080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8/3sJvsthDG1sEOxD31ox2gkaj5wd7BZQsMB2ONnzv4=; b=dsVRDvp9lo7yYo
	ImO13hs+eS2VYYLF9gjcFM/1GzKawwwhY2HorKEon3z4WvhKJL77VRRdlMzFHEZv5g2hvyxOKNDWJ
	yF/U+7naP1QqU4RK7dleDBP/FXQDIwptm8ESKPHcb1ybxLgxongubdOnHQHqRnYT3vRgCYcGPapwV
	ef+jqi/EKT/Sw7yd1TxZm0Uu39E5MshZxt1XhxiKm5Oe/10EijdUp7SOlbNoygK3Wa4RfyiHrjWuq
	bfalK1iyAKEBXF0/pazGc9w2PteJmfziYiPhMzwUZbukpinN415Mi9R2Or6joo0xIbtGto2a/8ZM4
	XO2ofk2CH38PWYni5E1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXvr0-00009C-7g; Fri, 14 Dec 2018 22:22:42 +0000
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXvqx-00008M-Et
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 22:22:40 +0000
Received: by mail-qk1-f195.google.com with SMTP id n12so4147361qkh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 14:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ptzu5u6SzlU1qt1JMcYLoIwHmQdgxDtWqilLc56jRmc=;
 b=HxRnbQw4gJoJySxxf+9ZXPgHk36/xcIPtGb0FW2AkviUq/7JnZ6lAW/7dNofof2eWP
 Z2gz0bqWl7b1synIojl/Vp9AIvhteYg+Xrr+/3kXkIGMjPTzx+UE6c67pBMPx0cHgnpo
 CcF/LNYBn1IkEdomKryFANr2KgWCJNYxri4WY+Fe4OQKjRWticK38ZfzgTdYA/g+YvrL
 2RQblm42hhy7uhoo0AVTdf/3OiycAxa0oYDGspA1wbHKiCDQ6FX3iQvNSml7q/p4kcYD
 uBPi+cS6dP9vWEG1GPnnL1RIfM5NTmIWOYJe90JX1zYvWnIPCoGk87UtCDlat33I994W
 gTWg==
X-Gm-Message-State: AA+aEWZ6lSpWgFfZ+DWcKFqfFcPYj7mnU+2zAn12JVA14Z4ab0zR8aJ/
 RsY1C1lRRmLEExX0OyCGqACX0kreukf0YPBEVEE=
X-Google-Smtp-Source: AFSGD/VNxDhP/5SWny1TsvNxUKuV1SOSu6cpl1vLFvguSsHzC7BVl2iaSU58ea0QpA14FwkTOayszKjV1n2MVdOQ6fU=
X-Received: by 2002:a37:9a89:: with SMTP id c131mr4391181qke.173.1544826148019; 
 Fri, 14 Dec 2018 14:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20181210204514.2362328-1-arnd@arndb.de>
 <20181214.132300.832860946069084294.davem@davemloft.net>
In-Reply-To: <20181214.132300.832860946069084294.davem@davemloft.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 14 Dec 2018 23:22:10 +0100
Message-ID: <CAK8P3a3ZC_1C2pVYcLEe1y0=__YsapF+rZWKjLZ9hyUucyLT+A@mail.gmail.com>
Subject: Re: [PATCH] w90p910_ether: remove incorrect __init annotation
To: David Miller <davem@davemloft.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_142239_494254_E733B875 
X-CRM114-Status: GOOD (  16.13  )
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
Cc: Networking <netdev@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Wan ZongShun <mcuos.com@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 10:23 PM David Miller <davem@davemloft.net> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Mon, 10 Dec 2018 21:45:07 +0100
>
> > The get_mac_address() function is normally inline, but when it is
> > not, we get a warning that this configuration is broken:
> >
> > WARNING: vmlinux.o(.text+0x4aff00): Section mismatch in reference from the function w90p910_ether_setup() to the function .init.text:get_mac_address()
> > The function w90p910_ether_setup() references
> > the function __init get_mac_address().
> > This is often because w90p910_ether_setup lacks a __init
> >
> > Remove the __init to make it always do the right thing.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Actually I think we can validly mark w90p910_ether_setup() and
> w90p910_probe() with appropriate init tagging.  None of these
> functions are invoked outside of the probing paths.

But then we have to change the driver to use
module_platform_driver_probe(), to ensure we cannot
unbind/rebind the device. I usually don't like doing that,
unless the device can never be stopped after it has
been initialized.

       Arnd

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
