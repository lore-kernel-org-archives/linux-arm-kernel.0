From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 15 Oct 2015 13:23:22 -0700
Subject: [GIT PULL] Broadcom soc changes for v4.4 (try 2)
In-Reply-To: <5790163.9Q0inxP5UI@wuerfel>
References: <1443824458-20799-4-git-send-email-f.fainelli@gmail.com>
 <1444502429-11100-1-git-send-email-f.fainelli@gmail.com>
 <5790163.9Q0inxP5UI@wuerfel>
Message-ID: <56200B3A.3030104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 13:16, Arnd Bergmann wrote:
> On Saturday 10 October 2015 11:40:29 Florian Fainelli wrote:
>>
>> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
>>
>>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
>>
>> are available in the git repository at:
>>
>>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.4/soc
>>
>> for you to fetch changes up to c4a8ea9e0698945b182ba1e1063a0981b1f35139:
>>
>>   ARM: brcmstb: Setup BIU control registers during boot (2015-10-09 13:42:18 -0700)
>>
>> ----------------------------------------------------------------
>> This pull request contains the following Broadcom SoC platform and driver changes:
>>
>> - Brian Norris create a drivers/soc/brcmstb/ stub as a place holder for SoC-specific
>>   code which is coming next
> 
> I should have been clearer with my complaint last week. I really mean both
> of Brian's patches should be removed, although I mainly talked about the
> other one. This patch goes to great length to introduce a soc_is_brcmstb()
> function, but I'd rather see this never being used anywhere.
> 
> Drivers should not have to check the compatible property of the root node
> (in some cases we do, but that is because the initial binding was broken
> and we could not change it).

I admit I did not quite understand your initial comment was about both
patches, look back at this, the biuctrl code really does not need this
soc_is_brcmstb() thing at all, since it matches its own compatible
strings... whoops.

> 
>> - Florian Fainelli adds support for configuring the BCM7xxx SoCs Bus Interface Unit
>>   with their specific write-pairing setting, which must be saved and restored during
>>   system-wide suspend/resume, and consequently updates the brcmstb machine code to
>>   initialize the BIU
>>
>> - Jon Mason adds support for the Northstar Plus SoCs by introducing a custom machine
>>   descriptor matching their compatible string and setting up the PL310 L2 cache and
>>   enabling the relevant ARM errata for their Cortex-A9
> 
> I've merged all of the series anyway, since it's not a big enough
> problem to make you do another iteration, and I've already pushed
> back once.
> 
> Let's talk about this again when you add users of this function, so
> we can ideally come up with a better solution and remove the two files
> again.
> 
> Pulled into next/soc. Thanks for your patience and for respinning
> the series so quickly!

Sounds good, thanks!
-- 
Florian
