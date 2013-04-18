From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 18 Apr 2013 17:59:43 +0200
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <51701084.5050706@codeaurora.org>
References: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
 <51701084.5050706@codeaurora.org>
Message-ID: <217a4f2dd017af16204391012751e9f9@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Apr 2013 11:25:56 -0400, Christopher Covington
<cov@codeaurora.org> wrote:
> Hi Pranavkumar,
> 
> On 04/18/2013 01:52 AM, PranavkumarSawargaonkar wrote:
>> From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> 
>> This patch implements early printk support for virtio-mmio console
>> devices
>> without using any hypercalls.
> 
> Is it possible that using DCC might be an easier solution?

You would end up with the exact same problem as with a hypercall based
solution: once you're in the hypervisor, what do you do with the data? You
end up having to invent another channel to forward it down to your platform
emulation in order to have it printed where the user expects it.

Using a MMIO based solution is probably the best solution, as it uses the
existing infrastructure.

        M.
-- 
Fast, cheap, reliable. Pick two.
