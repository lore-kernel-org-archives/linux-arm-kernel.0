From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 14 Mar 2013 11:21:32 +0200
Subject: [RFC 1/1] clk: Add notifier support in
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1363227311.3311.30.camel@bilhuang-vm1>
References: <1363091861-21534-1-git-send-email-bilhuang@nvidia.com>
 <20130312134032.GU4977@n2100.arm.linux.org.uk>
 <1363139273.21694.11.camel@bilhuang-vm1>
 <514003B6.8020904@wwwdotorg.org>
 <1363151317.3311.9.camel@bilhuang-vm1>
 <51400D9D.9060305@wwwdotorg.org>
 <1363153204.3311.14.camel@bilhuang-vm1>
 <5140C12A.4060900@wwwdotorg.org>
 <1363227311.3311.30.camel@bilhuang-vm1>
Message-ID: <20130314092132.GE18519@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 03:15:11AM +0100, Bill Huang wrote:

> I don't think deferring will work either, considering the usage of DVFS,
> device voltage is tightly coupled with frequency, when clock rate is
> about to increase, we have to boost voltage first and we can lower the
> voltage after the clock rate has decreased. All the above sequence have
> to be guaranteed or you might crash, so deferring not only make thing
> complicated in controlling the order but also hurt performance.

But we could use notifiers in clk_prepare/clk_unprepare to set the voltage no?
As clk_prepare/clk_unprepare have to be called before clk_enable or after
clk_disable, the voltage can be raised to a safe level, before the clock
becomes active.

Cheers,

Peter.
