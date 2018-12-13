Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FF7C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:53:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7534520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iD6dfKBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7534520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tGzuJYHEfrLyvRMWYpBtHfAgdnr0i3CNmYHvqiiZ7U4=; b=iD6dfKBIk3J92VOWbFyt3PGeE
	PWUj4YwRs1Y/9RvCdwsS8dbLHr7vNAEJ66ikyH1EE2Bt7GA4KxcdCD8Bha8W8ceBrA+NIiUlOEv3o
	1vW2JKcdcWfKqj64kZm2rrvAiK3iKEqx2ikjqm9TDQR98KPl/ex3VWhEHnpScAdREjxx4WlFFQj/C
	l6/Lbl1PodDrbrf59rTSirPGd6JQZTOECFoe7/2+3Opgp/uairjAa3jIGn8e57iggPZxBOI2jXY+q
	M8aa1TgC2xyqB9/EcB5BnEHoUq5MorJZ9onqk/soW/g9NJ1MPkdZyzHorDn2gwah8+81IjfJCxxA5
	0CdRrK6ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXH7z-0002Qp-R7; Thu, 13 Dec 2018 02:53:31 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXH7v-0002MS-T0
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 02:53:29 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Dec 2018 18:53:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; d="scan'208";a="129501976"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
 by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2018 18:53:15 -0800
Subject: Re: [kbuild-all] [PATCH v3] ARM: smp: add support for per-task stack
 canaries
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 kbuild test robot <lkp@intel.com>
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <201812091807.4emRkZ7L%fengguang.wu@intel.com>
 <20181209103740.GB30658@n2100.armlinux.org.uk>
From: Rong Chen <rong.a.chen@intel.com>
Message-ID: <47a91e5a-0e97-334c-2f36-a0bd966a0050@intel.com>
Date: Thu, 13 Dec 2018 10:53:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20181209103740.GB30658@n2100.armlinux.org.uk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_185327_954658_CDCD6879 
X-CRM114-Status: GOOD (  23.86  )
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 kernel-hardening@lists.openwall.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 Emese Revfy <re.emese@gmail.com>, kbuild-all@01.org,
 Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/09/2018 06:37 PM, Russell King - ARM Linux wrote:
> On Sun, Dec 09, 2018 at 06:28:11PM +0800, kbuild test robot wrote:
>> Hi Ard,
>>
>> I love your patch! Perhaps something to improve:
> Hi,
>
> This looks to me like a false warning - how can a patch touching arch
> code affect the result of lib/test_ubsan.c?  Please can you double-
> check this result?

Hi,

I'm sorry for the trouble, It's a false warning, we will look into it.

Best Regards,
Rong Chen

> Thanks.
>
>> [auto build test WARNING on arm/for-next]
>> [also build test WARNING on v4.20-rc5]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/ARM-smp-add-support-for-per-task-stack-canaries/20181209-033321
>> base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
>> config: arm-allmodconfig (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          GCC_VERSION=7.2.0 make.cross ARCH=arm
>>
>> All warnings (new ones prefixed by >>):
>>
>>     lib/test_ubsan.c: In function 'test_ubsan_vla_bound_not_positive':
>>>> lib/test_ubsan.c:48:2: warning: ISO C90 forbids variable length array 'buf' [-Wvla]
>>       char buf[size];
>>       ^~~~
>>     lib/test_ubsan.c: In function 'test_ubsan_out_of_bounds':
>>>> lib/test_ubsan.c:64:2: warning: ISO C90 forbids variable length array 'arr' [-Wvla]
>>       volatile int arr[i];
>>       ^~~~~~~~
>>
>> vim +/buf +48 lib/test_ubsan.c
>>
>> 854686f4 Jinbum Park 2018-04-10  44
>> 854686f4 Jinbum Park 2018-04-10  45  static void test_ubsan_vla_bound_not_positive(void)
>> 854686f4 Jinbum Park 2018-04-10  46  {
>> 854686f4 Jinbum Park 2018-04-10  47  	volatile int size = -1;
>> 854686f4 Jinbum Park 2018-04-10 @48  	char buf[size];
>> 854686f4 Jinbum Park 2018-04-10  49
>> 854686f4 Jinbum Park 2018-04-10  50  	(void)buf;
>> 854686f4 Jinbum Park 2018-04-10  51  }
>> 854686f4 Jinbum Park 2018-04-10  52
>> 854686f4 Jinbum Park 2018-04-10  53  static void test_ubsan_shift_out_of_bounds(void)
>> 854686f4 Jinbum Park 2018-04-10  54  {
>> 854686f4 Jinbum Park 2018-04-10  55  	volatile int val = -1;
>> 854686f4 Jinbum Park 2018-04-10  56  	int val2 = 10;
>> 854686f4 Jinbum Park 2018-04-10  57
>> 854686f4 Jinbum Park 2018-04-10  58  	val2 <<= val;
>> 854686f4 Jinbum Park 2018-04-10  59  }
>> 854686f4 Jinbum Park 2018-04-10  60
>> 854686f4 Jinbum Park 2018-04-10  61  static void test_ubsan_out_of_bounds(void)
>> 854686f4 Jinbum Park 2018-04-10  62  {
>> 854686f4 Jinbum Park 2018-04-10  63  	volatile int i = 4, j = 5;
>> 854686f4 Jinbum Park 2018-04-10 @64  	volatile int arr[i];
>> 854686f4 Jinbum Park 2018-04-10  65
>> 854686f4 Jinbum Park 2018-04-10  66  	arr[j] = i;
>> 854686f4 Jinbum Park 2018-04-10  67  }
>> 854686f4 Jinbum Park 2018-04-10  68
>>
>> :::::: The code at line 48 was first introduced by commit
>> :::::: 854686f4edf483db1e0d26d972bdb8fb65c8bfaa lib: add testing module for UBSAN
>>
>> :::::: TO: Jinbum Park <jinb.park7@gmail.com>
>> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
