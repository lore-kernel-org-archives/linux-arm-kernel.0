From: javier.martin@vista-silicon.com (javier Martin)
Date: Thu, 21 Feb 2013 15:18:36 +0100
Subject: [PATCH 0/3] crypto: sahara: Add support for SAHARA in i.MX27.
In-Reply-To: <201302211259.26763.arnd@arndb.de>
References: <1361449162-27302-1-git-send-email-javier.martin@vista-silicon.com>
 <201302211259.26763.arnd@arndb.de>
Message-ID: <CACKLOr1-EPK=DLz0SY+1E35qSMdtCsueuqdzV4VZdbkoM+TD6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 21 February 2013 13:59, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 21 February 2013, Javier Martin wrote:
>> This series of patches provide AES-ECB and AES-CBC support
>> for the SAHARA2 cryptographic accelerator which is inside the i.MX27 SoC.
>> It is expected that more algorithms will be supported in the future.
>>
>> For testing, a Visstrim M10 board has been used and the code related
>> to this platform has been included too.
>
> As a new device driver, this needs to be supported on the DT based imx27
> machines, while support for the individual board files seems unnecessary.
>
> How about converting the Visstrim M10 board file over to DT so you don't
> have to add any more infrastructure for imx that we will just have to
> remove again one day?

We know about the existence of DT and the constant migration process
that is taking place towards it.

Moreover we are strongly interested in converting the Visstrim SM10
platform to DT. Unfortunately, there are several issues that need to
be solved so that Visstrim M10 can be fully converted to DT:
- full SoC camera DT support
- DT support for ov7670
- pinctrl support for i.MX27

Furthermore, we have limited resources at the moment and we have to
decide priorities. But having an hybrid platform-DT support is our
next task for Visstrim M10.

However, I understand your concern about new drivers having DT
support. Maybe a good approach could be that I added compile-tested
only DT support for this driver and remove platform support for
mainline submission (although we maintain it internally in our
repositories).

What do you think?

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
