From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 5 Feb 2016 21:03:43 +0800
Subject: [PATCH v4 1/1] USB: core: let USB device know device node
In-Reply-To: <1454665020.6406.21.camel@pengutronix.de>
References: <1453706679-18948-1-git-send-email-peter.chen@freescale.com>
 <1454582690.3356.18.camel@pengutronix.de> <20160205061124.GB1858@shlinux2>
 <1454665020.6406.21.camel@pengutronix.de>
Message-ID: <CAL411-rEqqQA=mJ64eqqawWOXTJ3FK6nKjGu=09RmofvOnz4Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 5, 2016 at 5:37 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Am Freitag, den 05.02.2016, 14:11 +0800 schrieb Peter Chen:
> [...]
>> > The reference recommendation states that for single-configuration USB
>> > devices the compatible should contain all of the applicable strings from
>> > the list starting with 2) "usbVID,PID.REV" and ending with 11)
>> > "usb,device". Are we going to ignore this?
>>
>> I have not seen benefits if we write several compatibles in dts,
>> the information of compatibles listed in doc can be got during
>> the enumeration.
>>
>> I suggest we use the simple pattern for this compatible, in that
>> case, every one can be easy to follow it, and will not be confused
>> which compatibles should be used, and the style can be unify.
>
> Just pointing it out, a comment why this differs from the recommendation
> would be nice to avoid confusion.
>

Thanks, I will.

> [...]
>> > > +         compatible = "usb05e3,0608";
>> > > +         reg = <0x1>;
>> > > + };
>> >
>> > I'd have written this node as:
>> >
>> >     hub: hub at 1 {
>> >             compatible = "usb5e3,608", "usb5e3,class9",
>> >                          "usb,class9", "usb,device";
>> >             reg = <1>;
>> >     };
>>
>> The reg should be hexadecimal, do we need to add "0x" before the value?
>
> The unit-address name part should be hexadecimal, the reg property value
> doesn't have to be. As long as the value is < 10 I don't see a problem.
>

I see.

>> > As another example, I'd like to introduce the USB WLAN Adapter soldered
>> > onto the imx6q-gk802 board to its power enable GPIO via the device tree:
>> >
>> > /* Internal USB port (USBH1) */
>> > &usbh1 {
>> >     #address-cells = <1>;
>> >     #size-cells = <0>;
>> >     status = "okay";
>> >
>> >     /* RTL8192CU 802.11n WLAN Adapter */
>> >     device at 1 {
>> >             compatible = "usbbda,8176.200", "usbbda,8176",
>> >                          "usb,device";
>> >             reg = <1>;
>> >
>> >             enable-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
>> >     };
>> > };
>> >
>>
>> It is okay to use your example, but I still insist like below:
>
> Sorry for being imprecise. The hub example is fine for the
> documentation. I just wanted to illustrate how and why I am interested
> in this discussion.
>

Thanks for commenting it.

I will be in Chinese New Year holiday, will send next version after Feb 15th.

-- 
BR,
Peter Chen
