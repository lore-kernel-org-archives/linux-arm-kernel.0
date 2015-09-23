From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Sep 2015 14:06:41 -0700
Subject: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
In-Reply-To: <20150921141018.GC23801@atomide.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
 <CABxcv=mGNmoVu3TDvd1888TiJ_vg0FJF6qz0p4XTu5T776sJ2Q@mail.gmail.com>
 <20150918174836.GG8020@atomide.com>
 <20150918202718.GH8020@atomide.com>
 <CABxcv=nUuqHSJmP=z3X7F=ukeaFi+9cYTYW-wRwuv+mA8Jw2HQ@mail.gmail.com>
 <20150921141018.GC23801@atomide.com>
Message-ID: <20150923210641.GM23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150921 07:16]:
> * Javier Martinez Canillas <javier@dowhile0.org> [150921 02:17]:
> > > Then getting the 32k clock from palmas is not working either, it
> > > seems some better deferred probe handling is needed there if
> > > omap_hsmmc is built-in and palmas-clk is a loadable module.
> > >
> > 
> > IIUC from another email, you already solved this.
> 
> That deferred probe fix did not solve this one, need to debug further.

FYI, found the MMC pwrseq clock issue, I had a typo in my dts
file with "ext_clk" instead of "ext_clock" :)

Will send v2 of $subject patch after some more testing using
both a GPIO regulator-fixed and mmc pwrseq for the clock.

Regards,

Tony
