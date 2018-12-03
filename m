Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F3BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:29:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B29020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kQvA0W2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B29020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B0wxCkLnUc2JC+u3o8sdXP4uNuN1Mqg0eUluUenQLNU=; b=kQvA0W2oxgLqOg
	fLIR+wyhyhR1p23pgSbSBtD1RPtMazXC7EIZ6fJfpACPtUf7+24dudjoXJVxq812JvYUgNLZajuHp
	3WWTUzqYwhZqxFxPMOhHT8Q/uOqfAGDLsLqcrc5slm+MGQvcCwrTq1dxIhYBe2yZcSdFI+HXggc4Y
	sPHWvntazdw9k9ybkYSS6me4STyNXmfRVpNQzbcPULU4471/GCySn+8ZrXv+hmAA4Rc77YaXNYK4R
	U7If7w9dtrV3wZiHkCkWkT+77JHM3ruVXLYG2SjNLysPoFhCt4RwEnj+VPzR0Huuc7JQWDfG3xlpQ
	ffCpU0Y3cWebqym+yGIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlTe-0007VJ-0i; Mon, 03 Dec 2018 10:29:22 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlTa-0007Uu-7r
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 10:29:19 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB3AT49e076240;
 Mon, 3 Dec 2018 04:29:04 -0600
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB3AT4tB017445
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 04:29:04 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 3
 Dec 2018 04:29:04 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 3 Dec 2018 04:29:04 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB3AT1jf027429;
 Mon, 3 Dec 2018 04:29:02 -0600
Subject: Re: [GIT PULL] DaVinci fixes for v4.20
To: Olof Johansson <olof@lixom.net>
References: <fc5a2899-f847-5193-2406-2672713aa400@ti.com>
 <20181130195516.t53j6ui7szcvq6uf@localhost>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <62333206-5e21-195c-ef57-ab8c1ed0bccb@ti.com>
Date: Mon, 3 Dec 2018 15:59:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130195516.t53j6ui7szcvq6uf@localhost>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_022918_355119_115A8969 
X-CRM114-Status: GOOD (  17.39  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Olof,

On 01/12/18 1:25 AM, Olof Johansson wrote:
> On Tue, Nov 27, 2018 at 05:48:28PM +0530, Sekhar Nori wrote:
>> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
>>
>>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.20
>>
>> for you to fetch changes up to 27df7977099c2b8d32399cd1752f527c5a343dfa:
>>
>>   ARM: davinci: dm644x: set the GPIO base to 0 (2018-11-27 13:43:27 +0530)
>>
>> ----------------------------------------------------------------
>> DaVinci: fix GPIO breakage after v4.19
>>
>> This set of changes is needed to fix the broken GPIO support
>> for DaVinci boards in legacy mode after certain changes made to the
>> GPIO driver in 4.19, namely: commits 587f7a694f01 ("gpio: davinci: Use
>> dev name for label and automatic base selection") and eb3744a2dd01
>> ("gpio: davinci: Do not assume continuous IRQ numbering").
> 
> Hm. How long until we can remove the legacy boards and move them to DT? Is
> anyone working on it?

I think we are a bit far from that. The limited resources available to
work on DaVinci are being used to update frameworks. We moved to common
clock framework this year across all 6 supported SoCs. My plan for next
year is to move to sparse IRQ and get DaVinci included in
multi_v5_defconfig. Also move timer drivers to clocksource.

Even in cases where we do have device-tree support for the SoC (like
DA850), getting rid of board files completely involves writing some
additional drivers for board specific functionality. This I think is the
main bottleneck.

But I have not given up on getting there completely. The progress is
slow, though.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
