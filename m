From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 31 Mar 2015 11:11:44 +0200
Subject: [PATCH v2 3/5] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <1426674930.2649.50.camel@tiscali.nl>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
 <1426515635-9466-4-git-send-email-gabriel.fernandez@linaro.org>
 <1426518695.26437.55.camel@x220> <55093C12.7070004@st.com>
 <1426674930.2649.50.camel@tiscali.nl>
Message-ID: <CAG374jCjTVBwiNrWoo=X9hUSb-etzn8G-XSXGO_nNYhiL_9k_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

pci-st.c driver could be modular with modification of pcie-designware
core driver. But as Fabrice said  it should be another patchset.

What do you prefer ?

drop all the module related macros as mentioned by Paul ?
or
keep macros like other vendors do ?

Thanks

Gabriel

On 18 March 2015 at 11:35, Paul Bolle <pebolle@tiscali.nl> wrote:
> Hi Fabrice,
>
> Fabrice Gasnier schreef op wo 18-03-2015 om 09:49 [+0100]:
>> On 03/16/2015 04:11 PM, Paul Bolle wrote:
>> >> +config PCI_ST
>> >> +  bool "ST PCIe controller"
>> > You add a bool Kconfig symbol. A week or two ago I saw some patches fly
>> > by that - I think - allowed PCIe controllers to be built modular.
>>
>> Thanks for your review.
>>
>> Are you talking about "PCI: Export symbols of PCI functions" patch, that
>> is part of a series
>> named "pci: iproc: Add Broadcom iProc PCIe support" ?
>
> Yes, that is the series I was thinking about. (I made you search lkml,
> and that was a bit rude. But you found the patch anyhow.)
>
>> This controller doesn't look like to be based on pcie-designware core
>> driver.
>> Other vendors that are using "pcie-designware" core driver are also make
>> it bool.
>> The current core driver doesn't support module loading/unloading as I
>> see it.
>> If this is required, I also think this should be part of another patchset.
>>
>> What do you think ?
>
> I wouldn't know whether your driver might work as a loadable module, but
> other people reading this surely will. But if it can't work as a module
> you should drop all the module related macros etc. I spotted. Because
> then they serve no purpose.
>
>
> Paul Bolle
>
