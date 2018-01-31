From: drjones@redhat.com (Andrew Jones)
Date: Wed, 31 Jan 2018 11:54:31 +0100
Subject: [PULL 01/28] arm64: KVM: Hide PMU from guests when disabled
In-Reply-To: <20180131093507.22219-2-christoffer.dall@linaro.org>
References: <20180131093507.22219-1-christoffer.dall@linaro.org>
 <20180131093507.22219-2-christoffer.dall@linaro.org>
Message-ID: <20180131105431.fsvyaeffujzwh2lu@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 10:34:40AM +0100, Christoffer Dall wrote:
> From: Andrew Jones <drjones@redhat.com>
> 
> Since commit 93390c0a1b20 ("arm64: KVM: Hide unsupported AArch64 CPU
> features from guests") we can hide cpu features from guests. Apply
> this to a long standing issue where guests see a PMU available, but
> it's not, because it was not enabled by KVM's userspace.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>

Hi Christoffer,

I think this patch got into the PULL by mistake, because you pointed out
to me a while back that it broke migration.

Thanks for the reminder to go and try to fix it though!

Thanks,
drew
