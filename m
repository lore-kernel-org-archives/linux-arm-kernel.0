From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 8 Sep 2015 09:48:48 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Add dts file for the
 pov protab2-ips9 tablet
In-Reply-To: <20150907205216.GW31584@lukather>
References: <1441441319-10658-1-git-send-email-hdegoede@redhat.com>
 <20150906163023.GR31584@lukather> <55ED3739.609@redhat.com>
 <1441612142.14422.34.camel@plaes.org> <55ED4F8F.6080502@redhat.com>
 <1441617262.21530.4.camel@plaes.org> <55ED591B.7050705@redhat.com>
 <20150907205216.GW31584@lukather>
Message-ID: <55EE92E0.1010805@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07-09-15 22:52, Maxime Ripard wrote:
> Hi,
>
> On Mon, Sep 07, 2015 at 11:30:03AM +0200, Hans de Goede wrote:
>>>>> bma250 already has devicetree support. It is used in Gemei G9
>>>>> tablet (sun4i-gemei-g9.dts).
>>>>
>>>> Yes I've seen that, but does it actually work? I've not tried but
>>>> I do not see any compatible string in the actual bma250 code in
>>>> the kernel, so I believe that this part of the sun4i-gemei-g9.dts
>>>> file does not work ?
>>>
>>> It worked (even without IRQs) when I submitted the patch. Driver
>>> itself is under iio/accel/bma180.c
>>
>> That is really weird, because:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/accel/bma180.c
>>
>> Does not have an of_match_table ... ??
>
> Not really, when using DT, i2c will set the i2c_client name to the
> device part of the compatible [1] [2], and then if the of_device_id
> lookup fails, will fallback to matching the i2c_client name to the
> i2c_device_id [3]. Which in our case matches.
>
> Maxime
>
> [1] http://lxr.free-electrons.com/source/drivers/i2c/i2c-core.c#L1281
> [2] http://lxr.free-electrons.com/source/drivers/i2c/i2c-core.c#L969
> [3] http://lxr.free-electrons.com/source/drivers/i2c/i2c-core.c#L461

Hmm, not sure whether that is a useful feature or an ugly hack :)

It is sorta unexpected either way. But I can make good use of this to
enable the accelerometer and maybe also some touchscreens on a bunch of
boards I have.

Still should we rely on this? This means relying on Linux kernel behavior,
rather then something documented in Documentation/devicetree/bindings/...

Regards,

Hans
