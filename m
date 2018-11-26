From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon, 26 Nov 2018 10:32:12 -0800
Subject: [PATCH 2/3] PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
In-Reply-To: <1542676938.30311.581.camel@impinj.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-3-andrew.smirnov@gmail.com>
 <1542676938.30311.581.camel@impinj.com>
Message-ID: <CAHQ1cqG0oVWQw9NC_22f7bZMfX11wwuvO2_x8P3GJYsb-ecGvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 5:22 PM Trent Piepho <tpiepho@impinj.com> wrote:
>
> On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:
> > PCIE PHY IP block on i.MX7D differs from the one used on i.MX6 family,
> > so none of the code in current implementation of imx6_pcie_reset_phy()
> > is applicable.
>
> Tested on IMX7d, still appears to work.
>

Thanks for testing! Unless you object, I'll add your Tested-by tag to
this patch.

> Note that your patches will collide with Stefan Agner's patch, "PCI:
> imx6: limit DBI register length", which was recently posted.
>
> He changed the way the variants are handled.  That method would allow
> some of the IMX7D || IMX8MQ checks to be re-written as
>
>  imx6_pcie->drvdata->boolean_attribute
>
> Where the attribute can be set in a table and be re-used in every place
> it comes into play and updated for new devices in one spot, instead of
> keeping piles of this version or that version or this other version
> checks up to date.

Thanks for the heads up! I am expecting that I'd have to re-base this
series on "next" in PCI tree before it can be applied. This should
provide for a good opportunity to discover and resolve all of the
conflicts, I think.

Thanks,
Andrey Smirnov
