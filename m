From: robherring2@gmail.com (Rob Herring)
Date: Fri, 26 Sep 2014 13:26:09 -0500
Subject: [PATCH 3/6] pci,
 thunder: Add PCIe host controller devicetree bindings
In-Reply-To: <3082935.e3X4GsVUDn@wuerfel>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <1411573068-12952-4-git-send-email-rric@kernel.org>
 <3082935.e3X4GsVUDn@wuerfel>
Message-ID: <CAL_JsqK2bqsbjEf2OngL2=Xr8t0AUobb_bd43BV4t9iXY-n6KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 11:06 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 24 September 2014 17:37:45 Robert Richter wrote:
>>
>> +       pcie0 at 0x8480,00000000 {
>
> The name should be pci, not pci0.

And the address should be "@848000000000". There was some confusion
about when the comma should be used and it is only if you have things
like PCI bus, device, function for the addressing.


>
>> +               compatible = "cavium,thunder-pcie";

A bit too generic as many of the Cavium bindings have been.

Rob
