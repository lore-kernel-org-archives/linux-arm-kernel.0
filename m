From: shiraz.linux.kernel@gmail.com (shiraz hashim)
Date: Mon, 14 Feb 2011 09:07:34 +0530
Subject: reboot not working on linux-2.6.37 for ARMv7
In-Reply-To: <AANLkTim1-0ipuM+8w5-AiTi74x5ghZ66o72WrOjhN94s@mail.gmail.com>
References: <AANLkTi=FCJr-0aF0LG92PC4Q7J4R5PDU7xobnvCgDHy8@mail.gmail.com>
	<20110211120305.GD23404@n2100.arm.linux.org.uk>
	<AANLkTikvBRJyDJb4=puFzbTCXNYGSEXDRkAZ=1PZuneD@mail.gmail.com>
	<AANLkTim1-0ipuM+8w5-AiTi74x5ghZ66o72WrOjhN94s@mail.gmail.com>
Message-ID: <AANLkTinckD5ZToBo2QZj3rBv8PtUUj2vqLRe=KXVSUB4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rabin,

On Sun, Feb 13, 2011 at 9:26 AM, Rabin Vincent <rabin@rab.in> wrote:
> On Sat, Feb 12, 2011 at 21:45, viresh kumar <viresh.linux@gmail.com> wrote:
>> We are not modifying flush_cache_all. L2 cache is not flushed from
>> there. ?Actually as soon as L1 Cache is flushed and disabled,
>> spin_lock is taken from some other thread. This creates problem for
>> our platform, as we do not have monitors support at L2 thus failing
>> strex instruction.
>
> Do you use writel() in your arch_reset() routine (as plat-spear appears
> to be doing)? ?There's a spinlock in there too (l2x0_cache_sync(), via
> the barriers) which will also not work in your situation.

You are right. Changed this to writel_relaxed and picked
28e18293cf0f8d23a0950d7b1d2212d11af494dc. Now it is working fine.

-- 
regards
Shiraz Hashim
