From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 10 Sep 2018 14:59:23 +0300
Subject: omap4: support for manually updated display
In-Reply-To: <20180830090456.GA17277@amd>
References: <20180830090456.GA17277@amd>
Message-ID: <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

(dropping Dave, no need to spam him)

On 30/08/18 12:04, Pavel Machek wrote:
> Hi!
> 
> There's neat series of patches on
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-v4.19
> 
> They enable display support for my hardware. As you can imagine,
> display is rather important for a cellphone.
> 
> Tomi, can you take the patches? I can resubmit them in email, or
> shuffle them to another branch without mfd changes, or clean them up
> etc...

A large omapdrm change set from Laurent was merged into drm-next, and
I'm certain they conflict with this series. Laurent also has continued
that work, and while those new patches haven't been sent for review yet,
I fear they'll also conflict with these.

So in the minimum, a rebase on top of drm-next is needed.

I also continue to be very worried that adding DSI support to omapdrm at
this stage will be a huge extra burden for Laurent's work.

We should transform the panel-dsi-cm.c towards the common DRM model.
With a quick look, there seems to be a driver for Samsung's S6E63J0X03
panel. So possibly all the DSI features are there in the DRM framework,
but someone needs to check that and start working on panel-dsi-cm.c so
that it's ready when we finally switch to the DRM model.

In my opinion, which I've also expressed before, the above work is much
easier to do by first changing the omapdrm to DRM model, without any DSI
displays, and then add the DSI command mode support. But if people
insist on adding the DSI support already now, I would appreciate the
same people working on the DSI support so that Laurent doesn't have to
do it all.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
