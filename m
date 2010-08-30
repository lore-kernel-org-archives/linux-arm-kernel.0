From: michael.williamson@criticallink.com (Michael Williamson)
Date: Mon, 30 Aug 2010 09:29:22 -0400
Subject: [PATCH] davinci: Initial support for MityDSP-L138/MityARM-1808
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F6615555@dbde02.ent.ti.com>
References: <4C78FA26.4040801@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6615555@dbde02.ent.ti.com>
Message-ID: <4C7BB232.80502@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi Sekhar,

On 8/30/2010 7:58 AM, Nori, Sekhar wrote:
> Hi Michael,
>
> On Sat, Aug 28, 2010 at 17:29:34, Michael Williamson wrote:
>> This patch adds initial support for the MityDSP-L138 and MityDSP-1808 system
>> on Module (SOM) under the machine name "mityomapl138".  These SOMs are based
>> on the da850 davinci CPU architecture.  Information on these SOMs may be
>> found at http://www.mitydsp.com.
>>
>> Basic support for the console UART, NAND, and EMAC (MII interface) is
>> included in this patch.
>>
>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
>> ---
>> Notes:
>>   1) Patch is against 0a50e05b20f3c6af67656303bdb3661a2541ce03 of Kevin's
>>      tree (2.6.36-rc2).
>>   2) I did not include a defconfig update in this patch.  Until the regulator
>>      support is added back in (planned subsequent patch), it cannot be added
>>      to da8xx_omapl_defconfig as the CONFIG_REGULATOR option doesn't play
>>      nice with platforms not defining a regulator.  If a defconfig support
> What is the issue you are facing? I have seen in the past that enabling
> CONFIG_REGULATOR_DUMMY helped overcome an aic3x codec initialization issue
> when the aic3x probe expects a few regulators to be present in the system
> if CONFIG_REGULATOR is on.
>
Enabling CONFIG_REGULATOR_DUMMY will remove the error message for this SOM. 
This brings up a couple of questions I've wanted to ask:  Are there ground
rules are for adding options to defconfig files that cover more than one
architecture/board?  Is a defconfig required for new boards?

Is it OK that I add CONFIG_REGULATOR_DUMMY to the da8xx_omapl_defconfig file? 
Or should there be a critical warning as currently defined if there
is no regulator found for the other da8xx platforms? 

Can I add the other options to support booting from NAND in this as well?
If the answer is "sure", then I can update the da8xx_omapl_defconfig and submit
that as a separate patch or resubmit this one.

Thank you for any insight.

-Mike
  
