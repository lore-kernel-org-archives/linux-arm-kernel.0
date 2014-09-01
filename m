From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 10:49:09 +0200
Subject: [SMP BUG?] the return value of is_smp() is bug?
In-Reply-To: <1409571334-2814-1-git-send-email-long.wanglong@huawei.com>
References: <1409571334-2814-1-git-send-email-long.wanglong@huawei.com>
Message-ID: <2846720.hM0WuNVsDY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014 19:35:34 Wang Long wrote:
> In kernel 3.17-rc2, when i set CONFIG_HAVE_SMP = y and CONFIG_SMP_ON_UP = y 
> in .config file. the secondary core can not boot.
> 
> when i set CONFIG_HAVE_SMP = y and CONFIG_SMP_ON_UP = n in .config file,
> the secondary core can boot.
> 
> But this does not happen in kernel 3.10 lts kernel, Whether the 
> CONFIG_SMP_ON_UP is set yes or no ,the secondary core can boot.
> 
> Does the meaning of CONFIG_SMP_ON_UP changed or this is a bug in kernel 3.17-rc2 ? 
> 
> 
> I write the following patch to test the return value of is_smp().
> 

Can you check the value of CONFIG_SMP?

CONFIG_HAVE_SMP is set by platforms that allow enabling SMP, but you
still have the choice to set CONFIG_SMP on or off.

	Arnd
