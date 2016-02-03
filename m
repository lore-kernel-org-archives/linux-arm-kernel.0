From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 3 Feb 2016 11:58:57 -0600
Subject: [PATCH v10 4/5] Watchdog: introduce ARM SBSA watchdog driver
In-Reply-To: <CADyBb7tteV7VF9oxMaq5NprVdS2UBKobupxoyfSp+jQwp5wmQA@mail.gmail.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-5-git-send-email-fu.wei@linaro.org>
 <56B23D61.2050001@codeaurora.org>
 <CADyBb7tteV7VF9oxMaq5NprVdS2UBKobupxoyfSp+jQwp5wmQA@mail.gmail.com>
Message-ID: <56B23FE1.2010207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fu Wei wrote:
> I have posted  GTDT support separately :https://lkml.org/lkml/2016/2/1/660
>
> devicetree driver and GTDT driver both export sbsa gwdt info to
> "platform resource".
>
> this driver get hardware info from platform resource.

I must be missing something.  How does the driver probe?  It only has an 
entry for device tree:

+		.of_match_table = sbsa_gwdt_of_match,

Doesn't there need to be an ACPI match table to probe on an ACPI system?
