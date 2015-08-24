From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 24 Aug 2015 18:16:39 +0200
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <CAL_JsqKZYMMzV9Sc2r3K_rnM0FNuyb1TyJEhjGq1Hf7dTiWFKQ@mail.gmail.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <20150824125758.GA7557@n2100.arm.linux.org.uk>
 <CAL_JsqKZYMMzV9Sc2r3K_rnM0FNuyb1TyJEhjGq1Hf7dTiWFKQ@mail.gmail.com>
Message-ID: <1749941.uaVRIcm7Pc@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 24. August 2015, 09:48:27 schrieb Rob Herring:
> On Mon, Aug 24, 2015 at 7:57 AM, Russell King - ARM Linux
> > When we adopted the graph bindings for iMX DRM, I thought exactly at that
> > time "it would be nice if this could become the standard for binding DRM
> > components together" but I don't have the authority from either the DT
> > perspective or the DRM perspective to mandate that.  Neither does anyone
> > else.  That's the _real_ problem here.
> > 
> > I've seen several DRM bindings go by which don't use the of-graph stuff,
> > which means that they'll never be compatible with generic components
> > which do use the of-graph stuff.
> 
> It goes beyond bindings IMO. The use of the component framework or not
> has been at the whim of driver writers as well. It is either used or
> private APIs are created. I'm using components and my need for it
> boils down to passing the struct drm_device pointer to the encoder.
> Other components like panels and bridges have different ways to attach
> to the DRM driver.

but that is then simply implementation specific. Panels and bridges can very 
well be part of and created from an of_graph description without needing to be 
a (linux-)component - see patch 7.
