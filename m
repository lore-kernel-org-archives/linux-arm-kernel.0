From: mlongnecker@nvidia.com (Matt Longnecker)
Date: Wed, 6 Jul 2016 09:47:54 -0700
Subject: [PATCH V2 05/10] firmware: tegra: add BPMP support
In-Reply-To: <CAAVeFuKvp4d=RoPZGGLmhqXs1oHZPrEOxTJd_b6b7-rHq_mqqg@mail.gmail.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-6-josephl@nvidia.com>
 <CAAVeFuKvp4d=RoPZGGLmhqXs1oHZPrEOxTJd_b6b7-rHq_mqqg@mail.gmail.com>
Message-ID: <577D363A.4010003@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex,

On 07/06/2016 04:39 AM, Alexandre Courbot wrote:
>> diff --git a/include/soc/tegra/bpmp_abi.h b/include/soc/tegra/bpmp_abi.h
>> >new file mode 100644
>> >index 000000000000..0aaef5960e29
>> >--- /dev/null
>> >+++ b/include/soc/tegra/bpmp_abi.h
>> >@@ -0,0 +1,1601 @@
>> >+/*
>> >+ * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
>> >+ *
>> >+ * This program is free software; you can redistribute it and/or modify it
>> >+ * under the terms and conditions of the GNU General Public License,
>> >+ * version 2, as published by the Free Software Foundation.
>> >+ *
>> >+ * This program is distributed in the hope it will be useful, but WITHOUT
>> >+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> >+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> >+ * more details.
>> >+ *
>> >+ * You should have received a copy of the GNU General Public License
>> >+ * along with this program.  If not, see<http://www.gnu.org/licenses/>.
>> >+ */
>> >+
>> >+#ifndef_ABI_BPMP_ABI_H_
>> >+#define_ABI_BPMP_ABI_H_
>> >+
>>
> ...
>
> There is a lot of stuff in this file, most of which we are not using
> now - this is ok, but unless this is a file synced from an outside
> resource maybe we should trim the structures we don't need and add
> them as we make use of them? It helps dividing the work in bite-size
> chunks.
>
> Regarding the documentation format of this file, is this valid kernel
> documentation since the adoption of Sphynx? Or is it whatever the
> origin is using?
bpmp_abi.h is meant to be delivered as is from an NVIDIA internal repo 
to a variety of OS'es. Each of them has a different documentation 
standard and coding standard.

I'd like to avoid trimming parts from the file (or even worse modifying 
parts of the file) so that future deliveries are trivial.

Thanks,
Matt Longnecker
