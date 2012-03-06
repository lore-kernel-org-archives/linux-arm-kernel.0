From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Mar 2012 10:01:11 -0700
Subject: [PATCH V2 3/3] gpio: tegra: Hide tegra_gpio_enable/disable()
In-Reply-To: <CACRpkdaZ8EBBwGis4Odh1EZS=waB0nCSZ-mtUHx48ywE81T5Ng@mail.gmail.com>
References: <1330993336-9538-1-git-send-email-swarren@nvidia.com>	<1330993336-9538-3-git-send-email-swarren@nvidia.com>
 <CACRpkdaZ8EBBwGis4Odh1EZS=waB0nCSZ-mtUHx48ywE81T5Ng@mail.gmail.com>
Message-ID: <4F5642D7.4090800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 03:08 AM, Linus Walleij wrote:
> On Tue, Mar 6, 2012 at 1:22 AM, Stephen Warren <swarren@nvidia.com> wrote:
> 
>> Recent pinctrl discussions concluded that gpiolib APIs should in fact do
>> whatever is required to mux a GPIO onto pins, by calling pinctrl APIs if
>> required. This change implements this for the Tegra GPIO driver, and removes
>> calls to the Tegra-specific APIs from drivers and board files.
...
>> This patch should probably be taken
>> through the Tegra tree. Once patch 2 is in pinctrl, and considered stable,
>> I can just use that as a dependency for the branch containing this Tegra
>> patch. I assume that this series will go into 3.5 not 3.4, but I'm willing
>> to be surprised:-)
> 
> Should be possible if my pinctrl-tegra-for-next-diet branch is considered
> stable and could be pulled into the Tegra tree for further augmenting
> by this and other patches!
> 
> But I guess you'd need to merge some stable development base
> for the rest of the pinctrl stuff as well, shall I freeze the for-next
> branch with tegra diet stuff merged on top now? I can promise
> to just add new patches on top of that if it helps you.
> 
> Is Olof the one to ask?

For 3.4 yes Olof, but since this is probably going into 3.5, it's me!

At this point, I expect picking up a stable commit from pinctrl's
for-next branch would be the easiest for 3.5. Probably the same is true
for 3.4 too, since "everything" is in pinctrl's for-next now.
