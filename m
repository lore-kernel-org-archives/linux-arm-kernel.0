From: cdall@linaro.org (Christoffer Dall)
Date: Sat, 21 Oct 2017 17:04:29 +0200
Subject: [RESEND PATCH 0/2] arm/arm64: kvm: Disable branch profiling in
 HYP code
In-Reply-To: <1508499257-10014-1-git-send-email-julien.thierry@arm.com>
References: <1508499257-10014-1-git-send-email-julien.thierry@arm.com>
Message-ID: <20171021150429.GC12618@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 12:34:15PM +0100, Julien Thierry wrote:
> [Resending for Christoffer and adding kvmarm to recipients]
> 
> Hi,
> 
> When enabling branch profiling, a lockup occurs at boot time, after
> displaying: "kvm [1]: Hyp mode initialized successfully"
> 
> The issue is caused by the Hyp code getting instrumented and trying to
> access unmapped code or data, which happens when trying to initialize EL2.
> 
> So it also seems like KVM is misleadingly announcing it was initialized and
> yet gets stuck during initialization.
> 
> * First patch deals with printing the initialization message once KVM has
>   fully initialized Hyp mode
> * Second patch actually disables branch profiling instrumentation in Hyp
>   code

Applied, thanks.

-Christoffer
