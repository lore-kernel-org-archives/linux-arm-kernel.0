From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 12:27:33 -0600
Subject: [PATCH v9 00/14] Tegra114 clockframework
In-Reply-To: <515C6C6E.6060302@wwwdotorg.org>
References: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
 <515C6C6E.6060302@wwwdotorg.org>
Message-ID: <515C7495.8060106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 11:52 AM, Stephen Warren wrote:
> On 04/03/2013 08:40 AM, Peter De Schrijver wrote:
>> This is the nineth version of the Tegra114 clockframework. It is based on the
>> next-20130320-fixed branch of
>> git://nv-tegra.nvidia.com/user/swarren/linux-2.6.git,
... [it depends on]
>> http://patchwork.ozlabs.org/patch/233415/
> 
> That is Joseph's "clocksource: tegra: enable arch_timer". Is this
> actually a dependency, or an optimization, or ...?
> 
> Rob Herring objected to that patch since it isn't necessary if his
> series "ARM arch, sp804 and integrator timer CLKSRC_OF support" is applied.
> 
> If I apply just your (Peter's) CCF series without Joseph's or Rob's
> patches, will everything still work, or is this a hard dependency to
> create a working system?

I manage to get this series applied on top of my local dev branch, based
on next-20130328 (it was painful). Testing indicates that there is no
dependency on Joseph's patch mentioned above; I could boot, log in, and
play audio (with local patches) with /or/ without Joseph's patch applied.

However, I still find that I need to revert f7db706 ARM: "7674/1: smp:
Avoid dummy clockevent being preferred over real hardware clock-event",
or I get a hard system hang right after the root fs is mounted. As such,
I not sure if it's worthwhile applying this series since it's unlikely
to actually work once merged into Torvalds' tree.

Do you have any idea what the problem is here?

I'll try rebasing my local test branch on top of the latest linux-next
just in case some other fix solved this already, but I'm not going to
hold my breath.
