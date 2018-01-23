From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 23 Jan 2018 19:34:36 +0100
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v6_00=2F41=5D_ARM=3A_davinci=3A_convert_to_common?=
 =?UTF-8?Q?_clock_framework=E2=80=8B?=
In-Reply-To: <5f836454-5de7-c51d-d262-2c2dbc26e438@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <CAMRc=MexJTMiD=URw1bv-qfGaTntZRXgfsSb_beYGkvO+LrpgQ@mail.gmail.com>
 <d819e18f-7d74-d8c4-8056-bfc545f4d4e9@lechnology.com>
 <CAMRc=McVNJqsO4+j=XkyNWuKqF-S-hQAw9XxHx6GC47UudgMYw@mail.gmail.com>
 <e5f4af7d-971c-5694-2da5-0cba9083ee5c@lechnology.com>
 <615bc302-e129-1501-63be-fa701f5ecaad@lechnology.com>
 <CAHCN7xLW=RjHHBjvDto=DRrNfNsQrsaGb0zmsRrwdc+7Wbhaxg@mail.gmail.com>
 <CAMRc=MdyGx3PFiryYybB2fCGx=AP=e7kkdd-DUL29pT+St9u1g@mail.gmail.com>
 <5f836454-5de7-c51d-d262-2c2dbc26e438@lechnology.com>
Message-ID: <CAMRc=Mcw8wWNo7Q3KnHNv81UGuHxEqmOs0he7MKxmaxDjwao+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-23 19:26 GMT+01:00 David Lechner <david@lechnology.com>:
> On 01/23/2018 12:10 PM, Bartosz Golaszewski wrote:
>>
>> 2018-01-23 18:03 GMT+01:00 Adam Ford <aford173@gmail.com>:
>>>
>>> On Tue, Jan 23, 2018 at 10:06 AM, David Lechner <david@lechnology.com>
>>> wrote:
>>>>
>>>> On 01/23/2018 10:03 AM, David Lechner wrote:
>>>>>
>>>>>
>>>>> You can see if the clock is enabled by running:
>>>>>
>>>>>       cat /sys/kernel/debug/clk/clk_summary
>>>>>
>>>>
>>>> I just realized if you can't boot, you can't do this. :-/
>>>
>>>
>>> I can boot with the latest set in your git repo, but the Ethernet
>>> doesn't apparently fully operate.  I don't get errors, but I cannot
>>> get a dhcp address.
>>>
>>> I'll try to do a more exhaustive test later today to get an idea of
>>> what works and what doesn't.  When I ran my basic tests, I just did a
>>> feel-good boot test (and reboot test)
>>>
>>> adam
>>
>>
>> FYI: manually calling clk_prepare_enable() in the davinci_mdio driver
>> seems to at least fix the ethernet. In master branch it's done by
>> pm_runtime_get_sync() (in davinci_mdio_reset()). However I'm still
>> getting several oopses and WARNs so there's some more work to do.
>>
>
> Hmm... I'm wondering if we need to also add #power-domain-cells to the
> PSC clocks and power-domains properties to the consumers.
>
> For this specific case though, it seems strange to me that the drivers
> to clk_get() and clk_get_rate() but never enable the clocks.
>
>
> Also, are the oopses and WARNs the same as before?

No, the ones before were all related to the ethernet failing, now I
get several stack traces from drm. Posted them on pastebin[1].

Thanks,
Bartosz

[1] https://pastebin.com/H3yZ5xHv
