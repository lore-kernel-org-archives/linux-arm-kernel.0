From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 7 Sep 2016 12:44:03 +0200
Subject: [linux-sunxi] sunxi: Endless musb_bus_suspend warnings when
 booting A23 tablet with OTG
In-Reply-To: <CAGb2v65Ar203_qc43jp-E+WjXROWTtM4rKKDemJ6DSi4pK7RrA@mail.gmail.com>
References: <CAGb2v648CnhjvEtrxdXxRYFjW_Oe-Rqf3DkiHwNR9uWt7FC3hA@mail.gmail.com>
 <6a0822df-92bd-29dc-6eea-0a000baee666@redhat.com>
 <CAGb2v65Ar203_qc43jp-E+WjXROWTtM4rKKDemJ6DSi4pK7RrA@mail.gmail.com>
Message-ID: <475d1d75-9dc9-c91e-04f1-3ce5dab60226@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06-09-16 17:31, wens Tsai wrote:
> On Tue, Sep 6, 2016 at 7:28 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 06-09-16 13:02, wens Tsai wrote:
>>>
>>> Hi Hans,
>>>
>>> I've built the latest sunxi-next branches of Linux and U-boot and
>>> tried it on my Q8 A23 tablet. My tablet has an OTG adapter with a
>>> USB ethernet adapter connected all the time. Upon booting into
>>> Linux I get an endless stream of:
>>>
>>>     musb_bus_suspend 2586: trying to suspend as a_wait_bcon while active
>>>
>>> messages. To get out of this I have to physically remove the OTG
>>> adapter. Booting without the OTG adapter to begin with also gets
>>> rid of the problem.
>>>
>>> Have you run into this problem? I wonder if we should disable VBUS
>>> just before leaving U-boot? Now that we support DRIVEVBUS this
>>> shouldn't be a problem.
>>
>>
>> I've not seen such a problem. I'm fine with disabling Vbus when
>> leaving u-boot, that certainly is the safe thing to do anyways.
>
> Seems there's no distinction between "USB reset" and leaving
> U-boot, as you mentioned in your patch removing the "power off"
> code from the USB drivers. Are you OK with power cycling during
> USB reset as well?

I would prefer not too, but if it is hard to get around that
I can live with it.

>
>> I guess I'll get a u-boot patch from you if that indeed fixes
>> things ?
>
> Yup. In progress. Though my ethernet adapter is acting up, so I'll
> need to swap in something else to test it properly.

Cool.

Thanks & Regards,

Hans
