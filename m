Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABBFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:59:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2941320855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gfp7hadF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2941320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Kid1jFdQMc7f2JPPlD4XYBSJorQ0pl7NjmPUPVFfuuw=; b=Gfp7hadFj/H0neDBIWUVxoqy0
	PrsdzT+7D2AMKZX2piBoghz/Q8usvEr4FVgZUE9LZgC6wDGA1b8nCau0Qpzt6b/jiVTCq5jcDRDn7
	xB++/v8L6Syrjp1mTNTSKzmV4OzlgLtUCw5wIdx62a468LOvmbn9MFtN+nR3Gg0eUm8hRUFeg5Bld
	86Crboiv6zgiaQXY3jkO4ycTZkdzp1+zQ94kdZBZg6c5mo5alRL3LYH2WoFlUJ4Fu5uzjHF+wZ2EU
	AdtGs8Ml7aDJZ7clkGla818YTl0Y7MdIbJapaGYyuyBMtWcfP3Lx9x3blKKfDKsOElFBwz92s7x/s
	FeuFJ+ECg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbPpG-0003Qx-Ft; Mon, 24 Dec 2018 12:59:18 +0000
Received: from www1102.sakura.ne.jp ([219.94.129.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbPpC-0003Pd-LZ; Mon, 24 Dec 2018 12:59:16 +0000
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBOCwq86075783;
 Mon, 24 Dec 2018 21:58:52 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Mon, 24 Dec 2018 21:58:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.2] (183.38.232.153.ap.dti.ne.jp [153.232.38.183])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBOCwpXv075780
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
 Mon, 24 Dec 2018 21:58:52 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: enable analog audio node for rock64
To: Heiko Stuebner <heiko@sntech.de>
References: <20181223101026.12998-1-katsuhiro@katsuster.net>
 <16987084.rf60fZEaYD@phil>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <df1c3cb9-5661-724d-4443-5b19930f4348@katsuster.net>
Date: Mon, 24 Dec 2018 21:58:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <16987084.rf60fZEaYD@phil>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_045914_941940_84586FA9 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Heiko,

I understand. Thanks a lot!

Best Regards,
Katsuhiro Suzuki

On 2018/12/24 16:16, Heiko Stuebner wrote:
> Hi,
> 
> Am Sonntag, 23. Dezember 2018, 11:10:26 CET schrieb Katsuhiro Suzuki:
>> The Rock64 boards has analog audio jack on it. RK3328 can output
>> analog audio signal using I2S1 and ACODEC core.
>>
>> This patch adds sound node for analog audio for Rock64.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> I've put a patch collecting the sound-dai-cells in rk3328.dtsi
> before this one, dropped the sound-dai-cells from here and
> applied the patch for 4.22.
> 
> Thanks
> Heiko
> 
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
