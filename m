From: robh@kernel.org (Rob Herring)
Date: Thu, 12 Nov 2015 17:38:07 -0600
Subject: [PATCH v9 15/17] drm: bridge: analogix/dp: try force hpd after
 plug in lookup failed
In-Reply-To: <5643EAF9.9020508@rock-chips.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446167355-6387-1-git-send-email-ykk@rock-chips.com>
 <20151111231042.GA29893@rob-hp-laptop>
 <5643EAF9.9020508@rock-chips.com>
Message-ID: <20151112233807.GA9899@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 09:27:21AM +0800, Yakir Yang wrote:
> Hi Rob,
> 
> On 11/12/2015 07:10 AM, Rob Herring wrote:
> >On Fri, Oct 30, 2015 at 09:09:15AM +0800, Yakir Yang wrote:
> >>Some edp screen do not have hpd signal, so we can't just return
> >>failed when hpd plug in detect failed.
> >>
> >>This is an hardware property, so we need add a devicetree property
> >>"analogix,need-force-hpd" to indicate this sutiation.
> >>
> >>Tested-by: Heiko Stuebner <heiko@sntech.de>
> >>Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> >>Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> >>---
> >I didn't find this one in v10. Did it get dropped?
> 
> You are in my 'to' list, but I haven't send the whole v10 out,
> most of them don't need update :)

Okay, it's just gmail's inability to follow threading...
 
> This series should be:
> ---- [v8 0/17 ...]
>   |---- [v8 1/17 ...]
>   |---- [v8 2/17 ...]
>   |---- [v8 3/17 ...]
>   |---- [...]
>   |---- [v8 15/17 ...]
>   |---- [v8 16/17 ...]
>   |---- [v8 17/17 ...]
>   |
>   |---- [v9 10/17 ...]
>   |---- [v9 15/17 ...]
>      |---- We are here
>   |---- [v9 09/17 ...]
>   |---- [v10 09/17 ...]
>      |---- Received an acked from you


> >>diff --git a/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt b/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
> >>index 7659a7a..74f0e80 100644
> >>--- a/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
> >>+++ b/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
> >>@@ -22,6 +22,9 @@ Required properties for dp-controller:
> >>  		from general PHY binding: Should be "dp".
> >>  Optional properties for dp-controller:
> >>+	-analogix,need-force-hpd:
> >>+		Indicate driver need force hpd when hpd detect failed, this
> >>+		is used for some eDP screen which don't have hpd signal.
> >This should be a generic property.
> 
> This property would only need in some no-hpd case, it would be dropped if
> panel keep the hotplug signal, that's why I thought it should be optional.

I agree it is optional. I just mean drop the analogix and put in a 
common binding doc (i.e. create a display/bridge/common.txt). Needing to 
ignore HPD is probably a common problem.

> I thought if we put this a property to generic property, then we must need
> to define it in normal device node, not sure whether it is right :)

Sorry, I don't follow.

Rob
