From: arend@broadcom.com (Arend van Spriel)
Date: Tue, 9 Dec 2014 11:19:40 +0100
Subject: using DMA-API on ARM
In-Reply-To: <5485D97D.1040404@broadcom.com>
References: <5481794E.4050406@broadcom.com>
 <F51492713EF10846800D8C0ED37A7DCE01901765@SJEXCHMB15.corp.ad.broadcom.com>
 <F51492713EF10846800D8C0ED37A7DCE01902076@SJEXCHMB15.corp.ad.broadcom.com>
 <2863746.4sUSEYqahB@wuerfel>
 <20141208160316.GM16185@e104818-lin.cambridge.arm.com>
 <5485D97D.1040404@broadcom.com>
Message-ID: <5486CCBC.3@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/14 18:01, Arend van Spriel wrote:
> On 12/08/14 17:03, Catalin Marinas wrote:
>> On Mon, Dec 08, 2014 at 03:01:32PM +0000, Arnd Bergmann wrote:
>>> [ 0.000000] PL310 OF: cache setting yield illegal associativity
>>> [ 0.000000] PL310 OF: -1069781724 calculated, only 8 and 16 legal
>>> [ 0.000000] L2C-310 enabling early BRESP for Cortex-A9
>>> [ 0.000000] L2C-310 full line of zeros enabled for Cortex-A9
>>> [ 0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
>>> [ 0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
>>> [ 0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x4e130001
>>
>> If the above value is correct, they should make sure bit 22 is set in
>> AUX_CTRL.
>
> Hante applied the patch and it now says:
>
> [ 0.000000] PL310 OF: cache setting yield illegal associativity
> [ 0.000000] PL310 OF: -1069781724 calculated, only 8 and 16 legal
> [ 0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [ 0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> [ 0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [ 0.000000] L2C-310 cache controller enabled, 16 ways, 256 kB
> [ 0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x4e530001
>
> He started running a test overnight. So will see if it hits the failure
> with this L2 cache configuration.

The issue did not trigger overnight so it seems setting bit 22 <Shared 
Attribute _Override_ Enable> solves the issue over here. Now the 
question is how to move forward with this. As I understood from Catalin 
this patch was not included as it was not considered responsibility of 
the linux kernel.

Regards,
Arend
