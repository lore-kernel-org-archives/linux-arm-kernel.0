From: pekon@ti.com (Gupta, Pekon)
Date: Tue, 22 Apr 2014 06:49:34 +0000
Subject: [PATCH] ARM: dts: Add support for the BeagleBoard xM A/B
In-Reply-To: <20140418235119.GS21823@atomide.com>
References: <1397574599-29573-1-git-send-email-robertcnelson@gmail.com>
 <CAOCHtYg5_Lvi3SWuWaRTDDNhLJ32jiXsKYQmrsKaShVWpM+xWQ@mail.gmail.com>
 <534D51C1.3010007@ti.com>
 <CAOCHtYhygGFbUunY9abEkjKfpQ1hh-DfRfhm160NehSYhWJSRw@mail.gmail.com>
 <20140418225111.GP21823@atomide.com>
 <CAOCHtYjdC-OGkdaBt74xMqi5eDc1eVbU6O7VyWMEYN-U50-Abw@mail.gmail.com>
 <20140418235119.GS21823@atomide.com>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAC458C@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

>From: Tony Lindgren
>* Robert Nelson <robertcnelson@gmail.com> [140418 16:42]:
>> On Fri, Apr 18, 2014 at 5:51 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Robert Nelson <robertcnelson@gmail.com> [140415 08:46]:
>> >>
>> >> Background: i also tried getting this having this fixed in u-boot:
>> >
>> > Do we still need to apply this patch then?
>>
>> Yeah, Tom want's it done in the kernel:
>>
>> Here's my proposed u-boot patch:
>> http://lists.denx.de/pipermail/u-boot/2014-January/172154.html
>>
>> and Tom's recommendation:
>> http://lists.denx.de/pipermail/u-boot/2014-January/172274.html
>>
>> Once this hits mainline, i'll submit a patch to u-boot to check for
>> the presence of this version and drop to the old dtb if not found.
>
>OK applying into omap-for-v3.15/fixes thanks.
>
>Tony

You probably missed fixing below typo before applying this patch.
omap3-beagle-xm-ab.dts breaks without this.

> +/ {
> +       /* HS USB Port 2 Power enable was inverted with the xM C */
> +       hsusb2_power: hsusb2_power_reg {
> +               enable-active-high;
       };
> +};


with regards, pekon
