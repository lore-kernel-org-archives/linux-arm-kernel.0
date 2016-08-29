From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 29 Aug 2016 11:35:47 +0200
Subject: [PATCH] dt-bindings: touchscreen: silead_gsl1680: Document
 touchscreen-fw-name
In-Reply-To: <20160829051834.GW3165@lukather>
References: <1471964688-12188-1-git-send-email-hdegoede@redhat.com>
 <20160829003725.GA20749@rob-hp-laptop> <20160829051834.GW3165@lukather>
Message-ID: <64d65f63-db47-d9c2-1c3f-cc544c2da2ab@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 29-08-16 07:18, Maxime Ripard wrote:
> Hi Rob,
>
> On Sun, Aug 28, 2016 at 07:37:25PM -0500, Rob Herring wrote:
>> On Tue, Aug 23, 2016 at 05:04:48PM +0200, Hans de Goede wrote:
>>> The driver has supported touchscreen-fw-name to specify the firmware to
>>> load since day 0, but this was omitted from the binding, document this.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>  Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> I'd really like to deprecate in favor of a standard property name. We've
>> somewhat agreed on 'firmware-name' though there is no common binding doc
>> yet. But given this is in use:
>
> This has been introduced in 4.8-rc1, so it hasn't been used in any
> stable version yet, and we don't have any users in tree so far.
>
> If you want to something else, it feels like now is the time to change
> it.

Ack, I can still change it to firmware-name if you want (Maxime has not yet
merged any dts changes using the touchscreen-fw-name). We should probably
also decide if the silead/ prefix we're using (so the firmware files are
/lib/firmware/silead/foo.fw under Linux) goes into the firmware-name
property as my current wip code is doing, or if we put the "silead/"
part in the driver and only put the part after it in the property.

I've a feeling that just putting only the base filename (so no "silead/"
prefix) in the property is best.

Regards,

Hans
