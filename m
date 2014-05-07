From: nm@ti.com (Nishanth Menon)
Date: Wed, 7 May 2014 10:29:35 -0500
Subject: [PATCH V6 0/2] arm: dts: dra7: Updates for adding crossbar device
In-Reply-To: <20140507145656.GG2626@ti.com>
References: <1399464998-23216-1-git-send-email-r.sricharan@ti.com>
 <20140507145656.GG2626@ti.com>
Message-ID: <536A515F.3010402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On 05/07/2014 09:56 AM, Darren Etheridge wrote:
> Sricharan R <r.sricharan@ti.com> wrote on Wed [2014-May-07 17:46:36 +0530]:
>> Some socs have a large number of interrupts requests to service
>> the needs of its many peripherals and subsystems. All of the interrupt
>> requests lines from the subsystems are not needed at the same
>> time, so they have to be muxed to the controllers appropriately.
>> In such places a interrupt controllers are preceded by an
>> IRQ CROSSBAR that provides flexibility in muxing the device interrupt
>> requests to the controller inputs.
>>
>> The dts file update to support the crossbar device and convert
>> peripheral irq numbers to crossbar number are added here.
>>
>> This is a rebase on top of 3.15-rc4
>>
>> This series depends on crossbar-driver-fixes sent below
>> http://marc.info/?l=linux-omap&m=139929963420299&w=2
>>
>> [V6] Reordered patch 3 to patch 1 and
>>      squashed patch 2 and 3 from V5 in to patch 2
>>
>> Sricharan R (2):
>>   arm: dts: dra7: Add routable-irqs property for gic node
>>   arm: dts: dra7: Add crossbar device binding
>>
> 
> Just for thoroughness I dropped the previous 3 patch series from my
> build and replaced with this two patch series.  Everything still works
> with my test setup so I consider these patches good.
> 

It looks like in further tests, there may be more interrupts like irq
10 which are not documented properly and if mapped results in the
feature not working. It does seem that we might need more detailed
validation as this seems to have skipped our "non-OS validation" flow
unfortunately. we are in discussion with silicon folks on these
"undocumented behavior" we are discovering :(.

I suggest holding the series till we have done complete validation of
the same and explanation for the behavior we see.

-- 
Regards,
Nishanth Menon
