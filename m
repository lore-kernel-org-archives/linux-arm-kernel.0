From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 7 Oct 2015 14:14:46 +0200
Subject: [PATCH v4] twd: Don't set CLOCK_EVT_FEAT_C3STOP unconditionally
In-Reply-To: <5612A730.5030400@sigmadesigns.com>
References: <56123BD0.8010005@sigmadesigns.com>
 <56124035.6080107@sigmadesigns.com>
 <CACRpkdbWRU3UH6aJnqdcuzdh_-sE7ryhs0vBTUbbRDcJ7PWXLw@mail.gmail.com>
 <561247DF.1000308@sigmadesigns.com> <20151005103539.GC19064@leverpostej>
 <5612649C.5020401@sigmadesigns.com> <5612A730.5030400@sigmadesigns.com>
Message-ID: <56150CB6.2040701@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2015 18:37, Marc Gonzalez wrote:
> On 05/10/2015 13:53, Marc Gonzalez wrote:
>> In 5388a6b266 ("ARM: SMP: Always enable clock event broadcast support")
>> Russell noted that "the TWD local timers are unable to wake up the CPU
>> when it is placed into a low power mode".
>>
>> However, some platforms do not stop the TWD block in low-power mode,
>> and can thus use the TWD timer in one-shot mode, without setting up
>> a broadcast device.
>>
>> Make the driver check for the "twd-never-stops" boolean property,
>> and set the CLOCK_EVT_FEAT_C3STOP flag accordingly.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>>  Documentation/devicetree/bindings/arm/twd.txt | 4 ++++
>>  arch/arm/kernel/smp_twd.c                     | 5 ++++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> Sorry, I don't fully understand the submission process.
> 
> Should I now submit my patch to the patch queue?
> http://www.arm.linux.org.uk/developer/patches/

Submitted as patch 8441/1
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8441/1
