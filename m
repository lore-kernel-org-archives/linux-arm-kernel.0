From: vigneshr@ti.com (Vignesh R)
Date: Wed, 24 Aug 2016 12:09:42 +0530
Subject: [PATCH v2 1/2] input: misc: Add generic input driver to read
 encoded GPIO lines
In-Reply-To: <20160823200335.GC6712@dtor-ws>
References: <20160823061649.3394-1-vigneshr@ti.com>
 <20160823061649.3394-2-vigneshr@ti.com>
 <949d92f3-4510-ada5-d3d6-a29544465fd6@ti.com> <20160823200335.GC6712@dtor-ws>
Message-ID: <8e38becb-137f-7346-258d-1c4dbb890643@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 24 August 2016 01:33 AM, Dmitry Torokhov wrote:
> On Tue, Aug 23, 2016 at 10:27:59AM -0500, Andrew F. Davis wrote:
>> On 08/23/2016 01:16 AM, Vignesh R wrote:
>>> Add a driver to read group of GPIO lines and provide its status as a
>>> numerical value as input event to the system. This will help in
>>> intefacing devices, that can be connected over GPIOs, that provide input
>>> to the system by driving GPIO lines connected to them like a rotary dial
>>> or a switch.
>>>
>>> For example, a rotary switch can be connected to four GPIO lines. The
>>> status of the GPIO lines reflect the actual position of the rotary
>>> switch dial. For example, if dial points to 9, then the four GPIO lines
>>> connected to the switch will read HLLH(0b'1001 = 9). This value
>>> can be reported as an ABS_* event to the input subsystem.
>>>
>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> ---
>>>
>>> v2: Use decoder,max-value instead of gpio-decoder,max-value.
> 
> That's not what Rob asked for. "decoder-max-value", not "decoder" vendor
> prefix.
> 

Sorry.. Will fix this in v3.


-- 
Regards
Vignesh
