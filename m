From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Thu, 25 May 2017 11:31:12 +0300
Subject: [PATCH v2 1/2] ARM: dts: orange-pi-zero: specify wifi interrupts
In-Reply-To: <CAGb2v671hWDaTqCAJiN0JAuiPynW+=XtN+Xr5WiyTPDSkk9-FQ@mail.gmail.com>
References: <20170524212433.14386-1-geomatsi@gmail.com>
 <20170524212433.14386-2-geomatsi@gmail.com>
 <CAGb2v647GTQW9-ZYrkWS7RoeYTu_7oTm8v4PDs0YD1pZ8oUohQ@mail.gmail.com>
 <20170525071055.xdd4sbpnzlkg7wa2@speedy.hunter>
 <CAGb2v671hWDaTqCAJiN0JAuiPynW+=XtN+Xr5WiyTPDSkk9-FQ@mail.gmail.com>
Message-ID: <CAFGfvX60+-UsJ_t-ABuZoToLTgi2rW2wRqE7Dxe9+dc4muUAEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Does it make sense for the out-of-tree driver ?
>
> There is already a binding for ESP8089, which is supported out of tree.
> There are also bindings for Mali GPUs which are, again, supported out
> of tree.
>
> AFAIK there was some discussion about this during the submission of the
> Mali bindings. A set of stable bindings allows the vendor to create stable
> device trees. Given that the binding for this WiFi chip is relatively simple,
> and it might be compatible or similar to an existing chip already supported
> in kernel (but without a binding), it should be straight forward.

Thanks for pointing at these examples! According to linux-sunxi.org wiki this
wireless chip might be related to ST cw1200 (drivers/net/wireless/st/cw1200).
I will check if it has any bindings as well.

>
>>
>>> > +               interrupt-parent = <&pio>;
>>> > +               interrupts = <6 10 IRQ_TYPE_EDGE_RISING>;
>>>
>>> Are these optional or required properties? AFAIK SDIO supports in-band
>>> interrupts with a bit of overhead, so they should be optional.
>>
>> Those properties are optional. Driver works anyway, though it complains about
>> missing interrupts. IIUC xradio driver falls back to polling mode only if
>> xr819 interrupt configuraton is not specified.
>
> So it doesn't support in-band SDIO interrupts right now. Is that a hardware
> or driver limitation?

I have no idea. I haven't yet had a chance to hack around this driver:
only basic testing
and brief comparison with cw1200 driver.

Regards,
Sergey
