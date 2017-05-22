From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Mon, 22 May 2017 09:37:13 +0300
Subject: [PATCH] i2c: designware: Fix bogus sda_hold_time due to
 uninitialized vars
In-Reply-To: <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com>
 <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
Message-ID: <aad364b9-75ce-553e-28da-a5458b90b332@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2017 08:46 AM, Jan Kiszka wrote:
> We need to initializes those variables to 0 for platforms that do not
> provide ACPI parameters. Otherwise, we set sda_hold_time to random
> values, breaking e.g. Galileo and IOT2000 boards.
>
> Fixes: 9d6408433019 ("i2c: designware: don't infer timings described by ACPI from clock rate")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Affects 4.12-rc2.
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
