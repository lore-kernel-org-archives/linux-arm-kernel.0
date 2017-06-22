From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Thu, 22 Jun 2017 14:16:18 +0300
Subject: [PATCH 1/9] i2c: designware: Fix system suspend
In-Reply-To: <20170622104933.GY629@lahna.fi.intel.com>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
 <1498072888-14782-2-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0iYwPE8rpn=aZ9n6LV-qbAK3kynRqVZ7xxuB+gYar_fyg@mail.gmail.com>
 <20170622104933.GY629@lahna.fi.intel.com>
Message-ID: <5540bae1-b1bf-0e15-1fa0-977076fa0753@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2017 01:49 PM, Mika Westerberg wrote:
> On Thu, Jun 22, 2017 at 01:31:51AM +0200, Rafael J. Wysocki wrote:
>> On Wed, Jun 21, 2017 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Thanks Ulf for taking care of this!
>
Indeed!

> I tested this series on Dell XPS 9350 which has touch panel connected to
> I2C and suspend/resume still works fine and I can see the controller
> going to D3 when the touch panel is idle.
>
> I can perform more comprehensive testing next week.
>
Unfortunately I'm seeing interrupt storm during suspend/resume on 
platform using PM domain from drivers/acpi/acpi_lpss.c straight after 
this patch. Maybe some timing related as I see it only if I have debug 
messages on (i2c_designware_core.dyndbg=+p). But it occurs only after 
this patch.

Have to dig more deeply next week.

-- 
Jarkko
