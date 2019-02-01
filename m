Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E523C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:02:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F3320870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZ5XZraz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XnoGovwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F3320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=X16cCXH/L16HpHiaVdFRezqj4Y1SLDirEOPC0tBdMg8=; b=ZZ5XZrazvRfGqc
	vpQE2XVesJQ8oorHFcfHvfHI9nV5GEDnfUXTr17ciXLOAOYlzLYTc8JMXJkaezFLpNo2rw8RvEaEr
	vPs9dxkwajcTlQR+PG5NxnjL422s97KdBsT4T/ZF08U1XrhYKX6W+AaKxRfnh+IIvDwWm/+hgJKXz
	cisq2OB5uROw7T+5+dxZcwxHrQF75RwJZrdPbepMTBidJtAe5k5iJMk/cO8O+T1PzTtG/+xcjBa1G
	N6L3tJmhv1D72HcymHLSPtzuYx1iPY67Rhajx8ERMQHKn57guhBo+Eo+0J7NfXIWRmrmeoGJy01Fn
	ahK01PyeNhmC8YZf5BXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpQ1f-0008I2-7i; Fri, 01 Feb 2019 04:01:59 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpQ1a-0008Hl-KB
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 04:01:56 +0000
Received: by mail-qt1-x831.google.com with SMTP id v11so6102691qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 20:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=Rdp3pHP45aRk1PFGSfH3Qf0uwiN5bZp70dfVXxztC/M=;
 b=XnoGovwQxTTnEUOYgF1bl7N5xyfab0fiF4Iw0uabKJtKQrNfjBUvFVroKXDhFE2+mx
 IuN3ahpSvX2GnaSmhnkCNVEjgs9t3IjHYW4+zv7Ntsw8QHQW1CSvB8+h1Sf++38nlQ7c
 7bECWnT/bhsYb/OCf4LO1B4Hu9xTJkirFxIAsg+5mmSd43RSY8K/IoExBVNWomUNrExc
 /DJbNRHQVw8LwDA6Al2YMXbkajWb5lZzA03xvVazBr0dgtGZmr0Ydlbfxs0MrrxGJhWU
 ShM7bkm7hqWn4JHh3GBK67yFNQSflmaFEgUp2Rrqp7jW5lMXVie4vokEfjq3uxJghQBj
 EsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=Rdp3pHP45aRk1PFGSfH3Qf0uwiN5bZp70dfVXxztC/M=;
 b=b3obneaWH0xTrUfj1KveSk6FuHed0zz7Jzp/Rctx825eXvNuJeqIis6318djbrIKV2
 R9V/w58+Z2xsCNfTuSiOQLCElcXVZDCzSeEkKwJOYXb6gK4WKj2JNHk8VJuAfWKZenG9
 GJkOVvyXHz8nLRiX1tv7OTI7xT+Yi2sw86HTpeDWQG4I1at1cFO4d/m1bccY5u2ASQwl
 LovfvpGkQaH+xP3jwqlrA6edCpCivI3t9CPehXuUslk1HdqvE0ogaRxqniXBU3hj2U7U
 vfiVvfRwQ3MGr0AV8WHYxU+/U9PV6jpkqOoACLPT4onDxmaxR+uxcWLSKXTwoqXUYUdF
 IwoQ==
X-Gm-Message-State: AJcUukfjfoIt7qpfgEUNEykV7MWcVV3IgPVauoeoQm+n2i621y1AoTue
 zK+x24qDA8UCXaHBDfPadWpyQ76jo88=
X-Google-Smtp-Source: ALg8bN7uExdS73zA7fhRSAWiCZsdTIrvvzAUuFGcDXl3tcVuc5e50ewTF3iFSiC9sST2IlmmFpY1Jg==
X-Received: by 2002:ac8:1b34:: with SMTP id y49mr37835739qtj.374.1548993712679; 
 Thu, 31 Jan 2019 20:01:52 -0800 (PST)
Received: from ovpn-120-54.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id p72sm4843241qke.87.2019.01.31.20.01.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 20:01:52 -0800 (PST)
To: steve.capper@arm.com
From: Qian Cai <cai@lca.pw>
Subject: kernel_page_tables issue with CONFIG_ARM64_USER_VA_BITS_52=y
Message-ID: <fe7fa86a-42ed-ee58-be26-4d8ae45fadab@lca.pw>
Date: Thu, 31 Jan 2019 23:01:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_200154_712947_AD191A6B 
X-CRM114-Status: UNSURE (   7.86  )
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
 Will Deacon <will.deacon@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On this ThunderX2 server with both,
CONFIG_ARM64_USER_VA_BITS_52=y
CONFIG_ARM64_PTDUMP_DEBUGFS=y

kernel_page_tables could only print out linear mappings.

# cat /sys/kernel/debug/kernel_page_tables
---[ Kasan shadow start ]---
---[ Kasan shadow end ]---
---[ Modules start ]---
---[ Modules end ]---
---[ vmalloc() area ]---
---[ vmalloc() end ]---
---[ Fixmap start ]---
---[ Fixmap end ]---
---[ PCI I/O start ]---
---[ PCI I/O end ]---
---[ vmemmap start ]---
---[ vmemmap end ]---
---[ Linear mapping ]---
0x000e000000000000-0x000e040001000000     4194320M PTE       ro NX SHD AF
    UXN MEM/NORMAL
