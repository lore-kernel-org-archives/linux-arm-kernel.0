From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 14 Mar 2017 06:47:26 -0700
Subject: [PATCH v3 2/3] watchdog: s3c2410: Simplify getting driver data
In-Reply-To: <CAJKOXPeoHVECsyT+Jy4D3bCwed2gsiKq3akMcDGNKTvrVbcEUg@mail.gmail.com>
References: <20170313190726.2988-1-krzk@kernel.org>
 <CGME20170314131709epcas5p4e150e0df2a04a3369edf61b2075e2e8f@epcas5p4.samsung.com>
 <20170313190726.2988-3-krzk@kernel.org> <2568764.DQnxL2m83S@amdc3058>
 <CAJKOXPeoHVECsyT+Jy4D3bCwed2gsiKq3akMcDGNKTvrVbcEUg@mail.gmail.com>
Message-ID: <08e02fbe-a059-fae9-ad08-ccd32a9602a7@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2017 06:20 AM, Krzysztof Kozlowski wrote:
> On Tue, Mar 14, 2017 at 3:17 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>
>> Hi,
>>
>> On Monday, March 13, 2017 09:07:25 PM Krzysztof Kozlowski wrote:
>>> Simplify the flow in helper function for getting the driver data by
>>> using of_device_get_match_data() and only one if() branch.
>>>
>>> The code should be equivalent.
>>
>> While you are at it could you remove s3c2410_get_wdt_drv_data()
>> helper?  It is used only once during probe and is marked inline
>> anyway..
>
> Thanks for feedback!
> The existence of this helper is purely from code readability (thus
> inline does not matter). The probe is big so splitting some small
> self-contained part helps. Not much but a little...
>

Agreed. I don't see value in removing this helper.

Guenter
