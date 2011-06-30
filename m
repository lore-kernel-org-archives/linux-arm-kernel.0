From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 30 Jun 2011 18:25:51 +0300
Subject: kernel panic in spi_complete() on spitz (PXA270)
In-Reply-To: <1309445118.4406.47.camel@oct.suse.cz>
References: <1308845380.4533.54.camel@oct.suse.cz>	
	<201106301352.21684.marek.vasut@gmail.com>
	<1309445118.4406.47.camel@oct.suse.cz>
Message-ID: <4E0C957F.8080807@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/11 17:45, Stanislav Brabec wrote:

> Marek Vasut wrote:
>> On Thursday, June 23, 2011 06:09:40 PM Stanislav Brabec wrote:
>>> Hallo.
>>>
>>> These Oops and kernel panic were observed on a Zaurus (spitz) machine
>>> (ARMv5, PXA270).
>> Looks similar to "Re: [PATCH v2] Input: Make ADS7846 independent on regulator"
> I don't see any trace in that thread. But yes, I was testing your patch
> from this thread. Without it, ADS7846 does not work on spitz (ADS7846
> does not have any dedicated regulator there). I want to
> add .needs_regulator bool to ads7846.c and send the patch again to the
> list.

Please, don't...
I thought we've finished discussing the regulator issue...

Instead of patching the driver and the platform data and the board file,
you should do _either_ of the following:
1) add regulator definition for ads7846 into the board file
2) enable the CONFIG_REGULATOR_DUMMY in your kernel configuration
3) use regulator_use_dummy_regulator() call in the board file.

Using either of the above, you will not need the patch for ads7846, only for the board file.


-- 
Regards,
Igor.
