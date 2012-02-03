From: dongas86@gmail.com (Dong Aisheng)
Date: Sat, 4 Feb 2012 02:13:54 +0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <20120203173205.GB1426@atomide.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <20120201143530.GA2203@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF178E124AC5@HQMAIL01.nvidia.com>
 <CAA+hA=RpkP-FFAr8wqVPjSKEMvO_sRHmOK_9nUYfuW=ps0O_=Q@mail.gmail.com>
 <20120203173205.GB1426@atomide.com>
Message-ID: <CAA+hA=QFB7x0yv65LMuLx1exmiUAuB98D+9Fyyk9oeVu+7F2QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 4, 2012 at 1:32 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Dong Aisheng <dongas86@gmail.com> [120202 11:36]:
>>
>> Actually i think i'd rather do not use config property, then i could
>> be more compact:
>> (anyway it's another issue and is flexible to be controlled by #pinmux-cells)
>> pinctrl_usdhc4: pinconfig-usdhc4 {
>> ? ? ? ? /* 0: pin 1: group */
>> ? ? ? ? mux-entity = <0>;
>> ? ? ? ? func-name = "usdhc4func";
>> ? ? ? ? grp-name = "usdhc4grp";
>
> The func-name and grp-name should be optional here.
> This mux entry is already the group, and can be used as
> the group name.
For the case i discussed here, the mux entry is PIN.
(the mux-entity value is 0).
we introduce this value here for treating all pins is one group.
When do map parsing, only one pinmux map will be created.
So we need a grp-name.
And we also need a func-name here for construct pinmux map.

> And the function name can be generated
> dynamically in most cases. I'm currently using np->full_name
> of the driver claiming these pins as the function name.
>
Why i did not use np->name as function name is because the np->name
can be different
while actually these nodes may represent the same function but just
different pins, so the function name should be same.

>> ? ? ? ? mux =
>> ? ? ? ? ? ? ? ? <MX6Q_SD4_CMD ?0 MX6Q_USDHC_PAD_CTRL>
>> ? ? ? ? ? ? ? ? <MX6Q_SD4_CLK ?0 MX6Q_USDHC_PAD_CTRL>
>> ? ? ? ? ? ? ? ? <MX6Q_SD4_DAT0 1 MX6Q_USDHC_PAD_CTRL>
>> ? ? ? ? ? ? ? ? <MX6Q_SD4_DAT1 1 MX6Q_USDHC_PAD_CTRL>
>> ? ? ? ? ? ? ? ? <MX6Q_SD4_DAT2 1 MX6Q_USDHC_PAD_CTRL>
>> ? ? ? ? ? ? ? ? <MX6Q_SD4_DAT3 1 MX6Q_USDHC_PAD_CTRL>
>> ? ? ? ? ? ? ? ? <MX6Q_SD4_DAT4 1 MX6Q_USDHC_PAD_CTRL>
>> ? ? ? ? ? ? ? ? <MX6Q_SD4_DAT5 1 MX6Q_USDHC_PAD_CTRL>
>> ? ? ? ? ? ? ? ? <MX6Q_SD4_DAT6 1 MX6Q_USDHC_PAD_CTRL>
>> ? ? ? ? ? ? ? ? <MX6Q_SD4_DAT7 1 MX6Q_USDHC_PAD_CTRL>;
>> };
>
> For listing basic pins this format works fine for me. It seems
> to have low overhead for parsing. And the width of the array
> can be driver specific.
>
> Looks like it's the binding for altenative states that's still a
> bit open..
>
Yes, it does not have states support.

> So how about let's first standardize on the mux format above?
>
I'm afraid it may be hard for us to standardize the mux format for a
standard binding in pinctrl core due to  hw difference.
I'm think the new way which i sent in this thread after the mail you replied.
You can refer to them to see if it's reasonable for you too.

Regards
Dong Aisheng
