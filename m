From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 02 Nov 2015 18:01:24 +0000
Subject: [PATCH v8 2/2] arm-soc: Add support for arm-based tango4 platforms
In-Reply-To: <56379E62.4080704@sigmadesigns.com> (Marc Gonzalez's message of
 "Mon, 2 Nov 2015 18:33:22 +0100")
References: <56377E76.2080209@sigmadesigns.com>
 <56377F09.6050805@sigmadesigns.com>
 <yw1xfv0o9xr3.fsf@unicorn.mansr.com>
 <56379E62.4080704@sigmadesigns.com>
Message-ID: <yw1x7fm09t6z.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> On 02/11/2015 17:22, M?ns Rullg?rd wrote:
>
>> Unless I'm missing something, you should enable the SCU before starting
>> secondary CPUs.  It's also a good idea to structure the code with
>> separate prepare and boot functions even if all the current chips are
>> only dual-core.
>
> About the SCU: I will check with the firmware author.
> About prepare: this is the firmware's responsibility.
> (Not all chips are dual-core, the 8756 is single-core.)

Then the DT should say so.

Rule 0: never trust the firmware.

>> What about other registers?  Does the firmware support setting the
>> prefetch control register?
>
> Yes, after masking out some bits.

Then you should provide the kernel with a means of doing that.  Is the
SMC ID from OMAP4 correct?

-- 
M?ns Rullg?rd
mans at mansr.com
