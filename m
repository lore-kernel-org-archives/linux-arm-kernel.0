From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 7 Feb 2017 12:59:12 -0800
Subject: [GIT PULL 1/2] Broadcom dts changes for 4.11 (part 2)
In-Reply-To: <1912177.f24aWX6xy5@wuerfel>
References: <20170202020607.31682-1-f.fainelli@gmail.com>
 <1912177.f24aWX6xy5@wuerfel>
Message-ID: <077dc1a1-7069-dd84-5f23-1f88420b05e5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2017 06:49 AM, Arnd Bergmann wrote:
> On Wednesday, February 1, 2017 6:06:07 PM CET Florian Fainelli wrote:
>> Please note that because of the "clk" topic branch merged by Eric, we end-up with
>> pulling in v4.10-rc2 which is responsible for the funny diff here.
> 
> It's generally better to avoid those back-merges entirely, that is not
> the only problem with them. Our DT branch is already based on -rc3,
> so it's not a back-merged for me, and I think that's ok when I send
> it upstream.
> 
> However, I see that you do pull in these changes:
> 
> Eric Anholt (5):
>       clk: bcm2835: Don't rate change PLLs on behalf of DSI PLL dividers.
>       clk: bcm2835: Register the DSI0/DSI1 pixel clocks.
>       clk: bcm2835: Add leaf clock measurement support, disabled by default
> 
> I'd rather not have those in next/dt at all, and at the very least
> we require an explanation in the changelog about why you are sending
> them to arm-soc. I assume that they are present in the clk-next
> tree and won't get rebased, but that's not clear from your pull
> request.

OK, the explanation is provided in the merge commit, but I suppose I
should have added this again to the pull request changelog.

> 
> Are you doing an incompatible DT binding change that requires changing
> the dts files and the driver together? If so, that also needs to be
> in the changelog (or avoided if at all possible).

Eric, do you mind commenting on that part?

> 
> If you send the other changes again today, I'll pull them right away,
> and then we can talk about what we do for the clk-bcm2835 changes.

OK, let me try to sync up with Eric on this and see if we can come up
with something better. A pull request based on v4.10-rc3 would be
acceptable, right?
-- 
Florian
