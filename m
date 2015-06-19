From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Jun 2015 15:55:44 +0100
Subject: [PATCH] arm64: vdso: work-around broken ELF toolchains in Makefile
In-Reply-To: <55842B92.4090702@mentor.com>
References: <1434718593-3648-1-git-send-email-will.deacon@arm.com>
 <55842B92.4090702@mentor.com>
Message-ID: <20150619145544.GA8173@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 03:47:46PM +0100, Nathan Lynch wrote:
> On 06/19/2015 07:56 AM, Will Deacon wrote:
> > When building the kernel with a bare-metal (ELF) toolchain, the -shared
> > option may not be passed down to collect2, resulting in silent corruption
> > of the vDSO image (in particular, the DYNAMIC section is omitted).
> 
> I checked arch/arm with
> 
> arm-none-eabi-gcc (Fedora 4.9.2-3.fc21) 4.9.2
> 
> and it doesn't seem to be affected.  Do you know whether the toolchain
> issue is aarch64-specific?

I don't know for sure, but it seems to affect all AArch64 toolchains so
from your observations, arch/arm/ should be ok.

Will
