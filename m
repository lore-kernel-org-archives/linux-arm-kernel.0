From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Feb 2017 15:44:42 +0100
Subject: [PATCH 1/4] PCI: add DT bindings for Cortina Gemini PCI Host
 Bridge
In-Reply-To: <7079928.XO1j93ERJc@wuerfel>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <7079928.XO1j93ERJc@wuerfel>
Message-ID: <CACRpkdZtuqF-ekNzVTNY4BBCt2bG6NcTAFs-ARYGw7q5E=jBTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2017 at 12:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday, January 28, 2017 9:48:36 PM CET Linus Walleij wrote:
>> +       pci_intc: interrupt-controller {
>> +               interrupt-controller;
>> +               #address-cells = <0>;
>> +               #interrupt-cells = <1>;
>> +       };
>
> I think this one needs at least an interrupt-parent property, otherwise
> you would recursively translate the numbers back through the interrupt-map
> property of its parent.

OK I added this, I think it was the cause of the error Hand Uli Kroll
was seeing. I guess I didn't run into it because I was only testing the
device in slot 9 so everything was defaulting to zero.

Yours,
Linus Walleij
