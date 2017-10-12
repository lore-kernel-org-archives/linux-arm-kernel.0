From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 12 Oct 2017 12:10:01 +0300
Subject: [PATCH 5/7] ARM: dts: Add nodes for missing omap4 interconnect
 target modules
In-Reply-To: <20171012084030.lshobr3ewu3t5goc@squirrel.local>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-6-tony@atomide.com>
 <f5c57f0b-1423-c362-0fda-4069b77a2e38@ti.com>
 <20171011165850.jnaievrgcszcawh3@earth>
 <da8d1d7f-f16d-8d71-cf49-acff79614610@ti.com>
 <20171012084030.lshobr3ewu3t5goc@squirrel.local>
Message-ID: <78eff2f9-1fe5-66f8-e754-344cb1ea0d97@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-10-12 11:40, Matthijs van Duin wrote:
> On Thu, Oct 12, 2017 at 09:07:55AM +0300, Peter Ujfalusi wrote:
>> I don't see much benefit of using McASP on OMAP4, only drawbacks... It
>> lacks AFIFO so it is prone to underrun and if it underruns you need to
>> reset McASP. Been there with the Samsung Galaxy Nexus.
> 
> AESS/ATC isn't able to consistently respond to a DMA request within 20
> us ?  Strange.. I would have expected it to have no trouble with that.
> (And presumably so did TI, or they would have included AFIFO?)
> 
>> I wonder how Motorola is using the McASP as the OMAP4 version
>> (officially) does not support I2S.
> 
> Hmm? I checked the omap4430 TRM and I don't see that mentioned. It seems
> to have pins for i2s transmit:
> 
> 	abe_mcasp_axr              O     Audio transmit data
> 	abe_mcasp_aclkx            O     Transmit bit clock
> 	abe_mcasp_ahclkx           O     Transmit high-frequency master clock
> 	abe_mcasp_afsx             O     Transmit frame synchronization
> 	abe_mcasp_amute            O     Mute out to external
> 	abe_mcasp_amutein          I     Mute in from external
> 
> If it supported s/pdif tx only, then all of these except axr would be
> useless.

The McASP transmit section uses the S/PDIF industry format, which is
supported by the DIT transfer mode of the module.

And look for Transfer Modes chapter of McSSP in the OMAP4 TRM.

It is DIT only.

> 
> Matthijs
> 

- P?ter
