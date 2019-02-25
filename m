Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F8DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:55:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C2E2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="blnvNYv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C2E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MeBt6pI4oV1QZcdCPhWq3P1wT4wgMzyMd7MWuXcEzpw=; b=blnvNYv6fwR0om
	DWAA44MADi3SrSeZctbTHBhYxHrqZcYTnxk1gXzguxFJ5UBss1b0ZChxkyZVimW5KweoP44RSZ6A7
	g7WUPtyToIZixqfZZFvCf2jDKjEi2jBZ2ReGKAIgPepULZvOsiYhaNRrHeOKXz6X9iYkt/AbGi5Rb
	ZajzkZn3kmFisF1hxAoPn/zek8/Srj9KazPoCK5/jTnfoehf8Cfa5DOwWPOFeTzhGPkO/5IHa9Ttd
	ZdFcB6T8SVgTzX2VK5bi10aTWjKA5Hv/sZBeq1bew2B7PzB1TsW0Fx8i2TTflKPRlRci3o5zD+5gY
	bj0NM0RE/m+Bxd/xgnVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyLP8-000848-MT; Mon, 25 Feb 2019 18:55:06 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyLP5-0007XR-Au
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 18:55:04 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Feb 2019 10:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,412,1544515200"; d="scan'208";a="117679809"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146])
 ([10.122.105.146])
 by orsmga007.jf.intel.com with ESMTP; 25 Feb 2019 10:55:01 -0800
Subject: Re: [PATCH 2/2] ARM: socfpga_defconfig: enable EDAC by default
To: Dinh Nguyen <dinguyen@kernel.org>, bp@alien8.de, linux@armlinux.org.uk,
 mchehab@kernel.org, james.morse@arm.com
References: <1550602799-22737-1-git-send-email-thor.thayer@linux.intel.com>
 <1550602799-22737-3-git-send-email-thor.thayer@linux.intel.com>
 <ed55288c-458a-b770-423e-3691c020f840@kernel.org>
From: Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <78bd26f7-861b-0493-c8ed-ccb7a6673825@linux.intel.com>
Date: Mon, 25 Feb 2019 12:57:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ed55288c-458a-b770-423e-3691c020f840@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_105503_392364_4DDD502F 
X-CRM114-Status: GOOD (  15.54  )
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
Reply-To: thor.thayer@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-edac@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/25/19 11:36 AM, Dinh Nguyen wrote:
> Hi Thor,
> 
> On 2/19/19 12:59 PM, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Enable the different ECC blocks by default on Cyclone5
>> and Arria10.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>>   arch/arm/configs/socfpga_defconfig | 36 ++++++++++++++++++++++--------------
>>   1 file changed, 22 insertions(+), 14 deletions(-)
>>
> 
> Looks like you did a 'make savedefconfig' on this as well? can you
> please rebase your patch to the arm/defconfig on the arm-soc tree?
> 
> Thanks,
> Dinh
> 
Yes. I'll send a V2 shortly. Thanks for reviewing.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
