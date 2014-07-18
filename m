From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 18 Jul 2014 16:29:16 -0400
Subject: [PATCH v6 4/5] PCI: add PCI controller for keystone PCIe h/w
In-Reply-To: <CAL_JsqKheoWrSGtxPO=AE8g9iOAqfwRa=81Ku=Cfx8_gpDysOg@mail.gmail.com>
References: <1405696469-7172-1-git-send-email-m-karicheri2@ti.com>
 <1405696469-7172-5-git-send-email-m-karicheri2@ti.com>
 <CAL_JsqKheoWrSGtxPO=AE8g9iOAqfwRa=81Ku=Cfx8_gpDysOg@mail.gmail.com>
Message-ID: <53C9839C.5090604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On 07/18/2014 03:31 PM, Rob Herring wrote:
> On Fri, Jul 18, 2014 at 10:14 AM, Murali Karicheri<m-karicheri2@ti.com>  wrote:
--- Cut ---
>> +
>> +Optional properties:-
>> +       phys: phandle to Generic Keystone SerDes phy for PCI
>> +       phy-names: name of the Generic Keystine SerDes phy for PCI
>> +         - If boot loader already does PCI link establishment, then phys and
>> +           phy-names shouldn't be present.
>> +       ti,enable-linktrain - Enable Link training.
>> +         - If boot loader already does PCI link establishment, then this
>> +           shouldn't be present.
>
> Can't you read from the h/w if the link is trained?

Yes.

There are customers who use this driver with PCI Link setup done in the 
boot loader. This property tells the driver to bypass Link setup 
procedure in that case. Is this undesirable and if so. how other 
platforms handle it? Check first if link is trained or start the link 
setup procedure? Let me know. If this is fine, please provide your Ack.

Thanks.

Murali
>
> Rob
