From: drjones@redhat.com (Andrew Jones)
Date: Thu, 22 Feb 2018 16:54:12 +0100
Subject: [PATCH v4 34/40] KVM: arm64: Cleanup __activate_traps and
 __deactive_traps for VHE and non-VHE
In-Reply-To: <20180215210332.8648-35-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-35-christoffer.dall@linaro.org>
Message-ID: <20180222155412.nsumvgntzcpodawv@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:26PM +0100, Christoffer Dall wrote:
> To make the code more readable and to avoid the overhead of a function
> call, let's get rid of a pair of the alternative function selectors and
> explicitly call the VHE and non-VHE functions using the has_vhe() static
> key based selector instead, telling the compiler to try to inline the
> static function if it can.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/hyp/switch.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
