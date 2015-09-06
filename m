From: robherring2@gmail.com (Rob Herring)
Date: Sun, 6 Sep 2015 15:57:22 -0500
Subject: [PATCH v2 07/10] dts/ls2085a: Update DTSI to add support of
 various peripherals
In-Reply-To: <BY1PR0301MB130306991ACB28E4C8109DD582560@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1441350322-4671-1-git-send-email-bhupesh.sharma@freescale.com>
 <CADRPPNQER9UnKLazm9C6Dd7DAkDxLb4QShK64tmtahZxJJ-t=g@mail.gmail.com>
 <BY1PR0301MB130306991ACB28E4C8109DD582560@BY1PR0301MB1303.namprd03.prod.outlook.com>
Message-ID: <CAL_Jsq+KJU4RiK2XWcS5BezucCmup2M-pueaaJUq7O=fA3LUxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 5, 2015 at 3:37 AM, Sharma Bhupesh
<bhupesh.sharma@freescale.com> wrote:
>> From: pku.leo at gmail.com [mailto:pku.leo at gmail.com]
>> Sent: Saturday, September 05, 2015 2:33 AM
>> On Fri, Sep 4, 2015 at 2:05 AM, Bhupesh Sharma
>> <bhupesh.sharma@freescale.com> wrote:
>> > This patch updates the LS2085a DTSI (DTS Include) file to add support
>> > for various peripherals supported by FSL LS2085a SoC, for e.g.:
>>
>> The title and description here are still using the old LS2085 name.
>
> Ok.
>
> [snip] ..
>
>> > +       amba {
>> > +               compatible = "arm,amba-bus";
>> > +               #address-cells = <2>;
>> > +               #size-cells = <2>;
>> > +               ranges;
>> > +
>> > +               cluster1_core0_watchdog: wdt at c000000 {
>> > +                       compatible = "arm,primecell";
>>
>> Binding of Primecell requires a specific name for the device instead of
>> just a "arm,primecell".
>
> The sp805 driver doesn't have a compatible string like arm, sp805.
> You can refer to 'Documentation/devicetree/bindings/wdt' for details - there is no entry for sp805 here.

Because no one wrote it yet. Please read
Documentation/devicetree/bindings/arm/primecell.txt. If sp805 has no
binding doc, please write one.

> Instead it relies on the 'drivers/amba/bus.c' framework to invoke the probe function of the
> sp805 wdt driver using the unique PRIMECELL identifiers of the sp805 wdt IP.

Whether the kernel chooses to bind with the ID registers or compatible
strings is up to the kernel. That is independent of the bindings.

Rob
