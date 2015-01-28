From: sumit.semwal@linaro.org (Sumit Semwal)
Date: Wed, 28 Jan 2015 19:00:46 +0530
Subject: [PATCH v3] dma-buf: cleanup dma_buf_export() to make it easily
 extensible
In-Reply-To: <20150128112339.164c55fd@recife.lan>
References: <1422449643-7829-1-git-send-email-sumit.semwal@linaro.org>
 <20150128112339.164c55fd@recife.lan>
Message-ID: <CAO_48GH3CVPeGUfDTuOgGfYmBnc1CvwVc5GYS6O3=275o0SwCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

On 28 January 2015 at 18:53, Mauro Carvalho Chehab
<mchehab@osg.samsung.com> wrote:
> Em Wed, 28 Jan 2015 18:24:03 +0530
> Sumit Semwal <sumit.semwal@linaro.org> escreveu:
>
>> +/**
>> + * helper macro for exporters; zeros and fills in most common values
>> + */
>> +#define DEFINE_DMA_BUF_EXPORT_INFO(a)        \
>> +     struct dma_buf_export_info a = { .exp_name = KBUILD_MODNAME }
>> +
>
> I suspect that this will let the other fields not initialized.
>
> You likely need to do:
>
> #define DEFINE_DMA_BUF_EXPORT_INFO(a)   \
>         struct dma_buf_export_info a = {        \
>         .exp_name = KBUILD_MODNAME;             \
>         .fields = 0;                            \
> ...
> }
I suspected the same, but Daniel kindly referred to the C99 standard,
which states:
" If there are fewer initializers in a brace-enclosed list than there
are elements or members
of an aggregate, or fewer characters in a string literal used to
initialize an array of known
size than there are elements in the array, the remainder of the
aggregate shall be
initialized implicitly the same as objects that have static storage duration."

So I think we're well covered there?
>
> Regards,
> Mauro



-- 
Thanks and regards,

Sumit Semwal
Kernel Team Lead - Linaro Mobile Group
Linaro.org ? Open source software for ARM SoCs
