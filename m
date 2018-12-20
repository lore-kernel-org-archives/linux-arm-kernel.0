Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F1DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:32:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94512186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AQNfvs7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94512186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1tQ3E494nMtSYK45GHfcCwOMgGlZFTc2gcYkGUYq370=; b=AQNfvs7Qzi+wS7
	6+POM6UmGyDGFTBkLWUT99+D7Vwt5nlFT3lpDuszYRhNbtCi/GL8iW6CvFKhNsloK5orcaxwNON32
	8YFb98KpzcDBsc4IvFiArVKSC34TUhmdmTtUXvrJMgwCzMSWdFQPxEBvTw8w3DAvcBlp/xlJVGR1n
	eOialZnKNa9yFBMiTmHv+3UeMp4L5dnof677lq+Pk7TdrK6G4ocl7Bt21vSHhEwQBZYri9qekLFUG
	3IgzDd3gMt9dqZ6OcHd+aPI5MXKKDJNV/l1v/J+bLeGy/YCiZGxKWwva3j5NkA9L+B7Ku6tjU4K0k
	XRnGZ0yl0mu6geb4Ic0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0JQ-0005h4-Qp; Thu, 20 Dec 2018 15:32:36 +0000
Received: from mail-qk1-f177.google.com ([209.85.222.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0JN-0005f0-Em
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:32:34 +0000
Received: by mail-qk1-f177.google.com with SMTP id y78so1198033qka.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3j924bRCx98yTuSEFW9jC/POjxrkzP4q7l9GkRmSe7k=;
 b=cOVZ0Vzlgj/XIcF0Oiin0xuvH3YMo3N08uyahgJTtMe76Ymh6kT6LGrvHQ0yo7fh47
 JnU6vvrihM2pevBG1sqy+IOZxRwW8DA1KgaIpn90Bke81yUZeYeVC96XCc8hMYA7f1K2
 9mgH4RwgrFWXREUDOweBDVlRMTqK3P7j0VfsG9WfEypCDKYpfXFubSsoqLhdunjbbqYe
 kd4ppvZ1YKALqXt4Ul5X3lnRA5vfTNGqSR9rNwKd52XD9uiryL2efva0JbaEkryQSXT9
 YbM3R6t//XwZw+fKuHgncr77iN5lr5Fu92qMH15jPLdUW8qgYrC+ctglgtGvyHWAzU15
 qxBw==
X-Gm-Message-State: AA+aEWZBQ+eUOKDJGG38d/IePRgCsHK/hG24NmC9vLdgz3fJbLEgD6R/
 k65aQvKewk/VS3GkAzWQ16AY42xCu4JBtqnUj82K05qQ
X-Google-Smtp-Source: AFSGD/U/5ng2uKUb4U6Z6Fi13rvmJ/ktrIewxef/0FGTvo5fphIAd3LQpuDZoULPsXVpLGnyh1ofctFbiBhFZcCJXsM=
X-Received: by 2002:a37:324a:: with SMTP id y71mr6597234qky.291.1545319942223; 
 Thu, 20 Dec 2018 07:32:22 -0800 (PST)
MIME-Version: 1.0
References: <d180b7d0-398a-e3d7-97c2-a2b5716da252@monstr.eu>
In-Reply-To: <d180b7d0-398a-e3d7-97c2-a2b5716da252@monstr.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 16:32:04 +0100
Message-ID: <CAK8P3a0oQZ9Pv8JU-6E1cKXHnjN2+VZEb-v9kG12voFbi1-HyA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: Xilinx SoC changes for v5.0
To: Michal Simek <monstr@monstr.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_073233_491766_A8374535 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 4:26 PM Michal Simek <monstr@monstr.eu> wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
>
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
>
> are available in the git repository at:
>
>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-v5.0
>
> for you to fetch changes up to d1d4445abffb2b17e841d37b555b6f1364b571c1:
>
>   arm64: dts: zynqmp: Fix node names which contain "_" (2018-11-16
> 09:17:49 +0100)
>
> ----------------------------------------------------------------
> arm64: dts: zynqmp: DT changes for v5.0
>
> - Fix node names
> - Fix wakeup-source
> - Wire ddrc
> - Label gpio controller (PS gpio)

Pulled into next/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
