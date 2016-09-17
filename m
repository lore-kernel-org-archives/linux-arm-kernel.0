From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 17 Sep 2016 14:04:28 +0200
Subject: [PATCH v2] input: touchscreen: Add support for Elan eKTF2127
 touchscreen controller
In-Reply-To: <20160916185654.GA14732@dtor-ws>
References: <20160828160005.20415-1-hdegoede@redhat.com>
 <20160902140935.GA19453@rob-hp-laptop> <20160916185654.GA14732@dtor-ws>
Message-ID: <5d188602-e98c-e600-115f-51cf84cc5926@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16-09-16 20:56, Dmitry Torokhov wrote:
> On Fri, Sep 02, 2016 at 09:09:35AM -0500, Rob Herring wrote:
>> On Sun, Aug 28, 2016 at 06:00:05PM +0200, Hans de Goede wrote:
>>> From: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
>>>
>>> This adds a driver for the Elan eKTF2127 touchscreen controller,
>>> which speaks an i2c protocol which is distinctly different from
>>> the already supported eKTH controllers.
>>>
>>> Signed-off-by: Michel Verlaan <michel.verl@gmail.com>
>>> Signed-off-by: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v2:
>>> -Improve devicetree bindings document
>>> -Use touchscreen_parse_properties and touchscreen_report_pos instead of DIY
>>> -Remove a bunch of unused defines (copy and paste leftover from chipone driver)
>>> -Some other minor cleanups and review comments addressed
>>> -Add defines for some command / address hex-values
>>> -Check packet header in interrupt handler
>>> ---
>>>  .../bindings/input/touchscreen/ektf2127.txt        |  27 ++
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> I'd like to merge the version below (factored out querying dimensions
> and parsing/reporting touch), can you please give it a spin?

Just tested it, works as advertised. Nice cleanup, esp. the
refactoring of the dimension querying, I should have tought of
that myself.

Regards,

Hans
