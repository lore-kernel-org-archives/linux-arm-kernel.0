Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AFFC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 03:14:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC4F20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 03:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p1f0teSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC4F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v/B8CLDOsWdZqBt7xbNWqc2oleRd9i8Z8lHYlD7QD+k=; b=p1f0teSfwvDBb6
	BSe0989w6AGqx/nDgYDtkV6+DBxNAzGRDl9oTIyhrYuEiaK0RcbkNwBqMN5Q6phxtMRGUZb9OmTMQ
	LCwZUloI871atdfb9YGJMvhkPBY6VinV0q2sel00vbGpt6Ad8rsuYZ8O4ehOMXgMoTqmTo60VYLmP
	FpmqhZzY40Nr+ZkFCOpj6gMLTZ+BH1zvo6De9SaFK48jhSBtOgo4n0V1TuSlpz4a/YX00lzjNMXBu
	tMZryC5TkZAQ5O7bCrBrJUhJA18Nllz70MwRq8dqKGJhobUI/ZxXEq+DIjW7pO9DkEdKfobX+eUuo
	fjpqSa3hhGe/Sv0r5oWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnxNn-0007HR-7f; Mon, 28 Jan 2019 03:14:47 +0000
Received: from regular1.263xmail.com ([211.150.99.137])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnxNj-0007Gw-DP; Mon, 28 Jan 2019 03:14:45 +0000
Received: from huangtao?rock-chips.com (unknown [192.168.167.153])
 by regular1.263xmail.com (Postfix) with ESMTP id 18356212;
 Mon, 28 Jan 2019 11:14:35 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.62] (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P18171T140704284124928S1548645272799817_; 
 Mon, 28 Jan 2019 11:14:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <1de1742e5d7f1c4892cde975e98f0e26>
X-RL-SENDER: huangtao@rock-chips.com
X-SENDER: huangtao@rock-chips.com
X-LOGIN-NAME: huangtao@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [Bug] Rockchip crypto driver sometimes produces wrong ciphertext
To: Eric Biggers <ebiggers@kernel.org>
References: <20190126210530.GB709@sol.localdomain>
 <CAKv+Gu-RKu9jt+2FnV2529zqyLGR8RSu8r4B8eOs-7Om-pL0aQ@mail.gmail.com>
 <1894799.pWIprST79S@phil>
From: Tao Huang <huangtao@rock-chips.com>
Message-ID: <f7a0d04c-339e-d9f8-7188-a27d55ad8b4d@rock-chips.com>
Date: Mon, 28 Jan 2019 11:14:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1894799.pWIprST79S@phil>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_191443_814660_BD9BB53A 
X-CRM114-Status: GOOD (  11.53  )
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
Cc: Zain Wang <wzz@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Zhang Zhijie <zhangzj@rock-chips.com>, linux-rockchip@lists.infradead.org,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Olof Johansson <olof@lixom.net>,
 ezequiel@collabora.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Eric and Heiko:

>> On Sat, 26 Jan 2019 at 22:05, Eric Biggers <ebiggers@kernel.org> wrote:
>>>
>>> Hello,
>>>
>>> I don't know whether anyone is actually maintaining the Rockchip crypto driver
>>> in drivers/crypto/rockchip/, but it's failing the improved crypto tests
>>> that I currently have out for review: https://patchwork.kernel.org/cover/10778089/

Zhang Zhijie, engineer from Rockchip, will try to fix this software bug.

>>>
>>> See the boot logs for RK3288 from the KernelCI job here:
>>>
>>> https://storage.kernelci.org/ardb/for-kernelci/v5.0-rc1-86-geaffe22db9d1/arm/multi_v7_defconfig/lab-collabora/boot-rk3288-rock2-square.txt
>>> https://storage.kernelci.org/ardb/for-kernelci/v5.0-rc1-86-geaffe22db9d1/arm/multi_v7_defconfig/lab-collabora/boot-rk3288-veyron-jaq.txt
>>>
>>> alg: skcipher: ecb-aes-rk encryption test failed (wrong result) on test vector 0, cfg=\"random: use_digest src_divs=[15.64%@+3258, 84.36%@+4059] dst_divs=[69.11%@+1796, 8.49%@+4027, 6.34%@+1, 16.6%@+4058] iv_offset=21\"
>>> alg: skcipher: cbc-aes-rk encryption test failed (wrong result) on test vector 0, cfg=\"random: may_sleep use_digest src_divs=[100.0%@alignmask+3993] dst_divs=[65.31%@alignmask+1435, 34.69%@+14]\"
>>> alg: skcipher: ecb-des-rk encryption test failed (wrong result) on test vector 0, cfg=\"random: may_sleep use_final src_divs=[<flush> 66.52%@+11, 33.48%@+1519] dst_divs=[58.82%@+1, 19.43%@+4082, 21.75%@+8]\"
>>> alg: skcipher: cbc-des-rk encryption test failed (wrong result) on test vector 0, cfg=\"random: may_sleep use_finup src_divs=[100.0%@+3980] dst_divs=[60.4%@+3763, 23.9%@+4011, 16.87%@+4046]\"
>>> alg: skcipher: ecb-des3-ede-rk encryption test failed (wrong result) on test vector 0, cfg=\"random: may_sleep use_digest src_divs=[100.0%@+4] dst_divs=[47.25%@+19, 14.83%@+22, 37.92%@+31]\"
>>> alg: skcipher: cbc-des3-ede-rk encryption test failed (wrong result) on test vector 0, cfg=\"two even aligned splits\"
>>>
>>> In other words: the ecb-aes-rk, cbc-aes-rk, ecb-des-rk, cbc-des-rk,
>>> ecb-des3-ede-rk, and cbc-des3-ede-rk algorithms are failing because they produce
>>> the wrong ciphertext on some scatterlist layouts.
>>>
>>> You can reproduce by pulling from
>>> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
>>> branch "testmgr-improvements", unsetting CONFIG_CRYPTO_MANAGER_DISABLE_TESTS,
>>> setting CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y, rebooting and checking dmesg.
>>>
>>> Note that I don't have this hardware myself, so if it turns out that no one is
>>> interested in fixing this anytime soon I'll instead have to propose disabling
>>> these algorithms until they can be fixed.
>>>
>>> Thanks,
>>>
>>> - Eric
>>
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
