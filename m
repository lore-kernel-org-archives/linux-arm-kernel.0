Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921A4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:04:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF62206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OqOIb8+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF62206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U0dMwT1870XunbnK4XU9cel5sm4z32FJPsEv+ZbPwnI=; b=OqOIb8+gYRhHx6
	plIo0iIfH9pVc/FhWJqPyjVvfDCyUrDQjiLzXqF2D/s1z+VwP+sZ8++7wjjRCO/eis+T0iEP7GDZe
	Qimv0+bigh1Z/F2ldcROjRJZikkqsQ9abfpOOLbUSxoOvvhurhFknjnXbaPWi3An5wIJwyq+FToEn
	16ZYiNF5zt5Mc5lzcZMJbM1SJqy90Ji9ieVlX5i5YIWMFnvSOtmLeXRv7I7GC96hFWzNxuKpKUQRw
	SY+TEpwI7nmaqaw6ZU1mOPgv5MoS91fN8I7gbtW4QZfj7a4506cW0v6gDu6/cbUubkNLqmaub01sL
	3Fpw9YmfmhECjMt2CVdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gud9n-0004FA-SK; Fri, 15 Feb 2019 13:03:55 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gud9g-0004Er-TK
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:03:54 +0000
Received: by mail-qk1-f193.google.com with SMTP id h28so1783440qkk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lElDiBMdOy1Uxgz5GkTFkzXq4enoL2Me24zFn0nM/oM=;
 b=Tyzecs+F8hNaN+R39PfEqQ/o+atUIRvYFxEpD2JHqxNgLsrjraoRWBjDfEAWWOEjlY
 siP2Tcz5McLa8W5lDzFRsDSH7P7zdHZLbuQNyTiBhsGFV7CRR651YLqAMPUHwqxC7nnY
 xN3HW0U3GMuEADjyG+m9yPYwrYp2Zs0uWx/6nuLauZ2f3ZT+GY9FsKSD1/q1Y4Yzgpo/
 5rJK1Xo+2Ef4seja8QH+Qj8NM4ldzVTxwqObDWUb2hw3byJnF5dkhfqhKrxnYgvsOlj2
 kWTWy+NX1RfIX7UUihsecuHQQ1lfRb3ZdvFkmAj4xVs2CgeSQcNWVJ2pqQ0OcCto/dBP
 0Ctw==
X-Gm-Message-State: AHQUAuZ/WgBiv+h8u8JY99COeFtsLdImWCIC10eMZoY+DO3AO292ucke
 KmSkEiZh86Lf775c2P1pNvBZX24M3VHcEoVnx50fig==
X-Google-Smtp-Source: AHgI3IbyT/8zx1lmqW3H8Jor8BGf/NgX8Qdq6GRV76BqW/4/UgX+Zg8f3bBhdeKh1UiYSKmXVJb9CFRmNJ4FJv2SgWc=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr6556210qkf.107.1550235827589; 
 Fri, 15 Feb 2019 05:03:47 -0800 (PST)
MIME-Version: 1.0
References: <7a019c48-b470-1897-44de-a63642e7717c@ti.com>
In-Reply-To: <7a019c48-b470-1897-44de-a63642e7717c@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 14:03:31 +0100
Message-ID: <CAK8P3a2X6TdXw+nnncCxbw6LicDOAz3DmHb7qpx2fGU2rqmH8g@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: TI AM65x changes for v5.1
To: Tero Kristo <t-kristo@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_050348_941361_B69BCE10 
X-CRM114-Status: UNSURE (   7.14  )
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
Cc: Nishanth Menon <nm@ti.com>, "tony@atomide.com" <tony@atomide.com>,
 arm-soc <arm@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Faiz Abbas <faiz_abbas@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 11:25 AM Tero Kristo <t-kristo@ti.com> wrote:
> ----------------------------------------------------------------
> AM65x DT changes for v5.1. Includes:
>
> - EMMC support for am654-evm board
>

Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
