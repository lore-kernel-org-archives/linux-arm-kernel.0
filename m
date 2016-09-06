From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 6 Sep 2016 07:53:41 +0200
Subject: irq_create_fwspec_mapping() in 4.8-rc2
In-Reply-To: <CACRpkdaUviHgUtLhTPTRuW5rk=tZsvgYAJLqNFtz1u+q2jbM2w@mail.gmail.com>
References: <483F737F-9868-4E8A-A831-AA3F6F410AFF@gmail.com>
 <57C98975.5020607@arm.com> <9FCA11A3-B677-42EA-80DB-674AC8E489E8@gmail.com>
 <57C99111.3030105@arm.com> <F5716CCD-34FF-4CA8-B5F5-C2A33A5D9E91@gmail.com>
 <57C9961F.8080602@arm.com> <B721D80D-B240-4779-8748-5CFAD330D986@gmail.com>
 <57C99B3D.3010405@arm.com>
 <CACRpkdYjmkkDxVah1HUNxoGEQ9hJeE-J1TwZ1wNEKq=swnL9JQ@mail.gmail.com>
 <57CD6B87.5010502@arm.com>
 <CACRpkdaUviHgUtLhTPTRuW5rk=tZsvgYAJLqNFtz1u+q2jbM2w@mail.gmail.com>
Message-ID: <7fc3ddc5-bb20-be88-f62e-72f0176011db@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/09/2016 ? 23:41, Linus Walleij a ?crit :
> On Mon, Sep 5, 2016 at 2:56 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
>> OK, I'll whip up a patch shortly. Should I also address the handful of
>> other non-TYPE_NONE that we have in the tree:
>>
>>         drivers/gpio/gpio-sx150x.c
>>         drivers/pinctrl/nomadik/pinctrl-nomadik.c
>>         drivers/pinctrl/pinctrl-coh901.c
>>         drivers/pinctrl/pinctrl-st.c
>>
>> But the bigger question is whether or not there is any value in the
>> pinctrl driver providing a default value at all. Do we have any case
>> where the trigger information is not provided by the firmware (DT or
>> ACPI), and where we rely on the default being set?
> 
> That happened with boardfiles. Which used to be the case with
> some of these, but AFAICT not any longer. I am uncertain about
> sx150x though.

FYI: Must have been this boardfile historical reason for at91 as well.
As we only rely on DT now, we're safe.

Bye,

> In the boardfile case, I think actually the driver is responsible to
> set up the kind of interrupt trigger it wants (well it still can...
> but it should nowadays trust what it is given) but very often that
> did not happen, instead the drivers relied on hacks like these to
> have set up a default trigger type.
> 
> Yours,
> Linus Walleij
> 


-- 
Nicolas Ferre
