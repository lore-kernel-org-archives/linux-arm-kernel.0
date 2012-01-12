From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Thu, 12 Jan 2012 11:37:30 +0530
Subject: [PATCH v2] I2C: OMAP: Recover from Bus Busy condition
In-Reply-To: <87vcoh27sr.fsf@ti.com>
References: <1326303693-30106-1-git-send-email-shubhrajyoti@ti.com>
 <87vcoh27sr.fsf@ti.com>
Message-ID: <4F0E78A2.6050900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 January 2012 03:58 AM, Kevin Hilman wrote:
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>
>> From: Vikram Pandita <vikram.pandita@ti.com>
>>
>> In case a peripheral is driving SDA bus low (ie. a start condition), provide
>> a constant clock output using the test mode of the OMAP I2C controller to
>> try and clear the bus. Soft reset I2C controller after attempting the bus clear
>> to ensure that controller is in a good state.
>>
>> Based upon Vikram Pandita's patch from TI Android 3.0 kernel and modified for
>> mainline by Jon Hunter. 
>>
>> A couple differences from the original patch ...
>> 1. Add a new function for bus clear
>> 2. Ensure that the CON.I2C_EN bit is set when using the SYSTEST feature to
>>    output a permanent clock. This bit needs to be set and tpyically it would
>>    be set by the unidle function but this is not the case for all OMAP
>>    generations.
>> 3. Program the SYSTEST setting only the bits we care about. However, restore
>>    SYSTEST registers to there original state as some OMAP generations do not
>>    implement perform a soft-reset.
>> 4. Clear the CON register after performing the bus clear, so when we call the
>>    init function the controller is disabled and the init function will
>>    re-enable later.
>>
>> Cc:  Kevin Hilman <khilman@ti.com>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>> Original patch can be found here:
>> http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=a2ab04192ba25e60f95ba1ff3af5601a2d7b5bd1
>> applies on Kevin's for_3.3/i2c/misc
> Please also explain how this was tested, and on what platforms.

Please ignore will  resend.
> Thanks,
>
> Kevin
