From: viresh.linux@gmail.com (viresh kumar)
Date: Tue, 24 Apr 2012 22:35:26 +0530
Subject: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <20120424142939.GG24089@lunn.ch>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
 <20120424120019.GE24089@lunn.ch>
 <CAOh2x==YaPxYxigyE=n2weoKHhu4ktGRHHGdzgs2+d1_Lo-D4Q@mail.gmail.com>
 <20120424142939.GG24089@lunn.ch>
Message-ID: <CAOh2x==itVxwPAFaHgDW4L6FHZrBjWKSV2u4RCEqXHCEWgqHsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/12, Andrew Lunn <andrew@lunn.ch> wrote:
> static int __clk_enable(struct clk *clk)
> {
>         int ret = 0;
>
>         if (!clk)
>                 return 0;
>
>         if (WARN_ON(clk->prepare_count == 0))
>                 return -ESHUTDOWN;
>
>    this should actually be clk_prepare_enable(). Did you see my
>    patches adding generic clk framework support for Orion. I fixed
>    this as part of that patch set.

Sorry for missing it earlier. Ya i know it must be clk_prepare_enable(),
but it wasn't motive of my patchset.

Sorry, i haven't gone through your patches for Orion.

--
viresh
