From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 22 Jan 2015 20:46:43 +0800
Subject: [PATCH v7 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <54B92245.6080306@arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-14-git-send-email-hanjun.guo@linaro.org>
 <54B8F2E3.80306@arm.com>
 <CACxGe6tBb8L8upS3zenZbrOc_c0E=MA=DqLjkSezEbregaAaaA@mail.gmail.com>
 <54B92245.6080306@arm.com>
Message-ID: <54C0F133.8060901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

We (Tomasz, Suravee and me) are working on supporting stacked domain on
ACPI, and rework GIC ACPI related patch, before we going further, we
need your guidance to see if we are going the right direction.

   - You said that we spread GIC related code every where, so how
     about put all the ACPI related GIC init code in one file under
     drivers/irqchip/ with name irq-gic-acpi.c?

   - ACPI only support one GICD for now, so we assume that there
    only one gicv2/v3 core domain and every device not using MSI
     will refer to that irqdomain in default.

Are we going the right direction?

Thanks
Hanjun
