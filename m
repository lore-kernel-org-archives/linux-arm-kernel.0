From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 May 2012 14:54:11 -0600
Subject: [GIT PULL] ARM: tegra: dt2 branch
In-Reply-To: <201205142037.08752.arnd@arndb.de>
References: <1337016017-30537-1-git-send-email-swarren@wwwdotorg.org>
 <201205141854.34331.arnd@arndb.de> <4FB1572D.90500@wwwdotorg.org>
 <201205142037.08752.arnd@arndb.de>
Message-ID: <4FB170F3.8080107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2012 02:37 PM, Arnd Bergmann wrote:
> On Monday 14 May 2012, Stephen Warren wrote:
>> On 05/14/2012 12:54 PM, Arnd Bergmann wrote:
> 
>>>
>>> I can't see anything wrong with your commits but please check again that it all makes
>>> sense and let me know if I should really pull this version.
>>
>> I think that looks OK. I probably just generated the diffstat backwards.
> 
> Ok, thanks for the confirmation.
> 
> I've pulled it into next/dt2 now. In order to merge this with the drivers/mmc branch
> that contains the common mmc binding, I used the complex resolution below, adding
> bus-width properties to both the dtsi and the dts files.

Yeah, sorry about those conflicts. Thanks for fixing them up.

The changes to tegra-*.dts look fine.

I wonder if the changes to tegra-*.dtsi shouldn't just be dropped? I'd
personally err on the side of requiring board files to add this
property, rather than having things accidentally work because the .dtsi
file included a default.

BTW, I assume that in 3.6, I should plan to remove the support-8bit
properties and associated Tegra SDHCI driver code that handles them, and
rely on the SDHCI core handling this from now on?
