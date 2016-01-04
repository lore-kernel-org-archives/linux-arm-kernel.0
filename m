From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Jan 2016 16:15:32 +0100
Subject: [PATCH 2/2] arm: configs: add kvm_defconfig
In-Reply-To: <1451919034-12846-3-git-send-email-andre.przywara@arm.com>
References: <1451919034-12846-1-git-send-email-andre.przywara@arm.com>
 <1451919034-12846-3-git-send-email-andre.przywara@arm.com>
Message-ID: <4522790.HLBFMYIalT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 January 2016 14:50:34 Andre Przywara wrote:
> This new config enables KVM (and thus LPAE) on top of
> multi_v7_defconfig. This creates a kernel that can _host_ KVM guests,
> for guests a multi_v7_defconfig with virtio drivers is sufficient.
> Since LPAE kernels are not compatible with non-LPAE capable hardware,
> this has to be separate from the existing multi_v7_defconfig.
> 
> The purpose of this new defconfig is both to simplify creation of KVM
> host kernels as well as to give the LPAE option some better testing
> coverage, as the enlarged dma_addr_t and phys_addr_t types create some
> headache to some drivers.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 

I agree about the purpose, but I want something better here:

* Use config fragments to just set the few extra options that
  we can't enable otherwise, and have a shared config file
  with the normal multi_v7. There is still an ongoing question
  about big-endian defconfig, which has exactly the same problem,
  and we should have a common approach for all combinations.

  We might also want to do this in a way that lets us build
  v6/v6k/v7/v7ve/v8 kernels in big-endian and little-endian
  all from the same defconfig file, with the set of platforms
  getting smaller as we go to higher arch levels.

* I really want to see the ARMv7VE dependencies sorted out.

	Arnd
