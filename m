From: robherring2@gmail.com (Rob Herring)
Date: Tue, 22 Apr 2014 13:54:33 -0500
Subject: [PATCH 1/6] ata: ahci: add AHCI support for Berlin SoCs
In-Reply-To: <CAL_JsqKE_Z3kBhS1VaQADV5ob8x6AKHhbHaQEGoVSwkwdd50zA@mail.gmail.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
 <CAL_JsqKE_Z3kBhS1VaQADV5ob8x6AKHhbHaQEGoVSwkwdd50zA@mail.gmail.com>
Message-ID: <CAL_JsqJwC2xcZakXiJXJscK7tN7xt2OotBKyr9u+aK3bOP+7GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 1:47 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Apr 22, 2014 at 10:38 AM, Antoine T?nart
> <antoine.tenart@free-electrons.com> wrote:
>> Add support for the Berlin SoCs AHCI SATA controller allowing to
>> interface with devices like external hard drives.

One more thing.

>> +       nports = readl(hpriv->mmio + HOST_PORTS_IMPL);
>> +
>> +       /* force_map is modified only if the property is found */
>> +       of_property_read_u32(np, "marvell,force-port-map", &force_map);

This property does not appear to be documented.

>> +       if (force_map)
>> +               nports = force_map;

You don't need this as your comment says, you can just do:

of_property_read_u32(np, "marvell,force-port-map", &nports);

nports will only be changed if property is present.

Rob
