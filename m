From: sumit.semwal@linaro.org (Sumit Semwal)
Date: Wed, 28 Jan 2015 17:57:28 +0530
Subject: [PATCH v2] dma-buf: cleanup dma_buf_export() to make it easily
 extensible
In-Reply-To: <54C8C612.1030701@linaro.org>
References: <1422424845-14906-1-git-send-email-sumit.semwal@linaro.org>
 <54C8C612.1030701@linaro.org>
Message-ID: <CAO_48GF7CQvY4dF4RoXytSkAQPf-AMsO9Co_UvpS4hr4TY_Wig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2015 at 16:50, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> On 28/01/15 06:00, Sumit Semwal wrote:
<snip>
>> +/**
>> + * helper macro for exporters; zeros and fills in most common values
>> + */
>> +#define DEFINE_DMA_BUF_EXPORT_INFO(a)                        \
>> +     struct dma_buf_export_info a = {0};             \
>> +     exp_info.exp_name = KBUILD_MODNAME
>> +
>
> This risks generating C99 warnings unless used with care (and only once
> per function). Shouldn't this be more like:
>
> #define DEFINE_DMA_BUF_EXPORT_INFO(a) \
>     struct dma_buf_export_info a = { .exp_name = KBUILD_MODNAME }
>

Ah! My bad; thanks for catching this, Daniel; I'll send out the
updated patch in a minute!
> Daniel.
>



-- 
Thanks and regards,

Sumit Semwal
Kernel Team Lead - Linaro Mobile Group
Linaro.org ? Open source software for ARM SoCs
