From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 24 Oct 2012 20:22:45 +0800
Subject: [PATCH v2 2/2] ARM: topdown mmap support
In-Reply-To: <1321566426-31184-2-git-send-email-robherring2@gmail.com>
References: <1321566426-31184-1-git-send-email-robherring2@gmail.com>
 <1321566426-31184-2-git-send-email-robherring2@gmail.com>
Message-ID: <CAMj5Bkg9Ht4YG9TL4yQfT5y5Fea4ywLDANoO2NTnGJZatN2RLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 5:47 AM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Similar to other architectures, this adds topdown mmap support in user
> process address space allocation policy. This allows mmap sizes greater
> than 2GB. This support is largely copied from MIPS and the generic
> implementations.
>
> The address space randomization is moved into arch_pick_mmap_layout.
>
> Tested on V-Express with ubuntu and a mmap test from here:
> https://bugs.launchpad.net/bugs/861296
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>

Unfortunately, we met "no vspace available" during loading libmono.so,
when using default arch_get_unmapped_area_topdown method, tested on
Jelly Bean with 3.4 kernel.
While no problem using arch_get_unmapped_area in the patch, or just
revert this patch.
The result is some application can not run.

Just google, find same issue reported on Jelly Bean with 3.4 kernel.

Any suggestion?

Thanks
