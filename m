From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 20 Nov 2014 12:22:19 -0800
Subject: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <546E0970.5090301@ti.com> (Grygorii Strashko's message of "Thu,
 20 Nov 2014 17:32:00 +0200")
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
 <1709760.E0jX3Myv0h@wuerfel> <546C7FDD.7030906@ti.com>
 <2900095.WIocOu7ue2@wuerfel>
 <CAPDyKFqeZ3YU2OEN4tCOdcQ0pAho67Q8U_eCEOroG9aS0mp+-Q@mail.gmail.com>
 <546DD87B.3080806@ti.com>
 <CAPDyKFrBhZyqozM98_4pPdW0EMFt5W6VX1X7cz6Z=yNhW4vYTA@mail.gmail.com>
 <CAMuHMdWtHT7QX3Kpa-GCLa49ToGODwjnNVgfxDzJzcM-FU1ffg@mail.gmail.com>
 <546E0970.5090301@ti.com>
Message-ID: <7hh9xtr5ac.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> On 11/20/2014 03:32 PM, Geert Uytterhoeven wrote:
>> On Thu, Nov 20, 2014 at 2:12 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

[...]

>>> So I really think we need to decide on how to address the split of the
>>> device clocks. Before that's done, I don't think it make sense to add
>>> a "simple-pmdomain" compatible, since it will likely not be that many
>>> SoC that can use it.
>>>
>>> So, does anyone have a suggestion on how to deal with the split of the
>>> device clocks into "functional" clocks and into "PM" clocks?
>
> Would it be better to say "functional" and "optional"? In my opinion
> "PM" == "functional". Also, such clock's separation is used in TRM/DM/UMs on HW.

Yes!  I really don't like the name "PM" clock, since it's not at all
obvious what that means.  To me, "PM" == "functional" as well.

So what exactly are we talking about with "PM" clocks, and why are they
"special" when it comes to PM domains?  IOW, why are the clocks to be
managed during PM domain transitions for a given device any different
than the clocks that need to be managed for a runtime suspend/resume (or
system suspend/resume) sequence for the same device?

Kevin
