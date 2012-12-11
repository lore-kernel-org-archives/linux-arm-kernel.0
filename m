From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Dec 2012 13:36:11 -0700
Subject: [PATCH V3] ARM: bcm281xx: Add timer driver
In-Reply-To: <50C785DD.8030407@broadcom.com>
References: <1355250387-622-1-git-send-email-csd@broadcom.com>
 <50C78330.7040605@wwwdotorg.org> <50C785DD.8030407@broadcom.com>
Message-ID: <50C7993B.4070201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2012 12:13 PM, Christian Daudt wrote:
> On 12-12-11 11:02 AM, Stephen Warren wrote:
>> On 12/11/2012 11:26 AM, Christian Daudt wrote:
>>> This adds support for the Broadcom timer, used in the following SoCs:
>>> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155

>> For 3.9, you'll need to rebase it on top of my struct sys_timer removal
>> series, which I hope to put into linux-next ASAP after 3.8-rc1 comes out.
>
> Is there a git repo where I can look into this right now ? If so I can
> already look at what diffs will be required for this.

Sure, it's at:

git://nv-tegra.nvidia.com/user/swarren/linux-2.6 arm_timer_rework

Note that branch gets rebased, as I move it forward on to newer linux
next periodically. Once 3.8-rc1 comes out and I have a final stable
version, I'll arrange to get it into arm-soc, so it can be used as a
base for other people's patches.

Olof, Arnd, that brings me to the question of:

Should I:

a) Add that branch into linux-next (e.g. via the Tegra tree's for-next)
right after v3.8-rc1, let is sit there for a week or two (to allow
rebasing to squash in any fixes that show up as being needed), and then
send a pull request to arm-soc as a stable branch,

or:

b) Send a pull request to arm-soc right after 3.8-rc1, and let you do
any rebasing/squashing needed, before declaring it stable say around
3.8-rc2 or 3.8-rc3?
