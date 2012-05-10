From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 10 May 2012 09:48:36 -0600
Subject: [alsa-devel] [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl
 support
In-Reply-To: <20120510090459.GH2982@b20223-02.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
 <20120510063904.GB17875@S2101-09.ap.freescale.net>
 <20120510084403.GA3908@opensource.wolfsonmicro.com>
 <20120510090459.GH2982@b20223-02.ap.freescale.net>
Message-ID: <4FABE354.7010605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2012 03:05 AM, Richard Zhao wrote:
> On Thu, May 10, 2012 at 09:44:04AM +0100, Mark Brown wrote:
>> On Thu, May 10, 2012 at 02:39:06PM +0800, Shawn Guo wrote:
>>> On Thu, May 10, 2012 at 08:35:33AM +0800, Richard Zhao wrote:
>>
>>>> It's based on your for-next. But for working, it depends on
>>>> pinctl/for-next.
>>
>>> Mark, may I have your ack to have it go through arm-soc?  I will ask
>>> Arnd pull your sound/for-v3.5 branch into arm-soc as a dependency.
>>> You need to ensure the branch will not be rebased.
>>
>> for-3.5 is the entire undifferentiated blob of ASoC stuff, it's not
>> really suitable for merging elsewhere.  It won't actually get rebased
>> but the idea of merging it into other trees doesn't seem terribly
>> clever, it'd make having topic branches in arm-soc a bit of a joke and
>> if you pull it right now you'll get problems in -next due to the the
>> ux500 stuff.
>>
>> What does "working" mean in this context - what happens without the
>> pinctl changes?
> devm_pinctrl_get_select_default function is added in below commit which
> is in pinctrl/for-next.
> 
> commit 6d4ca1fb467932773da7b808c52f3d7ef4461ba0
> Author: Stephen Warren <swarren@nvidia.com>
> Date:   Mon Apr 16 10:51:00 2012 -0600
> 
>     pinctrl: implement devm_pinctrl_get()/put()
>     
>     These functions allow the driver core to automatically clean up any
>     allocations made by drivers, thus leading to simplified drivers.
>     
>     Signed-off-by: Stephen Warren <swarren@nvidia.com>
>     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> 
> So it'll fail compile without pinctrl/for-next. I guess Linus may need
> to prepare a non-rebase base for others to merge.

(CCing Linus)

There is one already.

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tag pinctrl-mergebase-20120418
The commit is in for-next and devel branches, but not the tip of those.
