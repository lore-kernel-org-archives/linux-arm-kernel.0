From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Fri, 2 Mar 2018 10:07:08 +0200
Subject: [PATCH] drm/bridge: sii902x: Fall back to standard modes
In-Reply-To: <CACRpkdbMfzWSH1bAtjhW_ykJGPnycVFtbUp816KShX5wCDu+0Q@mail.gmail.com>
References: <20180214130059.19052-1-linus.walleij@linaro.org>
 <CACRpkdYuZE+ohhLf6mmPHEsGmNw6r7UOBCyQEFOcYOYxdVj2oA@mail.gmail.com>
 <20180301211840.GD5453@intel.com>
 <CACRpkdbMfzWSH1bAtjhW_ykJGPnycVFtbUp816KShX5wCDu+0Q@mail.gmail.com>
Message-ID: <20180302080708.GF5453@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 11:12:15PM +0100, Linus Walleij wrote:
> On Thu, Mar 1, 2018 at 10:18 PM, Ville Syrj?l?
> <ville.syrjala@linux.intel.com> wrote:
> > On Thu, Mar 01, 2018 at 10:02:55PM +0100, Linus Walleij wrote:
> >> Hm, hard to get review feedback on this one.
> >>
> >> It gives me proper video on an ARM Versatile Express utilizing the
> >> bridge driver with a plugged in DVI-to-VGA dongle with the new
> >> PL111 DRI driver.
> >>
> >> Liviu? Pawel?
> >>
> >> Some ACK is fine to know I am doing the right thing :)
> >
> > Why isn't the probe helper's noedid fallback working?
> 
> Where is that in the call chain?
> 
> The problem I have is that the bridge is there, it gets properly
> initialized and used as connector and all. The only problem is
> that the DDI I2C portion of it is not working, so no modes are
> really added from the struct drm_connector_helper_funcs
> .get_modes() callback.

The helper is what calls .get_modes(), and it has a noedid
fallback for mode count==0.

-- 
Ville Syrj?l?
Intel OTC
