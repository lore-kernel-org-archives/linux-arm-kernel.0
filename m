From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 May 2012 10:15:43 -0600
Subject: [GIT PULL] ARM: tegra: dt2 branch
In-Reply-To: <201205151143.26008.arnd@arndb.de>
References: <1337016017-30537-1-git-send-email-swarren@wwwdotorg.org>
 <201205142037.08752.arnd@arndb.de> <4FB170F3.8080107@wwwdotorg.org>
 <201205151143.26008.arnd@arndb.de>
Message-ID: <4FB2812F.1010500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2012 05:43 AM, Arnd Bergmann wrote:
> On Monday 14 May 2012, Stephen Warren wrote:
>> I wonder if the changes to tegra-*.dtsi shouldn't just be dropped? I'd
>> personally err on the side of requiring board files to add this
>> property, rather than having things accidentally work because the .dtsi
>> file included a default.
> 
> I ended up redoing the merge because I found an embarrasing typo in my patch
> and now dropped the property for the dtsi files.
> 
>> BTW, I assume that in 3.6, I should plan to remove the support-8bit
>> properties and associated Tegra SDHCI driver code that handles them, and
>> rely on the SDHCI core handling this from now on?
> 
> I think we can't drop it from the driver because of existing powerpc machines
> providing the property, but it would be ok if you drop it from your .dts
> files.

support-8bit is parsed by the Tegra driver only, and only appears in
tegra-*.dts across all arch/*/boot.dts. I assume you were talking about
some other property, although I can't tell which from a very quick look
at arch/powerpc/boot/dts/*.
