From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 15 Jul 2015 11:45:07 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <20150604171547.GA1530@localhost.localdomain>
References: <cover.1433364398.git.hramrach@gmail.com>
 <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
 <CAMuHMdVT2M7pPHDDHmoNF_zVXhz1PUm5PiYxDKcAjSAcfSDiZg@mail.gmail.com>
 <CAOMqctS6KNrTATB6MYCZLBnZUQmX=e0qQvGf78YtLaF8pkibhQ@mail.gmail.com>
 <20150604171547.GA1530@localhost.localdomain>
Message-ID: <CAOMqctSCL9E-kCBryeaMvtssSP12RY=kyfPuwSYx9wc=Lv9kGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 June 2015 at 19:15, Richard Cochran <richardcochran@gmail.com> wrote:
> On Thu, Jun 04, 2015 at 10:31:45AM +0200, Michal Suchanek wrote:
>> You might want to try to run the bus at 60MHz or 80MHz and then the
>> values would probably again be different.
>>
>> The first two values are set in DT so the logical place for setting
>> the third is also in DT.
>>
>> Otherwise you would need some in-kernel table of these settings.
>
> Or a formula.
>

This formula probably needs to take into account

 - the unknown reason for the pl330 to fail transfer
 - the device transfer speed and transfer phase as set in DT
 - possibly device-specific latency and board-specific trace design
and assembly tolerances

Seriously, until I have at least a vague idea why the transfer fails I
am not comfortable pulling some formula out of thin air and pretending
I have a working patch.

On the other hand, a parameter you can set in the DT and which comes
with a suggested value which can be tuned depending on the system
seems more viable.

Thanks

Michal
