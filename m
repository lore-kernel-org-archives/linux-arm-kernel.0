From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 15 Mar 2017 21:56:09 +0100
Subject: [PATCH v3 1/2] Documentation: bindings: Introduce scpi,
 sensors-scale
In-Reply-To: <57ff035a-b462-6f5d-0100-051e99e9a2b6@arm.com>
References: <20170309101759.18081-1-carlo@caione.org>
 <20170309101759.18081-2-carlo@caione.org>
 <57ff035a-b462-6f5d-0100-051e99e9a2b6@arm.com>
Message-ID: <CAFBinCAde0qWpJsYF8bm-5ex1q+TDZtL73bf5DNoUuFEDhPXpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 7:20 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 09/03/17 10:17, Carlo Caione wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> Document the new property `scpi,sensors-scale` used by the hwmon-scpi
>> driver to convert the sensor readings to the correct / expected scale.
>>
>
> I am fine with DT bindings if DT maintainers agree with having one but I
> would like to add couple of points to get their feedback:
>
> 1. ARM recognized the drawbacks of SCPI which started informally with
>    ARM Ltd platforms and got adopted by few vendors. It's now being
>    worked on and a much better and scalable replacement protocol is
>    being discussed with vendors now. So future enhancement to this SCPI
>    protocol is unlikely.
>
> 2. AmLogic has diverted from base protocol in many ways and most of them
>    are handled with just compatible so far without any need for
>    additional bindings. Can we avoid it ?
>
> So based on these, I prefer not to add more bindings to handle such
> deviations but make it just AmLogic specific.
could you please share your idea where this "Amlogic specific
implementation" fits best?
- in firmware/arm_scpi to keep a contract (for example: millicelsius)
to everyone who reads a temperature sensor for example
- or in hwmon/scpi-hwmon


Regards,
Martin
