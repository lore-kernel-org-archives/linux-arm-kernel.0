Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C48EC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:38:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35322081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="USj6r4hF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="khbw9s5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35322081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kce9MhA2S99tb6deqTojLMLMlIEoxoTrJ0q9SiOvZFw=; b=USj6r4hF7GVHKa
	60ad+IUqwCdhv6KuxX5SFu+2QyRHi6MT8SCyEpfj1TfxRToHJcqAhGd0Xq99IyGa6fQd1Wsw75ya2
	9lnhmAfp/fftM1fv/H4laBCNzZxLmqQPiTYEXXJllBfx++yNCnZFTwwdHnoFRTBKQ27krxBmQpaNV
	A12lmySjijHlDyCw+EMyaBKMhPqBIEWIKYbF1EGpqYgxl5EXhz5SnnyAqnSmVpwDtY+uurjboS/Fw
	dcwPl5iPpPYuuUX8zcsGZRYmSD3x9zJDcofX9mRzShBHVDA6mBcOXQTFH6kgNsPhmyeS8E7wKXDSN
	/Kdkshm+v8B02YllpJOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVwTX-0006m0-FY; Sun, 09 Dec 2018 10:38:15 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVwTT-0006lG-A7
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 10:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V28/jOgEw0hSqFM6gCHI4O7G2a25ciSSb3eLB7lLxH0=; b=khbw9s5mqaGpgqu5dCT0qs5Tt
 Cr6A5Zovk6sCyycQ1MT/KMIVtVmEuNPP9UmLBZ03KjFxnW7FK4uQU8Q4qsHj4ius+D3vZ69ikt08x
 ksav6ojQlSdHZloeLY4hlNYqV0mBcn4h5leXKu5XpjFWDnmv7Z1Nmo7Gx4+wszJoJBMpU=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:48890)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gVwT5-0002Pc-Hd; Sun, 09 Dec 2018 10:37:47 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gVwT0-0001yd-Q6; Sun, 09 Dec 2018 10:37:42 +0000
Date: Sun, 9 Dec 2018 10:37:40 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3] ARM: smp: add support for per-task stack canaries
Message-ID: <20181209103740.GB30658@n2100.armlinux.org.uk>
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <201812091807.4emRkZ7L%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201812091807.4emRkZ7L%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_023811_513289_86D84CBE 
X-CRM114-Status: GOOD (  19.76  )
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
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
 Emese Revfy <re.emese@gmail.com>, kbuild-all@01.org,
 Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 09, 2018 at 06:28:11PM +0800, kbuild test robot wrote:
> Hi Ard,
> 
> I love your patch! Perhaps something to improve:

Hi,

This looks to me like a false warning - how can a patch touching arch
code affect the result of lib/test_ubsan.c?  Please can you double-
check this result?

Thanks.

> 
> [auto build test WARNING on arm/for-next]
> [also build test WARNING on v4.20-rc5]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/ARM-smp-add-support-for-per-task-stack-canaries/20181209-033321
> base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> 
> All warnings (new ones prefixed by >>):
> 
>    lib/test_ubsan.c: In function 'test_ubsan_vla_bound_not_positive':
> >> lib/test_ubsan.c:48:2: warning: ISO C90 forbids variable length array 'buf' [-Wvla]
>      char buf[size];
>      ^~~~
>    lib/test_ubsan.c: In function 'test_ubsan_out_of_bounds':
> >> lib/test_ubsan.c:64:2: warning: ISO C90 forbids variable length array 'arr' [-Wvla]
>      volatile int arr[i];
>      ^~~~~~~~
> 
> vim +/buf +48 lib/test_ubsan.c
> 
> 854686f4 Jinbum Park 2018-04-10  44  
> 854686f4 Jinbum Park 2018-04-10  45  static void test_ubsan_vla_bound_not_positive(void)
> 854686f4 Jinbum Park 2018-04-10  46  {
> 854686f4 Jinbum Park 2018-04-10  47  	volatile int size = -1;
> 854686f4 Jinbum Park 2018-04-10 @48  	char buf[size];
> 854686f4 Jinbum Park 2018-04-10  49  
> 854686f4 Jinbum Park 2018-04-10  50  	(void)buf;
> 854686f4 Jinbum Park 2018-04-10  51  }
> 854686f4 Jinbum Park 2018-04-10  52  
> 854686f4 Jinbum Park 2018-04-10  53  static void test_ubsan_shift_out_of_bounds(void)
> 854686f4 Jinbum Park 2018-04-10  54  {
> 854686f4 Jinbum Park 2018-04-10  55  	volatile int val = -1;
> 854686f4 Jinbum Park 2018-04-10  56  	int val2 = 10;
> 854686f4 Jinbum Park 2018-04-10  57  
> 854686f4 Jinbum Park 2018-04-10  58  	val2 <<= val;
> 854686f4 Jinbum Park 2018-04-10  59  }
> 854686f4 Jinbum Park 2018-04-10  60  
> 854686f4 Jinbum Park 2018-04-10  61  static void test_ubsan_out_of_bounds(void)
> 854686f4 Jinbum Park 2018-04-10  62  {
> 854686f4 Jinbum Park 2018-04-10  63  	volatile int i = 4, j = 5;
> 854686f4 Jinbum Park 2018-04-10 @64  	volatile int arr[i];
> 854686f4 Jinbum Park 2018-04-10  65  
> 854686f4 Jinbum Park 2018-04-10  66  	arr[j] = i;
> 854686f4 Jinbum Park 2018-04-10  67  }
> 854686f4 Jinbum Park 2018-04-10  68  
> 
> :::::: The code at line 48 was first introduced by commit
> :::::: 854686f4edf483db1e0d26d972bdb8fb65c8bfaa lib: add testing module for UBSAN
> 
> :::::: TO: Jinbum Park <jinb.park7@gmail.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
