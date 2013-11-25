From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Nov 2013 14:56:23 -0700
Subject: [PATCH 16/31] ASoC: tegra: use reset framework
In-Reply-To: <20131118183716.GR2674@sirena.org.uk>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-17-git-send-email-swarren@wwwdotorg.org>
 <20131116095529.GF15393@sirena.org.uk> <528A4C8C.3030200@wwwdotorg.org>
 <20131118183716.GR2674@sirena.org.uk>
Message-ID: <5293C787.1030005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 11:37 AM, Mark Brown wrote:
> On Mon, Nov 18, 2013 at 10:21:16AM -0700, Stephen Warren wrote:
> 
>> It's fixing a dependency that should already be there, in the 
>> COMPILE_TEST case. In the (ARCH_TEGRA && TEGRA20_APB_DMA) case, 
>> COMMON_CLOCK is always selected.
> 
>> Do you want me to split this out into a separate patch? If so,
>> I'd prefer not to apply that separate patch immediately to 3.13
>> as a fix, since then it'd delay applying this series until after
>> -rc2 is out, unless you can get the fix into -rc1 quickly...
> 
> I don't really care, it was just that I was looking for something
> to do with clocks in the patch and couldn't find anything.  Perhaps
> a note in the changelog if you need to respin so I don't forget and
> say the same thing again.

I added the following to the changelog:

----------
Note: The addition of "depends COMMON_CLOCK" is something that was
missing before, not a new requirement.
----------

You didn't ack this one patch; I assume that was just an oversight?
