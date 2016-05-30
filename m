From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 30 May 2016 16:13:10 +0200
Subject: [PATCH 0/3] watchdog: Add Amlogic Meson GXBB Watchdog Timer driver
In-Reply-To: <20160530134537.GA16188@mephisto>
References: <1464614948-28247-1-git-send-email-narmstrong@baylibre.com>
 <20160530134537.GA16188@mephisto>
Message-ID: <574C4A76.10807@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2016 03:45 PM, Carlo Caione wrote:
> On 30/05/16 15:29, Neil Armstrong wrote:
>> Adds support for the Amlogic Meson GXBB SoC Watchdog Timer.
>> It differs from the meson6/meson8b HW, so need for a separate driver.
>> The HW provides a divider capable of having a 1ms timebase thus simplifying
>> the counter update.
>> The restart call is not provided even if the HW is capable of triggering a
>> system reset immediately because of the PSCI firmare having such functionnality.
>> The watchdog is not expected to be running at boot time since there is a separate
>> system-level watchdog running from the SCPI co-processor, but this case would be
>> handle in a next driver update.
>>
>> Changes since RFC version at http://lkml.kernel.org/r/1464249112-13658-1-git-send-email-narmstrong at baylibre.com :
>> - Remove status callback, will re-introduce it later to managed the already-running use case
>> - Fix registers defines indentation
>> - Fix space between operators
>> - Make all callbacks static functions
>> - Fix bindings with missing clocks attribute
>> - Do not stop/start watchdog on a timeout setup
>> - Fix probe device configuration
>>
>> Neil Armstrong (3):
>>   watchdog: Add Meson GXBB Watchdog Driver
>>   dt-bindings: watchdog: Add Meson GXBB Watchdog bindings
>>   ARM64: dts: amlogic: meson-gxbb: Add watchdog node
> 
> I'm missing [PATCH 2/3]
> 
Sorry, fixed here :
