From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 22 Feb 2017 20:28:38 +0100
Subject: [RFC 54/55] KVM: arm/arm64: Adjust virtual offset considering
 nesting
In-Reply-To: <1483943091-1364-55-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
 <1483943091-1364-55-git-send-email-jintack@cs.columbia.edu>
Message-ID: <20170222192838.GY26976@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jintack,

On Mon, Jan 09, 2017 at 01:24:50AM -0500, Jintack Lim wrote:
> The guest hypervisor sets cntvoff_el2 for its VM (i.e. nested VM).  Note
> that physical/virtual counter value in the guest hypervisor's point of
> view is already offsetted by the virtual offset set by the host
> hypervisor.  Therefore, the correct offset we need to write to the
> cntvoff_el2 is the sum of offset the host hypervisor initially has for
> the VM and virtual offset the guest hypervisor sets for the nested VM.

This appears to be the only timer patch in the series.  Should we not
also expose the EL2 timer to the VM and emulate that in software?

Thanks,
-Christoffer
