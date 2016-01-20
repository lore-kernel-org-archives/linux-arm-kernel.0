From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Jan 2016 11:54:37 +0000
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <20160120063856.GA3725@dhcp-128-65.nay.redhat.com>
References: <569CBDBC.5050500@linaro.org>
 <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
 <569F2439.9000604@linaro.org>
 <20160120063856.GA3725@dhcp-128-65.nay.redhat.com>
Message-ID: <20160120115436.GC25829@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 02:38:56PM +0800, Dave Young wrote:
> Maybe I did not say it clearly, I prefer kexec syscall/tool to modifiy dtb
> or uefi-memmap so that we do not need any extra kernel cmdline.

I am strongly opposed to modifying the FW-provided memroy map
information, for the reasons I expressed in other replies.

What are your concerns with a property under /chosen?

> For x86 we would like to drop the memmap= usage in kexec-tools but we can not
> do that for a compatibility problem about calgary iommu. So that currently
> kexec-tools supports both recreating E820 maps and passing memmap=.
> 
> We should think it carefully because it will be hard to remove once we support it.

I agree that we don't want a plethora of solutions that we have to
support forever.

> IMO handling it in code is better than using an external interface.

I'm not sure what you mean by this. What is the "external interface",
and which code do you beleive it is better to handle this in?

Thanks,
Mark.
