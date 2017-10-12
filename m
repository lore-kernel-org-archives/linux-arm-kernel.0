From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 12 Oct 2017 09:07:55 +0300
Subject: [PATCH 5/7] ARM: dts: Add nodes for missing omap4 interconnect
 target modules
In-Reply-To: <20171011165850.jnaievrgcszcawh3@earth>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-6-tony@atomide.com>
 <f5c57f0b-1423-c362-0fda-4069b77a2e38@ti.com>
 <20171011165850.jnaievrgcszcawh3@earth>
Message-ID: <da8d1d7f-f16d-8d71-cf49-acff79614610@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Hi Sebastian,


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 2017-10-11 19:58, Sebastian Reichel wrote:
>> I'll look at the schema of PandaBoard to see if I can route out the McASP
>> lines to somewhere then I can add support for this revision to davinci-mcasp
>> driver.
> 
> Not sure if this is helpful information:
> 
> Motorola Droid 4 is OMAP4430 based and has McASP lines routed
> to the audio codec (either McASP or McBSP can be used). Codec
> is a custom one, which is not yet supported mainline, but
> patches are WIP (*):
> 
> https://lkml.org/lkml/2017/7/12/368

Really cool!
I don't see much benefit of using McASP on OMAP4, only drawbacks... It
lacks AFIFO so it is prone to underrun and if it underruns you need to
reset McASP. Been there with the Samsung Galaxy Nexus.

I wonder how Motorola is using the McASP as the OMAP4 version
(officially) does not support I2S. It might work, I have not tried it.

I do have one Galaxy Nexus, but there the McASP is used for the S/PIDIF
on the dock (the three pins on the side). Yes, I do not have the dock
and my Galaxy Nexus is still in active use -> not rooted, and never run
mainline Linux.

> (*) My patches use McBSP instead of McASP, since McASP looked
> mostly unsupported. Motorola's kernel uses McASP.

If I have something I might ask you for testing, if it is OK.

> 
> -- Sebastian
> 

- P?ter
