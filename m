From: robherring2@gmail.com (Rob Herring)
Date: Mon, 9 Jun 2014 14:00:25 -0500
Subject: [PATCH 1/3] ARM: mvebu: clean-up unneeded kconfig selects
In-Reply-To: <20140609184337.GA9790@arch.cereza>
References: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
 <1398195678-28787-2-git-send-email-robherring2@gmail.com>
 <20140609184337.GA9790@arch.cereza>
Message-ID: <CAL_JsqLn6ZgprgmKJYfnTJY99JCx2DHjFzvkmhZMSCCx4tyVJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 9, 2014 at 1:43 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Hi Rob,
>
> On 22 Apr 02:41 PM, Rob Herring wrote:
>> @@ -11,7 +10,6 @@ config ARCH_MVEBU
>>       select ARCH_REQUIRE_GPIOLIB
>>       select MIGHT_HAVE_PCI
>>       select PCI_QUIRKS if PCI
>> -     select OF_ADDRESS_PCI
>>
>
> We needed that one, as Gregory introduced it specifically so we could select it
> without selecting PCI.
>
> I'll cook a patch right away, sorry for not seeing this earlier!

What exactly depends on this? It seems strange to have this
dependency. Some !OF compiling changes for PCI functions went in for
3.16 which may help here.

Rob
