From: drjones@redhat.com (Andrew Jones)
Date: Wed, 21 Feb 2018 18:35:42 +0100
Subject: [PATCH v4 09/40] KVM: arm64: Move debug dirty flag calculation
 out of world switch
In-Reply-To: <20180215210332.8648-10-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-10-christoffer.dall@linaro.org>
Message-ID: <20180221173542.3fi4pkqy222tp2vw@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:01PM +0100, Christoffer Dall wrote:
> There is no need to figure out inside the world-switch if we should
> save/restore the debug registers or not, we might as well do that in the
> higher level debug setup code, making it easier to optimize down the
> line.
> 
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/debug.c        | 5 +++++
>  arch/arm64/kvm/hyp/debug-sr.c | 6 ------
>  2 files changed, 5 insertions(+), 6 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
