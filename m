From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 4 Jan 2017 15:02:13 +0800
Subject: [PATCH v6 06/14] irqchip: gicv3-its: platform-msi: refactor
 its_pmsi_init() to prepare for ACPI
In-Reply-To: <8cdc4bfa-18a3-b9f6-aaba-0efe1f75fb40@semihalf.com>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-7-git-send-email-hanjun.guo@linaro.org>
 <8cdc4bfa-18a3-b9f6-aaba-0efe1f75fb40@semihalf.com>
Message-ID: <601cbdf2-823d-8bde-bbd9-fcc6a1c67f2c@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 2017/1/3 15:41, Tomasz Nowicki wrote:
> Hi,
>
> Can we merge patch 4 & 6 into one patch so that we keep refactoring part
> as one piece ? I do not see a reason to keep them separate or have patch
> 5 in between. You can refactor what needs to be refactored, add
> necessary functions to iort.c and then support ACPI for
> irq-gic-v3-its-platform-msi.c

There are two functions here,
  - retrieve the dev id from IORT which was DT based only;

  - init the platform msi domain from MADT;

For each of them split it into two steps,
  - refactor the code for ACPI later and it's easy for review
    because wen can easily to figure out it has functional
    change or not

  - add ACPI functionality

Does it make sense?

Thanks
Hanjun
