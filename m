From: elder@linaro.org (Alex Elder)
Date: Thu, 03 Apr 2014 16:02:06 -0500
Subject: [PATCH] mach-bcm: clean up config and build targets
In-Reply-To: <1396558159.21212.4.camel@x220>
References: <1396557052-24029-1-git-send-email-elder@linaro.org>
 <1396558159.21212.4.camel@x220>
Message-ID: <533DCC4E.4000303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2014 03:49 PM, Paul Bolle wrote:
> On Thu, 2014-04-03 at 15:30 -0500, Alex Elder wrote:
>> Currently CONFIG_ARCH_BCM_MOBILE is used to select all Broadcom
>> mobile SoCs.  Instead, use that only as a config menu switch, and
>> define specific symbols like CONFIG_ARCH_BCM_281XX to select a
>> particular SoC family.  If ARCH_BCM_MOBILE is selected, all of the
>> SoCs will be selected by default, but this way each can be disabled
>> individually as well.
>>
>> This allows more precision in controlling what gets built under
>> mach-bcm.  Another benefit to doing this is that it makes it obvious
>> that the code that implements SMC calls to control L2 cache is only
>> used for BCM281XX (for example).
>>
>> Also use Kbuild's $(<modulename>-y) variable mechanism to build a
>> single object file containing everything used for the bcm281xx board
>> in arch/arm/mach-bcm.
>>
>> Note:  This patch is based on the current arm-soc/for-next branch:
>>     e98cd72 arm-soc: document samsung merges
>>
>> The patch is available here:
>>     http://git.linaro.org/landing-teams/working/broadcom/kernel.git
>>     Branch review/mach-bcm-cleanup
> 
> It seems the last two paragraphs should actually be below the "---"
> marker. There's no need to include them in the commit explanation, is
> there?

You're right.  Sorry about that.

I got another comment too and will be doing a v2 shortly.

					-Alex
> 
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
> 
> 
> Paul Bolle
> 
