From: julien.grall@linaro.org (Julien Grall)
Date: Thu, 18 Jul 2013 18:20:52 +0100
Subject: [Xen-devel] [PATCH] xen/arm: disable cpuidle when linux is
 running as dom0
In-Reply-To: <alpine.DEB.2.02.1307171426300.8258@kaball.uk.xensource.com>
References: <1373898101-15633-1-git-send-email-julien.grall@linaro.org>
 <20130715152532.GC5774@phenom.dumpdata.com>
 <alpine.DEB.2.02.1307171426300.8258@kaball.uk.xensource.com>
Message-ID: <CAPnVf8xuQJpXv+D8QNqhdz=Pm8rvbWA-U0T-ZdC3Mye-KeLdGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2013 14:28, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> On Mon, 15 Jul 2013, Konrad Rzeszutek Wilk wrote:
>> On Mon, Jul 15, 2013 at 03:21:41PM +0100, Julien Grall wrote:
>> > When linux is running as dom0, Xen doesn't show the physical cpu but a
>> > virtual CPU.
>> > On some ARM SOC (for instance the exynos 5250), linux registers callbacks
>> > for cpuidle. When these callbacks are called, they will modify
>> > directly the physical cpu not the virtual one.
>> It can impact the whole board
>> > instead of dom0.
>
> Certainly this is something that should be fixed at the hypervisor level
> too. However I agree that Linux should try to avoid doing that when
> running on Xen.
>
>
>
>> Should you also call disable_cpufreq() ?
>
> Sounds like a good idea.
> Julien, could you add that to this patch?

I have checked with both the Arndale and Versatile Express without any issue.
I will resend this patch with disable_cpufreq().

-- 
Julien Grall
