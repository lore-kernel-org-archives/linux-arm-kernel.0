From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 6 Aug 2016 12:00:39 +0200
Subject: [PATCH v3] input: touchscreen: Remove duplicate ft6236 driver
In-Reply-To: <20160806022243.GB20562@dtor-ws>
References: <1470381871-4086-1-git-send-email-hdegoede@redhat.com>
 <1470381871-4086-2-git-send-email-hdegoede@redhat.com>
 <72101a2a-ccf0-b0bc-3859-50a43f990027@i2se.com>
 <20160806022243.GB20562@dtor-ws>
Message-ID: <424ae37d-6ca9-a950-551a-7643cee726d0@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06-08-16 04:22, Dmitry Torokhov wrote:
> On Fri, Aug 05, 2016 at 05:07:20PM +0200, Stefan Wahren wrote:
>> Hi Hans,
>>
>> Am 05.08.2016 um 09:24 schrieb Hans de Goede:
>>> The new(ish) ft6236 simply re-implements the M09 protocol of the
>>> (much) older edt-ft5x06.c driver.
>>>
>>> This commit removes this duplicate driver and adds the i2c ids and
>>> dt compatible string to the edt-ft5x06.c driver to keep compatibility.
>>
>> i think only remove of the driver is incorrect here.
>>
>> Since there are two similar but still different DT bindings
>>
>> Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
>>
>> Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6236.txt
>>
>> the DT handling of edt-ft5x06.c needs to be extended and then
>> finally driver and binding could be removed.
>
> I believe Hans made sure edt-ft5x06.c can handle focaltech-ft6236
> bindings. Do you see a discrepancy?

Correct I've double checked that both the i2c protocol and the
reset gpio binding are compatible. Devices using the focaltech-ft6236.txt
binding should work fine with the edt-ft5x06.c driver.

Now if someone can test and confirm that on actual hardware that would be
great...

And we probably want to remove
Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6236.txt
and instead add the compatible string that defines to
Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt

I can whip up a patch for that, but as said some testing on actual
hw would be good, preferably before I write said patch.

Regards,

Hans





p.s.

(the v3 in the subject is bogus my bad)