0x000e0400011a0000-0x000e040001270000         832K PTE       RW NX SHD AF
    UXN MEM/NORMAL
0x000e040001280000-0x000e0400012e0000         384K PTE       RW NX SHD AF
    UXN MEM/NORMAL
...
0x000e809718f10000-0x000e809718f30000         128K PTE       RW NX SHD AF
    UXN MEM/NORMAL
0x000e809718f30000-0x000e809718f40000          64K PTE F     RW NX SHD AF
    UXN MEM/NORMAL
0x000e809718f40000-0x000e80977d000000     1639168K PTE       RW NX SHD AF
    UXN MEM/NORMAL

Using CONFIG_ARM64_VA_BITS_48=y instead makes everything pretty.

---[ Kasan shadow start ]---
0xffff000000000000-0xffff040001000000     4194320M PTE       ro NX SHD AF
    UXN MEM/NORMAL
0xffff0400011a0000-0xffff040001250000         704K PTE       RW NX SHD AF
    UXN MEM/NORMAL
0xffff040001270000-0xffff0400012e0000         448K PTE       RW NX SHD AF
    UXN MEM/NORMAL
...
0xffff100000050000-0xffff10000fe00000      259776K PTE       RW NX SHD AF
    UXN MEM/NORMAL
0xffff100100000000-0xffff1001f0000000        3840M PTE       RW NX SHD AF
    UXN MEM/NORMAL
0xffff1010f0000000-0xffff1012efa00000        8186M PTE       RW NX SHD AF
    UXN MEM/NORMAL
---[ Kasan shadow end ]---
---[ Modules start ]---
0xffff200008d00000-0xffff200008d10000          64K PTE       ro x  SHD AF
    UXN MEM/NORMAL
0xffff200008d10000-0xffff200008d20000          64K PTE       ro NX SHD AF
    UXN MEM/NORMAL
0xffff200008d20000-0xffff200008d40000         128K PTE       RW NX SHD AF
    UXN MEM/NORMAL
...
0xffff200009780000-0xffff200009790000          64K PTE       ro x  SHD AF
    UXN MEM/NORMAL
0xffff200009790000-0xffff2000097a0000          64K PTE       ro NX SHD AF
    UXN MEM/NORMAL
0xffff2000097a0000-0xffff2000097c0000         128K PTE       RW NX SHD AF
    UXN MEM/NORMAL
---[ Modules end ]---
---[ vmalloc() area ]---
0xffff200010000000-0xffff200010010000          64K PTE       RW NX SHD AF
    UXN DEVICE/nGnRE
0xffff200010020000-0xffff200010040000         128K PTE       RW NX SHD AF
    UXN DEVICE/nGnRE
0xffff200010050000-0xffff200010060000          64K PTE       ro NX SHD AF
    UXN MEM/NORMAL
...
0xffff200030000000-0xffff200038000000         128M PTE       RW NX SHD AF
    UXN DEVICE/nGnRnE
0xffff7bd3ff5e0000-0xffff7bd401fe0000          42M PTE       RW NX SHD AF
    UXN MEM/NORMAL
0xffff7bdffd5f0000-0xffff7bdfffff0000          42M PTE       RW NX SHD AF
    UXN MEM/NORMAL
---[ vmalloc() end ]---
---[ Fixmap start ]---
0xffff7fdffe7f0000-0xffff7fdffe800000          64K PTE       RW NX SHD AF
    UXN DEVICE/nGnRE
0xffff7fdffe800000-0xffff7fdffe810000          64K PTE       ro NX SHD AF
    UXN MEM/NORMAL
---[ Fixmap end ]---
---[ PCI I/O start ]---
---[ PCI I/O end ]---
---[ vmemmap start ]---
0xffff7fe000000000-0xffff7fe000200000           2M PTE       RW NX SHD AF
    UXN MEM/NORMAL
0xffff7fe002000000-0xffff7fe003e00000          30M PTE       RW NX SHD AF
    UXN MEM/NORMAL
0xffff7fe021e00000-0xffff7fe025e00000          64M PTE       RW NX SHD AF
    UXN MEM/NORMAL
---[ vmemmap end ]---
---[ Linear mapping ]---
0xffff800000310000-0xffff800000480000        1472K PTE F     RW NX SHD AF
    UXN MEM/NORMAL
0xffff800000480000-0xffff800001480000          16M PTE       ro NX SHD AF
    UXN MEM/NORMAL
0xffff800001480000-0xffff800002250000       14144K PTE F     RW NX SHD AF
    UXN MEM/NORMAL
...
0xffff8097189e0000-0xffff809718b20000        1280K PTE       RW NX SHD AF
    UXN MEM/NORMAL
0xffff809718b20000-0xffff809718b30000          64K PTE F     RW NX SHD AF
    UXN MEM/NORMAL
0xffff809718b30000-0xffff80977d000000     1643328K PTE       RW NX SHD AF
    UXN MEM/NORMAL

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
