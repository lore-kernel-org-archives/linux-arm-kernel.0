From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 18 Dec 2014 09:50:26 +0100
Subject: [linux-sunxi] [PATCH v2 04/13] rc: sunxi-cir: Add support for
 an optional reset controller
In-Reply-To: <CAGb2v65BW7NABQXK877DkMNqDdBeuZ55wQHFkTexbWACFC4zFA@mail.gmail.com>
References: <1418836704-15689-1-git-send-email-hdegoede@redhat.com>
 <1418836704-15689-5-git-send-email-hdegoede@redhat.com>
 <CAGb2v65BW7NABQXK877DkMNqDdBeuZ55wQHFkTexbWACFC4zFA@mail.gmail.com>
Message-ID: <54929552.8090707@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18-12-14 03:48, Chen-Yu Tsai wrote:
> Hi,
>
> On Thu, Dec 18, 2014 at 1:18 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On sun6i the cir block is attached to the reset controller, add support
>> for de-asserting the reset if a reset controller is specified in dt.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>   .../devicetree/bindings/media/sunxi-ir.txt         |  2 ++
>>   drivers/media/rc/sunxi-cir.c                       | 25 ++++++++++++++++++++--
>>   2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt b/Documentation/devicetree/bindings/media/sunxi-ir.txt
>> index 23dd5ad..6b70b9b 100644
>> --- a/Documentation/devicetree/bindings/media/sunxi-ir.txt
>> +++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
>> @@ -10,6 +10,7 @@ Required properties:
>>
>>   Optional properties:
>>   - linux,rc-map-name : Remote control map name.
>> +- resets : phandle + reset specifier pair
>
> Should it be optional? Or should we use a sun6i compatible with
> a mandatory reset phandle? I mean, the driver/hardware is not
> going to work with the reset missing on sun6i.
>
> Seems we are doing it one way for some of our drivers, and
> the other (optional) way for more generic ones, like USB.

I do not believe that we should add a new compatible just because
the reset line of a block is hooked up differently. It is the
exact same ip-block. Only now the reset is not controlled
through the apb-gate, but controlled separately.

Regards,

Hans
