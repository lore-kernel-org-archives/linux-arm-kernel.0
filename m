From: jaswinder.singh@linaro.org (Jaswinder Singh)
Date: Mon, 27 Jun 2011 16:40:41 +0530
Subject: [PATCH] OMAP4: PANDA, SDP: Fix EHCI regulator supply
In-Reply-To: <20110627101139.GK2508@legolas.emea.dhcp.ti.com>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
	<BANLkTin=-cRC_ax8AakMD1UZtU+AQ0H==w@mail.gmail.com>
	<20110627080036.GB2508@legolas.emea.dhcp.ti.com>
	<BANLkTinVdWjoS-qdGnSxGnmrPKHSDNV7hw@mail.gmail.com>
	<20110627083507.GG2508@legolas.emea.dhcp.ti.com>
	<BANLkTim9Wbxo5U77Vo=FFxYU4vsUps7GMA@mail.gmail.com>
	<20110627101139.GK2508@legolas.emea.dhcp.ti.com>
Message-ID: <BANLkTikDBQfxFsUFQcJTo_Nj93VYzbnsfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 June 2011 15:41, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Jun 27, 2011 at 03:35:41PM +0530, Jaswinder Singh wrote:
>> On 27 June 2011 14:05, Felipe Balbi <balbi@ti.com> wrote:
>> >> >> > +static struct regulator_consumer_supply sdp4430_vusb_supply =
>> >> >> > + ? ? ? REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");
>> >> >
>> >> > this should be an array.
>> >> Ok, I can make it an array of _one_ element.
>> >> Though I am not sure why is that a good thing, or are we to use another
>> >> possible VUSB supply on Panda/SDP boards ? ?Please suggest so that
>> >> I can add that too.
>> >
>> > same comment I gave before to another patch:
>> >
>> > it makes the diff a lot easier to understand should anyone modify this
>> > later. It's also a matter of consistency.
>> >
>> A quick grep showed otherwise though ...
>>
>> In arch/arm/mach-omap2/
>> Total regulators defined ? ? ? ? ? ? ? ? ? ? ? ? ?= ?71
>> Regulators with exactly 1 supply ? ? ? ? ? = ? 58
>> Single element non-array definitions ? ? = ?46/58
>> Single element array definitions ? ? ? ? ? ? = ?12/58
>>
>> Even if we consider 20% to be norm for consistency, I am not sure it's
>> a good one.
>
> the patch which converted all non-array, to array seems to have been
> taken yet, then.
>
Ok, I don't have that patch. If everything else has been converted
then there is no point in sticking out. Please let me know which repo has that.
I'll adapt to that.

>> And, I don't understand how does diff become any easier beyond 2
>> elements in the array.
>
> http://marc.info/?l=linux-omap&m=130738044715490&w=2
>
Yes, that's why I said "beyond 2 elements"
Only, if any, "difficulty" would be _first_ time when someone patches
to add second supply.
After that it'll just be same as you expect.

>> Sorry for being bitchy, but I am unable to buy any reason other than
>> having more than
>> one element to use array.
>
> I also seem to recall someone (either Russell or Linus) once explained
> why we should never mistake one-element arrays with pointers.
> Unfortunately, I fail to find the thread, it's quite old.
Yes, I vaguely remember the thread, but not sure if it's issue here.

-j

-- 
Linaro.org ? Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106 ?-
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
