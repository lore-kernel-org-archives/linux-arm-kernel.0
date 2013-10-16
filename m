From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Oct 2013 17:25:15 -0700
Subject: [PATCH 0/3] KVM: ARM: Cortex-A7 support and fixes
In-Reply-To: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
References: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <20131016002515.GF20547@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 04:49:25PM +0100, Jonathan Austin wrote:
> This series adds support for using KVM on ARM Cortex-A7 CPUs. As the Cortex-A7
> is architecturally identical to the A15 there is not a huge amount of code
> required, however there are a number of fixups necessary to core KVM code that
> testing on A7 has revealed.
> 
> I'm open to comments about other ways to share the functionality between A7/A15
> while still maintaining the architectural/implementation defined split that
> existed between coproc.c and coproc_a15.c - The approach in this series avoids
> adding '3 levels' of abstraction and feels like a good compromise that doesn't
> require duplication of a lot of the A15 code for A7 but still permits
> implementation differences to be fully expressed in coproc_X files.
> 
> This patch series has been developed/tested on TC2 with the A15 cluster held in
> reset.
> 
Tested on Cubieboard2 and applied to kvm-arm-next.

Thanks,
-Christoffer
