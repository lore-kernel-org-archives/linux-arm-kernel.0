From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 18 May 2017 21:01:30 +0800
Subject: [PATCH] arm64: cpufeature: check translation granule size based
 on kernel config
In-Reply-To: <9db90634-6bb1-23e0-5cc8-19c02eceac04@arm.com>
References: <1495102873-10858-1-git-send-email-leo.yan@linaro.org>
 <c0c8bd7b-647d-092d-65ac-08a90000e30c@arm.com>
 <20170518113627.GC25294@leoy-ThinkPad-T440>
 <9db90634-6bb1-23e0-5cc8-19c02eceac04@arm.com>
Message-ID: <20170518130130.GD25294@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 01:39:12PM +0100, Suzuki K Poulose wrote:

[...]

> >>If we were to suppress the warning (more on that below), we could simply
> >>make this feature a NON_STRICT, since the unsupported CPUs won't boot
> >>with 16K to hit this sanity check.
> >>
> >>However, there is a problem with disabling this warning. If a VM starts
> >>using 16KB page size on a 4K/64K host, the VM could end up in unknown
> >>failures when it switches to an unsupported CPU (after it has booted).
> >>Of course the real fix lies in making the KVM exposing the safe value
> >>for granule support to the VCPUs (which is currently being worked on by
> >>Douglas in Cc). So, when we have that ready, we could make it NON_STRICT
> >>instead of this approach.
> >
> >Thanks for the info :)
> >
> >I will use below patch for production branch temporarily. You could
> 
> Which production branch do you mean above ? Is it something in your intenral
> repository ?

Yeah, I mean Hikey960 branch.

Thanks,
Leo Yan
