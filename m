From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Jul 2012 04:31:17 -0700
Subject: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
In-Reply-To: <CAAwP0s1UB_Q33KhXp_gvKfTMHRiBaH60HmXsMKxVkAxT1byctg@mail.gmail.com>
References: <1342485005-5178-1-git-send-email-javier@dowhile0.org>
 <CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com>
 <CABxcv=nsmeVLspzXERYXebmPaNO6rKCsVnak7dMtvGjiYH4vOw@mail.gmail.com>
 <20120718065951.GH6522@atomide.com>
 <CAAwP0s1UB_Q33KhXp_gvKfTMHRiBaH60HmXsMKxVkAxT1byctg@mail.gmail.com>
Message-ID: <20120719113116.GM6522@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <martinez.javier@gmail.com> [120718 01:31]:
> That was my first approach in fact, I sent this patch:
> https://patchwork.kernel.org/patch/1198401/
> 
> But then was told by Kevin Hilman that the right solution was to do
> the select on the drives to fix not only omap2plus_defconfig but any
> config.
> So I sent this patch and Santosh agrees with Kevin.
> 
> I don't really know the hardware nor the driver well enough to have a
> strong position on this.

Ideally we would not select it or have depends on it. DMA channels
can run out, and drivers need to work also without DMA. For doing
distro kernels, building everything as modules should be an option
rather than forcing to build in all kinds of code.

Regards,

Tony
