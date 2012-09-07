From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 7 Sep 2012 13:39:23 +0100
Subject: [PATCH 04/19] ARM: ux500: Add SDI (MMC) support to the HREF
 Device Tree
In-Reply-To: <201209071229.32027.arnd@arndb.de>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-5-git-send-email-lee.jones@linaro.org>
 <201209071229.32027.arnd@arndb.de>
Message-ID: <20120907123922.GC29601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 12:29:31PM +0000, Arnd Bergmann wrote:
> On Friday 07 September 2012, Lee Jones wrote:
> > +               // External Micro SD slot
> > +               sdi at 80126000 {
> > +                       arm,primecell-periphid = <0x10480180>;
> > +                       max-frequency = <50000000>;
> > +                       bus-width = <8>;
> > +                       mmc-cap-sd-highspeed;
> > +                       mmc-cap-mmc-highspeed;
> > +                       vmmc-supply = <&ab8500_ldo_aux3_reg>;
> > +
> > +                       #gpio-cells = <1>;
> > +                       cd-gpios  = <&gpio2 31 0x4>; // 95
> > +
> > +                       status = "okay";
> > +               };
> > +
> 
> The #gpio-cells property seems misplaced here.

Are you reading my patches in reverse order? ;)

If not, good spot. :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
