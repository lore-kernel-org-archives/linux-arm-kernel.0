From: romain.perier@gmail.com (Romain Perier)
Date: Tue, 25 Nov 2014 16:57:56 +0100
Subject: [PATCH v5 1/2] of: Rename "poweroff-source" property to
 "system-power-controller"
In-Reply-To: <20141125145410.GD19910@localhost>
References: <1416918506-9366-1-git-send-email-romain.perier@gmail.com>
 <1416918506-9366-2-git-send-email-romain.perier@gmail.com>
 <20141125144007.9904BC44343@trevor.secretlab.ca>
 <20141125145410.GD19910@localhost>
Message-ID: <CABgxDoKUecAd00X0znkGiQncF4MwnLAM4BFV2AV_oMPF=4G7UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your feedbacks.  I think that Mark will probably wait until
there are more reviews on this serie. (this is exactly what he asked
for the previous one)

2014-11-25 15:54 GMT+01:00 Johan Hovold <johan@kernel.org>:
> On Tue, Nov 25, 2014 at 02:40:07PM +0000, Grant Likely wrote:
>> On Tue, 25 Nov 2014 12:28:25 +0000
>> , Romain Perier <romain.perier@gmail.com>
>>  wrote:
>> > It reverts commit a4b4e0461ec5 ("of: Add standard property for poweroff capability").
>> > As discussed on the mailing list, it makes more sense to rename back to the
>> > old established property name, without the vendor prefix. Problem being that
>> > the word "source" usually tends to be used for inputs and that is out of control
>> > of the OS. The poweroff capability is an output which simply turns the
>> > system-power off. Also, this property might be used by drivers which power-off
>> > the system and power back on subsequent RTC alarms. This seems to suggest to
>> > remove "poweroff" from the property name and to choose "system-power-controller"
>> > as the more generic name. This patchs adds the required renaming changes and
>> > defines an helper function which checks if this property is set.
>> >
>> > Signed-off-by: Romain Perier <romain.perier@gmail.com>
>>
>> For both patches:
>> Acked-by: Grant Likely <grant.likely@linaro.org>
>>
>> Let me know if I need to take this series through my tree. Also, does it
>> need to go into v3.18 and be backported to stable? Or just v3.19.
>
> It's only needed in the regulator tree for 3.19, and does not need to be
> backported.
>
> We could convert the drivers (and dts) that currently use
> "<vendor>,system-power-controller" to use the new helper (while
> maintaining backward compatibility) after 3.19-rc1 is out.
>
> Johan
