From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Feb 2013 11:25:59 -0600
Subject: [PATCH 0/4] Convert highbank to use PSCI calls
In-Reply-To: <20130227171830.GD22286@mudshark.cambridge.arm.com>
References: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
 <20130227171830.GD22286@mudshark.cambridge.arm.com>
Message-ID: <512E41A7.9040700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 11:18 AM, Will Deacon wrote:
> Hi Rob,
> 
> On Wed, Feb 27, 2013 at 03:42:04AM +0000, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This series converts highbank to use PSCI calls for secondary core boot,
>> hotplug, cpuidle, suspend/resume, reset, and poweroff. Doing this removes
>> about 200 lines of platform code (1/3 of it) and abstracts out the A9 and
>> A15 differences (some of which are not yet in place).
> 
> This is great, nice work!
> 
>> Will, I'm using the id field to specify system level events which are
>> highbank specific. I worry that the id field will be abused for things
>> that could be standardized. Having standard PSCI calls for reset and
>> poweroff would avoid this for highbank.
> 
> I don't like using the ID field for this because it places some of the
> number space in the device tree binding and other parts in the platform
> code. It might be better to use the bottom 16 bits of the power_state
> argument to CPU_OFF (which are designated as platform specific anyway) to
> indicate that you actually want a system-wide operation to take place.

The platform specific ID in the power state field of CPU_OFF is what I'm
using. But there is no reason for this to be platform specific when
possibly all platforms need this.

> Since this document is currently undergoing a fairly major update (which
> will hopefully be released soon), I'll go and check with the authors to see
> if they have already considered this.

It would be nice to have some visibility to this as this is an ABI and
will break if things change.

Rob
