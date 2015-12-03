From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 3 Dec 2015 15:39:55 -0300
Subject: [PATCH v2 2/4] nvmem: NXP LPC18xx EEPROM memory NVMEM driver
In-Reply-To: <5649F856.9000101@linaro.org>
References: <1445275946-32653-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1445275946-32653-3-git-send-email-ariel@vanguardiasur.com.ar>
 <CAGhQ9Vyg6sScq7yM=7judsMPHOc5VF2zf=7LPxmbmL7wF=vvgw@mail.gmail.com>
 <562E2CB1.80706@linaro.org> <563385B2.90403@vanguardiasur.com.ar>
 <5649F74A.9020706@vanguardiasur.com.ar>
 <5649F856.9000101@linaro.org>
Message-ID: <CAAEAJfAqqni1UKiyftBE5kW-TegnuYvJrTvPkHm2gDbOuk4=Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

On 16 November 2015 at 12:37, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 16/11/15 15:33, Ariel D'Alessandro wrote:
>>>>
>>>>
>>>> >> >>-------------------------------->cut<----------------------------------
>>>> >> From 8cae10eff8ea8da9c5a8058ff75abeeddd8a8224 Mon Sep 17 00:00:00
>>>> >> 2001
>>>> >>From: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>>>> >>Date: Mon, 26 Oct 2015 13:30:24 +0000
>>>> >>Subject: [PATCH] nvmem: core: return error for non word aligned bytes
>>>> >>
>>>> >>nvmem providers have restrictions on register strides, so return error
>>>> >>code when users attempt to read/write buffers with sizes which are not
>>>> >>aligned to the word boundary.
>>>> >>
>>>> >>Without this patch the userspace would continue to try as it does not
>>>> >>get any error from the nvmem core, resulting in a hang.
>>>> >>
>>>> >>Signed-off-by: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>>>> >>---
>>>> >>  drivers/nvmem/core.c | 6 ++++++
>>>> >>  1 file changed, 6 insertions(+)
>>>> >>
>>>> >>diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>>> >>index 6fd4e5a..9d11d98 100644
>>>> >>--- a/drivers/nvmem/core.c
>>>> >>+++ b/drivers/nvmem/core.c
>>>> >>@@ -70,6 +70,9 @@ static ssize_t bin_attr_nvmem_read(struct file
>>>> >> *filp,
>>>> >>struct kobject *kobj,
>>>> >>      if (pos >= nvmem->size)
>>>> >>          return 0;
>>>> >>
>>>> >>+    if (count < nvmem->word_size)
>>>> >>+        return -EINVAL;
>>>> >>+
>>>> >>      if (pos + count > nvmem->size)
>>>> >>          count = nvmem->size - pos;
>>>> >>
>>>> >>@@ -95,6 +98,9 @@ static ssize_t bin_attr_nvmem_write(struct file
>>>> >> *filp,
>>>> >>struct kobject *kobj,
>>>> >>      if (pos >= nvmem->size)
>>>> >>          return 0;
>>>> >>
>>>> >>+    if (count < nvmem->word_size)
>>>> >>+        return -EINVAL;
>>>> >>+
>>>> >>      if (pos + count > nvmem->size)
>>>> >>          count = nvmem->size - pos;
>>>> >>
>>>
>>> >
>>> >Patch looks good to me. I think that it solves the issue.
>>> >I don't have the board here right now, so I'll check it ASAP and give
>>> >some feedback.
>>
>> Finally tested this. As it seemed, it solved the issue.
>> Are you submitting a patch for this?
>
> Yes, I will send a patch to the mailing list.
>

Ping? It would be good to have that patch and be able to merge this
lpc18xx-nvmem driver in time for the next merge window.

Thanks!
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
