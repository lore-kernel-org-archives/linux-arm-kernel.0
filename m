From: peter.ujfalusi@ti.com (=?ISO-8859-1?Q?P=E9ter_Ujfalusi?=)
Date: Mon, 08 Oct 2012 11:00:30 +0300
Subject: [PATCH 0/9] ARM: dts/OMAP: Pinmux audio configuration for OMAP4+
In-Reply-To: <20121005230354.GS3874@atomide.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
 <20121005230354.GS3874@atomide.com>
Message-ID: <5072881E.2040009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2012 02:03 AM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [121004 04:57]:
>> Hello,
>>
>> u-boot recently stopped configuring 'non essential' pin mux. This change leaves
>> the audio essential pins in non configured state which prevents the use of audio.
>> The following series makes sure that the needed pins are configured correctly by
>> the kernel on OMAP4 and OMAP5.
>>
>> Tony: can this series queued for 3.7?
> 
> Let's see if that's possible to avoid mysterious bug reports
> of things not working.
> 
> If we can't merge it, then it might be worth adding a warning
> that bails out early after some pin is checked or similar.

With new enough u-boot the twl6040 fails to probe (mux for nirq2 and power
GPIO is not configured) which leads to no audio on OMAP4/5.
Adding another warning - and check - does not going to help to clarify the
situation IMHO.
We can still enable the CONFIG_SYS_ENABLE_PADS_ALL in u-boot and recompile it,
but this is disabled as default and to be frank there is no guaranty that this
is going to be available let's say next week.

-- 
P?ter
