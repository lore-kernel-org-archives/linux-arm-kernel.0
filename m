From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 16 Jan 2018 12:18:19 +0530
Subject: [PATCH v5 02/44] clk: davinci: New driver for davinci PLL clocks
In-Reply-To: <4a32c52f-4335-52c0-fa63-625a449b00b5@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-3-git-send-email-david@lechnology.com>
 <7fc8bd35-0416-216d-8e1e-53a0ec6e8790@ti.com>
 <01fbde0e-36a0-2b19-e385-e63bc4a3ae4a@lechnology.com>
 <eb2b1a63-9c7c-aeca-170f-d38642442438@ti.com>
 <4a32c52f-4335-52c0-fa63-625a449b00b5@lechnology.com>
Message-ID: <7620b3a1-8806-2e39-4b08-b21064160e06@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 13 January 2018 06:41 AM, David Lechner wrote:
> On 01/12/2018 10:18 AM, Sekhar Nori wrote:
>> On Friday 12 January 2018 08:55 PM, David Lechner wrote:
>>>>
>>>> PLL output on DA850 must never be below 300MHz or above 600MHz (see
>>>> datasheet table "Allowed PLL Operating Conditions"). Does this take
>>>> care
>>>> of that? Thats one of the main reasons I recall I went with some
>>>> specific values of prediv, pllm and post div in
>>>> arch/arm/mach-davinci/da850.c
>>>
>>> Apparently, I missed this requirement. It looks like I am going to
>>> have to
>>> rework things so that there is some coordination between the PLL and the
>>> PLLDIV clocks in order to get the < 300MHz operating points.
>>
>> Just to make sure we are on the same page. The datasheet
>> constraint is 600 >= PLLOUT >= 300. PLLOUT is output of POSTDIV.
> 
> Hmm... I am on a different page. It looks to me like PLLOUT is the output
> of PLLM, not POSTDIV. The datasheet says nothing at all and the TRM does
> not say it explicitly, but footnote 2 on the table "System PLLC Output
> Clocks", for example, makes it pretty clear.

You are right. There is also this note in "Device clock generation" of
TRM which makes this clear.

"
The PLLOUT stage in PLLC0 and PLLC1 is capable of providing frequencies
greater than what the SYSCLK dividers can handle. The POSTDIV stage
should be programmed to keep the input to the SYSCLK dividers within
operating limits. See the device datasheet for the maximum operating
frequencies.
"

Thanks,
Sekhar
