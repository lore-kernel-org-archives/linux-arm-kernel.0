From: david@lechnology.com (David Lechner)
Date: Sun, 15 Apr 2018 13:57:22 -0500
Subject: [PATCH] ARM: dts: da850: use gpio-ranges
In-Reply-To: <be660007-cf4b-bf01-d811-a456af74bb49@ti.com>
References: <1519079371-25493-1-git-send-email-david@lechnology.com>
 <CACRpkdb=wOomi4QxvXLdNJVfB-rvGfKE+QZvmxvT2SzVDjH4tw@mail.gmail.com>
 <be660007-cf4b-bf01-d811-a456af74bb49@ti.com>
Message-ID: <e29d0326-fe16-5486-e3a9-53d4d6ebfb0e@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2018 05:44 AM, Sekhar Nori wrote:
> On Thursday 22 February 2018 09:04 PM, Linus Walleij wrote:
>> On Mon, Feb 19, 2018 at 11:29 PM, David Lechner <david@lechnology.com> wrote:
>>
>>> This makes use of the gpio-ranges feature that connects GPIO
>>> controllers and PINMUX controllers.
>>>
>>> In da850.dtsi, pinctrl-single,gpio-range is added to the pinmux node
>>> and gpio-ranges is added to the GPIO node. Unfortunately, the way the
>>> pinctrl-single driver enumerates the pins (starting with LSB) causes
>>> them to be in reverse order compared to the way the gpios are assigned.
>>> As a result, we have to declare the mapping for each GPIO individually.
>>>
>>> This also lets us remove all of the GPIO pinmuxes from
>>> da850-lego-ev3.dts. (Other da850 boards do not currently have any
>>> GPIO pinmuxes declared.)
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>
>> Nice,
>> Acked-by: Linus Walleij <linus.wallei@linaro.org>
> 
> Looks good to me too. And quite painstakingly done!
> 
> I suppose this needs to wait a bit due to the dependencies? Let me know
> once its okay to merge.
> 
> Thanks,
> Sekhar
> 

Hi Sekhar,

The dependencies are in v4.17-rc1 so you can pick up this patch now.
