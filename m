Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBA5C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:54:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592D8208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bANTe7SB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="C+lWUgz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592D8208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LwNQ8Ko1zPjV+AnmB+6s/sjOdLh1Xuo4uZD2YnWhv44=; b=bANTe7SB9m7Um+
	ulzjYTfTyoWmxAPXjjZs+8SX75/NGisHynjLSQakWKPA3B0X8Oot6hdzBOzXo8z7PD9W6BW/4a6PM
	Sc4DXLeCgNmMy5kySDj1bCTIe7KMNjx2s9O96m18Vr912QPoEhuHO3pC29EiNWy4hP6ebo9op4ofk
	XsjUTGD+FgO/MgMympBJdbdA2bIlDf1SVe7Mu95T3wyUCxiACgKOLR+IM/+QYNEfDWqJ9s5zKRSyW
	ZKwk060awoVPoV+o8CApyK8uLVlQ/vlx7R1vxmcCk6RHSAe/Kzs8k9GcwI5osl5HaOdpy8qe3zxAe
	Bbq4KLVeLXDZIeJPlQ9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXmzA-0000xC-QK; Fri, 14 Dec 2018 12:54:32 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXmz7-0000wL-3b
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 12:54:30 +0000
Received: by mail-qt1-x841.google.com with SMTP id n21so6001823qtl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 04:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IDIsjugZ0+zssGZiEzloM69Wr9ndBpcxgmyaXzGXaYU=;
 b=C+lWUgz1Qa2uLWK7CBUlqEANjVXgXT5vc2wsszMWa1T9mhk+HTvHFt3ABke/BR1gSO
 v532aIQ3/JWAylTyaccSRKGIwl3+AfzJxTylrT58DpohjwNjzK3dFOkKWt2cxMQiXqgC
 Qx3Y2alogh8ipu+gFHQg0dUUEMViRGo/744TtTFK17fp18eu9tizePWXXBsUttijmLZH
 66PEPwI0efiZRT+SKVJR4X0lqvK5daG2XB0RNYT4hQF4ea2GZ+hXj7WfAD2jO5jaxUkf
 Sc9Gv/s10onufDcYJvJ18Twi/+PbnPvKIlx9pp2CvpzgITN/AMB1EURnGqRkipbsMV+m
 R2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IDIsjugZ0+zssGZiEzloM69Wr9ndBpcxgmyaXzGXaYU=;
 b=MSLU7BaYaLP7tJHa+n+jlQczlSnaYOuQ+6WRBS4rV0Mfo6jBEoIZVdtfzWdItzTC+S
 ZqXwXGrAkBDL+pUZRYCrM/wFeowy9X/zYOzoIfbjiv+Qxah21VMGUY9R4Owl6C3w7re5
 kdclzU+OnvKOkKR61QQoOv2kD1Zbp+j3N6TRAQ27iUcM/lvgvuaU9ZbDA1tQpzZcyo/5
 reMqhtl5d3kb9GfIhNNwzVswqP3/YDC7JtVqDylrpnQvwot3H0NW22vMwtdgueqIr0mz
 fRUL2KBRZeILm+Dzjh2bhFUCs6LYwPc/29Wum2JdnP/iChmw60IVi4CENH2p+0l6YoKb
 XWuQ==
X-Gm-Message-State: AA+aEWYwB0RmAQ0UiE9vlarVWSXC7tL8Jkidywk0x22BYijg7RIfO22J
 /HFNXGhGP+FiKuZyWSCQqmiGZmw0xDI=
X-Google-Smtp-Source: AFSGD/U0s2exQhAvJ4ZK6CQBRYoy9LXBMxPBiztLWItKxcGZeWpRCcq0okgWxI/AN/k5W6XnLZnqVg==
X-Received: by 2002:aed:358b:: with SMTP id c11mr2458884qte.155.1544792057645; 
 Fri, 14 Dec 2018 04:54:17 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id t43sm3846017qtc.53.2018.12.14.04.54.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 04:54:17 -0800 (PST)
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
To: Bhupesh Sharma <bhsharma@redhat.com>
References: <20181213052259.56352-1-cai@lca.pw>
 <20181214040819.58625-1-cai@lca.pw>
 <CACi5LpNQ1WGE54uv35OwNmJkKR_xnqTNqFK+R9oFBVkb683z_Q@mail.gmail.com>
From: Qian Cai <cai@lca.pw>
Message-ID: <fad4c4e5-73e3-c264-511b-f4f28b7e16f3@lca.pw>
Date: Fri, 14 Dec 2018 07:54:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CACi5LpNQ1WGE54uv35OwNmJkKR_xnqTNqFK+R9oFBVkb683z_Q@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_045429_203184_D5F9FB70 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 kexec mailing list <kexec@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/14/18 12:01 AM, Bhupesh Sharma wrote:
> Not sure why I can't reproduce on my HPE Apollo machine, so a couple
> of questions:
> 1. How many CPUs do you enable in the kdump kernel - do you pass
> 'nr_cpus=1' to the kdump kernel to limit the maximum number of cores
> to 1 in the kdump kernel?

Yes

> 2. Which firmware version do you use on your board?

Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
        Vendor: American Megatrends Inc.
        Version: L50_5.13_1.0.6
        Release Date: 07/10/2018
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 64 MB
        Characteristics:
                PCI is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                Boot from CD is supported
                Selectable boot is supported
                BIOS ROM is socketed
                ACPI is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
                UEFI is supported
        BIOS Revision: 6.3

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
