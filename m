From: olof@lixom.net (Olof Johansson)
Date: Sun, 15 Jul 2018 17:25:06 -0700
Subject: [GIT PULL] pxa for v4.19
In-Reply-To: <20180714215225.vtclgbczy4c6znxy@localhost>
References: <87va9kb3xs.fsf@belgarion.home>
 <20180714215225.vtclgbczy4c6znxy@localhost>
Message-ID: <CAOesGMjdocdk9OE+Dbi2frbM5chcj+ciNhJJ9x1bdNs0TZUjkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2018 at 2:52 PM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Jul 12, 2018 at 10:21:35PM +0200, Robert Jarzmik wrote:
>> Hi Arnd, Kevin, and Olof,
>>
>> This is the pxa pull request for 4.19. This time it touches a lot of subsystems
>> because of the dma slave map conversion of the pxa architecture.
>>
>> And there is one catch : the build of pxa defconfigs will probably fail in your
>> arm-soc tree, while it will succeed in -next tree. The reason of the failure is
>> that one patch, namely "dmaengine: pxa: make the filter function internal",
>> depends on one patch queued in Mark Brown's tree.
>> If that is a problem for you, I'll postpone this patch, and resend a new pull
>> request if you ask it.
>>
>> Can you please consider pulling ?
>>
>> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>
>>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>
>> are available in the git repository at:
>>
>>   https://github.com/rjarzmik/linux.git tags/pxa-for-4.19
>>
>> for you to fetch changes up to 0d0b16b8e008825834684163799ab944920aabce:
>>
>>   dmaengine: pxa: make the filter function internal (2018-06-29 22:30:14 +0200)
>>
>> ----------------------------------------------------------------
>> This is the pxa changes for 4.19 cycle :
>>  - the pxa architecture is ported to dma slavemap
>>  - some minor AC97 fixes
>>  - some minor board fixes
>>
>> ----------------------------------------------------------------
>> Robert Jarzmik (17):
>>       dmaengine: pxa: use a dma slave map
>>       ARM: pxa: add dma slave map
>>       dmaengine: pxa: add a default requestor policy
>>       mmc: pxamci: remove the dmaengine compat need
>>       media: pxa_camera: remove the dmaengine compat need
>>       mtd: rawnand: marvell: remove the dmaengine compat need
>>       ata: pata_pxa: remove the dmaengine compat need
>>       dmaengine: pxa: document pxad_param
>>       ARM: pxa: remove the DMA IO resources
>>       ARM: pxa: change SSP DMA channels allocation
>>       ARM: pxa: hx4700: fix the usb client
>>       ARM: pxa: mioa701 convert to the new AC97 bus
>>       ARM: pxa: add the missing AC97 clocks
>>       ARM: pxa: zylonite: use the new ac97 bus support
>>       net: smc911x: remove the dmaengine compat need
>>       net: smc91x: remove the dmaengine compat need
>>       dmaengine: pxa: make the filter function internal
>
> Looks like the external patches all have acks, so I've merged this. Thanks.

Based on the reported build breakage in next, and the fact that this
is the topmost merge in the SOC branch so a reset is easy, I've
dropped it.

Please resend without the breakage. If the changes that cleans up the
API that breaks things are trivial we can maybe merge them after -rc1,
if not we should probably wait until next release cycle for those.


-Olof
