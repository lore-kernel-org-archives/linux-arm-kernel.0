From: drjones@redhat.com (Andrew Jones)
Date: Thu, 15 Mar 2018 15:46:51 +0100
Subject: [PATCH v6 21/26] arm64: KVM: Reserve 4 additional instructions
 in the BPI template
In-Reply-To: <20180314165049.30105-22-marc.zyngier@arm.com>
References: <20180314165049.30105-1-marc.zyngier@arm.com>
 <20180314165049.30105-22-marc.zyngier@arm.com>
Message-ID: <20180315144651.w4egshvglf5jwrbi@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 04:50:44PM +0000, Marc Zyngier wrote:
> So far, we only reserve a single instruction in the BPI template in
> order to branch to the vectors. As we're going to stuff a few more
> instructions there, let's reserve a total of 5 instructions, which
> we're going to patch later on as required.
> 
> We also introduce a small refactor of the vectors themselves, so that
> we stop carrying the target branch around.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kernel/bpi.S | 39 +++++++++++++++------------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
