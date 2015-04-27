From: john.tobias.ph@gmail.com (John Tobias)
Date: Mon, 27 Apr 2015 00:17:44 -0700
Subject: Broadcom 43340 module on iMX6DL
In-Reply-To: <20150427033351.GC26374@shlinux1.ap.freescale.net>
References: <CACUGKYPHKGoLEfNPNvtHwtCA9jB_ZLamzF_PViDfQnpnc8Y-=A@mail.gmail.com>
 <55394141.1080601@broadcom.com>
 <CALAqxLU_9Hcbr5atxRBLDhs4WY9JfAdwdyzpszeO5nxCZU9JLA@mail.gmail.com>
 <CACUGKYPFk3Qoj3-XgkMwuzuCz_aP-8QCA8S+OSq5-qfoRF9dwg@mail.gmail.com>
 <CACUGKYMqFuk6nD82H=7nPRVvHEe9Ot6OkWiixqoV91ED8Cwudw@mail.gmail.com>
 <5539FCD5.4050708@broadcom.com>
 <CACUGKYOheGKjQOSZkxKGkqj_wOWAN8_2geptmTC8jp_L5AOveg@mail.gmail.com>
 <553A8803.5010700@broadcom.com>
 <CACUGKYOcgcrM4EPWmV18CeG-P6+nE_ANX5qgWGk3nn3NmWQ72A@mail.gmail.com>
 <553A9368.9030700@broadcom.com>
 <20150427033351.GC26374@shlinux1.ap.freescale.net>
Message-ID: <CACUGKYMeHr1vcxuxBWu-vFkpxL3rdRn6oUn0aww3eKkHfvJdCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

I tested the kerne 4.0 and the driver works (It loads the driver
correctly, it show's the wlan0 interface and it did not bail out...)

bcrm {
  compatible = "brcm,bcm4329-fmac";
  interrupt-parent = <&gpio3>;
  interrupts = <22 0x2>;
  interrupt-names = "host-wake";
};


Regards,

John



On Sun, Apr 26, 2015 at 8:33 PM, Dong Aisheng <b29396@freescale.com> wrote:
> On Fri, Apr 24, 2015 at 09:03:04PM +0200, Arend van Spriel wrote:
>> On 04/24/15 20:24, John Tobias wrote:
>> >Hi Arend,
>> >
>> >Apologize for the confusion. I am asking the repo for the device
>> >driver for 43340. Looking at the link you sent, it's more userspace
>> >support and didn't see the device driver there...
>>
>> crap. you are right. it is userspace and firmware. You need a kernel
>> repo. There are some on the site I referred to, but you may need to
>> contact Freescale whether they provide it publicly like on github or
>> so.
>>
>
> One simple question:
> Does the brcmfmac driver in upstream kernel also work?
> I mean this one:
> drivers/net/wireless/brcm80211
>
> Regards
> Dong Aisheng
>
>> Regards,
>> Arend
>>
>> >Regards,
>> >
>> >John
>> >
>> >
>> >On Fri, Apr 24, 2015 at 11:14 AM, Arend van Spriel<arend@broadcom.com>  wrote:
>> >>On 04/24/15 19:49, John Tobias wrote:
>> >>>
>> >>>Hi Arend,
>> >>>
>> >>>I am not pretty sure if the brcm43340 driver for android is the latest
>> >>>one.  May I know repo?.
>> >>
>> >>
>> >>Not sure what you are asking. I gave the url. Did you try using the
>> >>brcmfmac4334-sdio.bin firmware file. I would like to know if that one works
>> >>for your device.
>> >>
>> >>Regards,
>> >>Arend
>> >>
>> >>
>> >>>Regards,
>> >>>
>> >>>John
>> >>>
>> >>>On Fri, Apr 24, 2015 at 1:20 AM, Arend van Spriel<arend@broadcom.com>
>> >>>wrote:
>> >>>>
>> >>>>On 04/24/15 03:04, John Tobias wrote:
>> >>>>>
>> >>>>>
>> >>>>>Btw, where I could get a copy of the latest driver?.
>> >>>>
>> >>>>
>> >>>>
>> >>>>The open-source bcmdhd is in AOSP [1]. I would stick to the android
>> >>>>release
>> >>>>branch you are running on your device.
>> >>>>
>> >>>>Regards,
>> >>>>Arend
>> >>>>
>> >>>>[1] https://android.googlesource.com/platform/hardware/broadcom/wlan/
>> >>>>
>> >>>>
>> >>>>>Regards,
>> >>>>>
>> >>>>>John
>> >>>>>
>> >>>>>On Thu, Apr 23, 2015 at 5:59 PM, John Tobias<john.tobias.ph@gmail.com>
>> >>>>>wrote:
>> >>>>>>
>> >>>>>>
>> >>>>>>Hi John,
>> >>>>>>
>> >>>>>>Is it possible to have a copy of the firmware for 43340?.
>> >>>>>>
>> >>>>>>Regards,
>> >>>>>>
>> >>>>>>John
>> >>>>>>
>> >>>>>>On Thu, Apr 23, 2015 at 5:57 PM, John Stultz<john.stultz@linaro.org>
>> >>>>>>wrote:
>> >>>>>>>
>> >>>>>>>
>> >>>>>>>On Thu, Apr 23, 2015 at 12:00 PM, Arend van Spriel<arend@broadcom.com>
>> >>>>>>>wrote:
>> >>>>>>>>
>> >>>>>>>>
>> >>>>>>>>By the name of the file I suspected you did. Personally, I verified
>> >>>>>>>>the
>> >>>>>>>>firmware works on 43341. John Stultz tested both 43340 and 43341 with
>> >>>>>>>>this
>> >>>>>>>>firmware.
>> >>>>>>>
>> >>>>>>>
>> >>>>>>>
>> >>>>>>>Minor correction here, I only tested on 43341 hardware. The confusion
>> >>>>>>>might be that the firmware I originally had access to claimed it was
>> >>>>>>>43340.
>> >>>>>>>
>> >>>>>>>thanks
>> >>>>>>>-john
>> >>>>
>> >>>>
>> >>>>
>> >>
>>
