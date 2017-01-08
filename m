From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sun, 8 Jan 2017 15:07:03 +0900
Subject: [PATCH v5 5/5] arm64: dts: exynos: Add tm2 touchkey node
In-Reply-To: <20170108054504.fssqicmeovufar2r@jack.zhora.eu>
References: <CGME20170106134356epcas1p1aee9f715c58b50f6056bf0b43b849497@epcas1p1.samsung.com>
 <20170106134350.32428-1-andi.shyti@samsung.com>
 <20170106134350.32428-6-andi.shyti@samsung.com>
 <CAGTfZH2QYQK190kYFbOMqJMFgH32548ra-VqzYwc5LVBJwqisA@mail.gmail.com>
 <CAGTfZH347ZRve20cdGLwtuf6arRAJ4Ry+HQrTubDj-RGR=K9cA@mail.gmail.com>
 <CAGTfZH1QtbieMxQzoPvxsP_3tSYBSuXe+wtq0uUs03mhcLFdXg@mail.gmail.com>
 <20170107124026.gl447hl5bucdflyk@jack.zhora.eu>
 <CAGTfZH35sx5v-XcxkDG7TVRmW8cLirAXRxA=kGZQDBnpw3vYhg@mail.gmail.com>
 <20170108054504.fssqicmeovufar2r@jack.zhora.eu>
Message-ID: <CAGTfZH1CuMxhaqPJCzxgF8p39OAu+o0GDJEsh5DVGtU-hqfxvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi,

2017-01-08 14:45 GMT+09:00 Andi Shyti <andi@etezian.org>:
> Hi Chanwoo,
>
>> >> >>> +       touchkey at 20 {
>> >> >>> +               compatible = "samsung,tm2-touchkey";
>> >> >>> +               reg = <0x20>;
>> >> >>> +               interrupt-parent = <&gpa3>;
>> >> >>> +               interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>> >> >>> +               vcc-supply = <&ldo32_reg>;
>> >> >>> +               vdd-supply = <&ldo33_reg>;
>> >> >>> +       };
>> >> >>> +};
>> >> >>> +
>> >> >>>  &ldo31_reg {
>> >> >>>         regulator-name = "TSP_VDD_1.85V_AP";
>> >> >>>         regulator-min-microvolt = <1850000>;
>> >>
>> >> I repiled the touchkey driver against compatible name.
>> >> Usually, when developing the device driver, we use the specific h/w name
>> >> but in this patch, the touckey dt node uses the h/w board name instead of
>> >> original touckhey name.
>> >
>> > this should be a device specifically done for the tm2 and we are
>> > not sure who is the manufacturer of the device. In order to not
>>
>> As I knew, this touchkey was made by Cypress semiconductor.
>> But, for more correct information, you may try to find it.
>
> The Android Kernel says that this is the cy8cmbr3xxx. I
> downloaded the datasheets, but it doesn't have any similarity
> with the device. Which means that on tm2 we don't the
> cy8cmbr3xxx bot something else that I even doubt comes from
> cypress, but I strongly believe it's a dedicated hardware.

Although this device is a dedicated h/w, you should keep the principal.
Did you check the schematic document of TM2? The schematic document
might include the specific device name.

Sometimes, the downloaded datasheet does not include the
all of information of device because of confidential information.
But, I?m not sure. Just it is guess as my experience.

I want to check the manufacturer and name of device with you
on next Monday.

>
> Now we have two choices:
>
> 1. drop support because we are not 100% sure on the device and
> supplier.
>
> 2. call it Samsung and provide support anyway as, at the end, it
> is a samsung hardware.
>
> With Jaechul we chose option 2.
>
>> > assign the device to the wrong manufacturer, we preferred calling
>> > it Samsung as it is in a Samsung device.
>>
>> As you mentioned, Samsung made not this touchkey device. It is
>> certainly wrong manufacturer. I have not seen to use the h/w board
>> name as the peripheral device name.
>>
>> I don't prefer to use the inaccurate manufacturer and device name.
>
> Eventually, Jaechul can assign the device to cypress, but the
> name has to remain tm2-touchkey. Something like this:
>
>         compatible = "cypress,tm2-touchkey";
>
> What do you think?

If we never to find the correct device name, we might use your suggestion.
As I already said, I?d like to check it again with you.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
