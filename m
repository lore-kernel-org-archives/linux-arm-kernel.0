From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 Feb 2012 22:02:41 +0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <CAA+hA=RpkP-FFAr8wqVPjSKEMvO_sRHmOK_9nUYfuW=ps0O_=Q@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <20120201143530.GA2203@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF178E124AC5@HQMAIL01.nvidia.com>
 <CAA+hA=RpkP-FFAr8wqVPjSKEMvO_sRHmOK_9nUYfuW=ps0O_=Q@mail.gmail.com>
Message-ID: <20120203140238.GC12915@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 04:07:23AM +0800, Dong Aisheng wrote:
...
> However If IMX uses the data model i described above, the binding is
> then a little different from tegra. that means we may need to change
> to  let each soc's pinctrl driver do real pinmux map parsing (maybe
> add a callback in pinctrl.ops) based on their soc specific pinctrl
> configuration node like pmx_usdhc4 above instread of let pinctrl core
> do a standard pinmux map parsing which is our target we discussed so
> long for.
> 
Yeah, this seems a reasonable alternative to me.  Pushing the pinmux_map
construction down to individual pinctrl driver, who can interpret 'mux'
property best, will relieve the pinctrl core from understanding the
property for different cases, so that we can even save the property
'mux-unit' I asked for.  And doing so somehow aligns with non-dt case,
where the pinmux_map is constructed by individual pinctrl driver too
(with help from PINMUX_MAP_* macros in board file).

-- 
Regards,
Shawn
