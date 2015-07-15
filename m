From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed, 15 Jul 2015 13:58:15 -0700
Subject: [PATCH] ARM: BCM: Restrict Broadcom BCM470X / BCM5301X to non-LPAE
In-Reply-To: <5941809.XWvPzT6esn@wuerfel>
References: <1436897535-3782-1-git-send-email-f.fainelli@gmail.com>
 <9845978.JUsldTlF3B@wuerfel> <55A68C9C.8000303@gmail.com>
 <5941809.XWvPzT6esn@wuerfel>
Message-ID: <CADtm3G6A=VO7eB4nDMnWEj+1BAjEN4OJnO1Msf8KPBn2tx6DJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 1:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 15 July 2015 09:38:52 Florian Fainelli wrote:
>>
>> I like the idea in general, but I think this is going to be a very
>> tedious job to collect every single CR values for ARMv7 processors to
>> determine whether they are pure v7 or v7e... Maybe we could use
>> kernelci.org to start extracting the relevant lines in bootlogs and
>> people can start adding their own chips one by one?
>
> No, we know most of them:
>
> Cortex-A5, A8, A9: ARMv7, no LPAE, no IDIV
> Cortex-A7, A15, A12, A17: ARMv7VE, no LPAE, no IDIV
>
>
> Almost everyone uses the above cores unmodified.
>
> The ones I'm not 100% sure about are:
>
> [...]
> Broadcom Brahma-B15 (almost certainly ARMv7VE)

Confirmed, B15 is ARMv7VE.
