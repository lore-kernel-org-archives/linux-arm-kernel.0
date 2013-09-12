From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 12 Sep 2013 14:40:15 -0700
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <87vc25pvvm.fsf@linaro.org>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <87vc25pvvm.fsf@linaro.org>
Message-ID: <CAGa+x85vxX8dbmk-8mOEQ03q6Ud1a-OfnV7t5-rNtu06vn_cSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 2:34 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Mika Westerberg <mika.westerberg@linux.intel.com> writes:
>
>> From: Aaron Lu <aaron.lu@intel.com>
>>
>> This patch adds runtime PM support for the I2C bus in a similar way that
>> has been done for PCI bus already. This means that the I2C bus core
>> prepares runtime PM for a client device just before a driver is about to be
>> bound to it. Devices that are not bound to any driver are not prepared for
>> runtime PM.
>>
>> In order to take advantage of this runtime PM support, the client device
>> driver needs drop the device runtime PM reference count by calling
>> pm_runtime_put() in its ->probe() callback and possibly implement rest of
>> the runtime PM callbacks.
>>
>> If the driver doesn't support runtime PM (like most of the existing I2C
>> client drivers), the device in question is regarded as being runtime PM
>> active and powered on.
>
> But for existing drivers which already support runtime PM (at least 7 by
> a quick grep), they will be stuck runtime enabled and stop hitting
> low-power states after this patch.

Oops, nevermind.  I was mixing this up with runtime PM on the i2c
adapter but this is for the i2c client.

Sorry for the noise.

Kevin
