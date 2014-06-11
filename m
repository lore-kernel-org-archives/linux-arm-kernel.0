From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jun 2014 11:06:45 +0200
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <53981043.3010300@redhat.com>
References: <20140328184517.GA27219@cbox> <20140611065412.GA24286@lvm>
 <53981043.3010300@redhat.com>
Message-ID: <9801429.iblEns5zC3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 June 2014 10:16:03 Paolo Bonzini wrote:
> 
> > If kernels actually do use the UEFI runtime services and have no need
> > for direct access to an RTC when runing in a UEFI compliant system, then
> > I agree with not specifying the hardware details.
> 
> The RTC is not needed for ordinary operation of the kernel and, in the 
> current kernel, the EFI RTC driver is only used for IA64.  However, it 
> seems to be platform independent.  I'll give it a shot (on x86, since 
> that's the only architecture for which I know how to get UEFI firmware).

Using the EFI RTC seems appropriate for ARM, as it's a reasonable
abstraction that should work with any hypervisor. I suspect the only
reason we don't use it on x86 is that we know which RTC hardware we
have and the kernel comes with a mandatory driver already.

	Arnd
