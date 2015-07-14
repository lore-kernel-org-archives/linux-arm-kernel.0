From: fainelli@broadcom.com (Florian Fainelli)
Date: Tue, 14 Jul 2015 14:29:31 -0700
Subject: [PATCH] ARM: BCM: Restrict Broadcom BCM470X / BCM5301X to non-LPAE
In-Reply-To: <4793510.M34v5PmKgi@wuerfel>
References: <1436897535-3782-1-git-send-email-f.fainelli@gmail.com>
 <4793510.M34v5PmKgi@wuerfel>
Message-ID: <55A57F3B.1080909@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/07/15 13:43, Arnd Bergmann wrote:
> On Tuesday 14 July 2015 11:12:15 Florian Fainelli wrote:
>> Cortex-A9 on at least BCM4708 SoCs are not LPAE capable, booting such a
>> kernel will result in the following:
>>
>> Error: Kernel with LPAE support, but CPU does not support LPAE.
>>
>> Restrict such SoCs to be built in a configuration that does not enable
>> ARM_LPAE.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>
> 
> This is an old problem for all platforms, I think we want a more
> generic solution though, instead of adding the !LPAE dependency
> for each Cortex-A5/8/9 platform.

Fair enough, what do you have in mind? Should we introduce something
like CONFIG_V7_A9 and such, and update all platforms to select such
symbols such that we can then apply a restriction on other symbols if
there needs to be?

What if any of these CPUs end-up supporting LPAE, but this cannot be
flagged at build time?
-- 
Florian
