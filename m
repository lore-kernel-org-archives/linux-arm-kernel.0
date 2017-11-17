From: liuwenliang@huawei.com (Liuwenliang (Abbott Liu))
Date: Fri, 17 Nov 2017 07:18:45 +0000
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <87375eqobb.fsf@on-the-bus.cambridge.arm.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-2-liuwenliang@huawei.com>
 <227e2c6e-f479-849d-8942-1d5ff4ccd440@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063172@dggemm510-mbs.china.huawei.com>
 <8e959f69-a578-793b-6c32-18b5b0cd08c2@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063545@dggemm510-mbs.china.huawei.com>
 <87a7znsubp.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063587@dggemm510-mbs.china.huawei.com>
 <bbf43f92-3d0c-940d-b66b-68f92eb9b282@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C00635F3@dggemm510-mbs.china.huawei.com>
 <87po8ir1kg.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C006371B@dggemm510-mbs.china.huawei.com>
 <87375eqobb.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0063816@dggemm510-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/11/17  22:41 Marc Zyngier [mailto:marc.zyngier at arm.com] wrote:
>No, it doesn't. It cannot work, because Cortex-A9 predates the invention
>of the 64bit accessor. I suspect that you are testing stuff in QEMU,
>which is giving you a SW model that always supports LPAE. I suggest you
>test this code on *real* HW, and not only on QEMU.

I am sorry. My test is fault. I only defined TTBR0 as __ACCESS_CP15_64,
but I don't use the definition TTBR0 as __ACCESS_CP15_64. 

Now I use the definition TTBR0 as __ACCESS_CP15_64 on CPU supporting
LPAE(vexpress_a9), I find it doesn't work and report undefined instruction error
when execute "mrrc" instruction.

So, you are right that 64bit accessor of TTBR0 cannot work on LPAE.
