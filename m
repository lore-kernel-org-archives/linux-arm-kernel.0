From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 24 Oct 2017 17:53:56 +0800
Subject: [PATCH v4 15/21] KVM: arm64: Set an impdef ESR for Virtual-SError
 using VSESR_EL2.
In-Reply-To: <59EE0A2F.8050703@arm.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-16-james.morse@arm.com>
 <CAMj-D2AMy1_SPrLGti9U=oz1JvBDHvRAMsBtw51B3JK0omLyXg@mail.gmail.com>
 <59EE0A2F.8050703@arm.com>
Message-ID: <9fbee52d-5090-9409-d07a-335acc059878@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 2017/10/23 23:26, James Morse wrote:
> If you're suggesting Qemu should set a default 'unknown' ESR for use when KVM
> doesn't know what to do, and SError is pretty much its only option:
> 
> Why would Qemu set anything other than impdef:all-zeros?
> 
> The only use would be to fake this back into a RAS error. Qemu isn't involved
> here so this can't be used to emulate NOTIFY_SEI without the kernel support. We
> don't have support for emulating the RAS ERR registers either, so this can't be
> used to emulate kernel first.
> 
> 
> If you're suggesting Qemu should specify a set of ESR values for the different
> cases where KVM doesn't know what do: this would be an early shortcut that burns
> us in the future, these things are going to be changed. This is too specific to
> KVMs internals:
> 
> When we add NOTIFY_SEI support, we will call out of this KVM code and APEI
> should 'claim' any SError that arrived with CPER records.
> 
> I expect this code to change dramatically if/when we add kernel first support.
> 
> 
> The KVM patches on the end of this series are just the minimum needed to enable
> IESB and keep the status quo for all other behaviour. And this is just so we can
> tackle the other bits of support that depends on the cpufeature without
> reposting all the same code.

Thanks very much for your explanation, understand it now.
