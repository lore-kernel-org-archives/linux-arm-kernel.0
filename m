From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 20 Nov 2014 17:30:53 -0800
Subject: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <CAMuHMdVXGPu7x706NxqO3rn3KuRbPbD_ZQsJtDH4Hf31AaRR+Q@mail.gmail.com>
 (Geert Uytterhoeven's message of "Thu, 20 Nov 2014 22:54:07 +0100")
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
 <1709760.E0jX3Myv0h@wuerfel> <546C7FDD.7030906@ti.com>
 <2900095.WIocOu7ue2@wuerfel>
 <CAPDyKFqeZ3YU2OEN4tCOdcQ0pAho67Q8U_eCEOroG9aS0mp+-Q@mail.gmail.com>
 <546DD87B.3080806@ti.com>
 <CAPDyKFrBhZyqozM98_4pPdW0EMFt5W6VX1X7cz6Z=yNhW4vYTA@mail.gmail.com>
 <CAMuHMdWtHT7QX3Kpa-GCLa49ToGODwjnNVgfxDzJzcM-FU1ffg@mail.gmail.com>
 <546E0970.5090301@ti.com> <7hh9xtr5ac.fsf@deeprootsystems.com>
 <CAMuHMdV7zASj8_NtLRir1VubXEKTkq0vBGMXeYXDACu8UC2tZA@mail.gmail.com>
 <7hbno1r1af.fsf@deeprootsystems.com>
 <CAMuHMdVXGPu7x706NxqO3rn3KuRbPbD_ZQsJtDH4Hf31AaRR+Q@mail.gmail.com>
Message-ID: <7hppchpcfm.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Thu, Nov 20, 2014 at 10:48 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>>> So what exactly are we talking about with "PM" clocks, and why are they
>>>> "special" when it comes to PM domains?  IOW, why are the clocks to be
>>>> managed during PM domain transitions for a given device any different
>>>> than the clocks that need to be managed for a runtime suspend/resume (or
>>>> system suspend/resume) sequence for the same device?
>>>
>>> (Speaking for my case, shmobile)
>>>
>>> They're not. The clocks to be managed during PM domain transitions are the
>>> same as the clocks that need to be managed for a runtime suspend/resume
>>> (or system suspend/resume) sequence.
>>>
>>> The special thing is that this is more a platform than a driver thing: the same
>>> module may have a "PM/functional" clock (that is documented to enable/disable
>>> the module) on one Soc, but noet on another.
>>
>> So why isn't the presence or absence of the clock described in the .dtsi
>> for the SoC instead of being handled by special PM domain logic?
>
> It is. Cfr. the presence/absence of clocks for renesas,rcar-gpio nodes.

Hmm, OK, Good.  

So now I'm confused about why the PM domain has to do anything special
if the presence/absence of the clocks is already handled by the DT.

Kevin
