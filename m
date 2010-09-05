From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 5 Sep 2010 21:23:23 +0200
Subject: [PATCH] ARM: pxa: Fix pxa3xx-u2d crash when ULPI not used
In-Reply-To: <4C83A9D9.9050803@compulab.co.il>
References: <1283546146-20000-1-git-send-email-marek.vasut@gmail.com>
	<AANLkTik7Hzs8OUKSL+6HRgvR1iRWg4LE_v0LMUC2VxVZ@mail.gmail.com>
	<4C83A9D9.9050803@compulab.co.il>
Message-ID: <201009052123.23477.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Ne 5. z??? 2010 16:31:53 Igor Grinberg napsal(a):
>  On 09/05/10 16:58, Eric Miao wrote:
> > On Sun, Sep 5, 2010 at 9:46 PM, Igor Grinberg <grinberg@compulab.co.il> 
wrote:
> >>  On 09/05/10 13:43, Eric Miao wrote:
> >>> On Sun, Sep 5, 2010 at 4:35 PM, Igor Grinberg <grinberg@compulab.co.il>
> >>> wrote: Igor,
> >>> 
> >>> So do you this as a proper fix, or there is better way out?
> >> 
> >> If we want to keep it the most straight-forward way so it is fine.
> >> 
> >> Another possible ways would be:
> >> 
> >> 1) create a new flag, lets say PORT2_USE_U2DC in pxaohci_platform_data.
> >> This is a relatively clean way of making ohci aware of
> >> u2d existence at runtime and eliminates the calls to functions
> >> of non-existing (not loaded) driver...
> >> 
> >> 2) use something like:
> >> struct u2d_hc_ops {
> >> 
> >>    int (*start_hc)(...);
> >>    void (*stop_hc)(...);
> >> 
> >> }
> >> 
> >> in board init code register the ops structure via the pxa_ohci platform
> >> data.
> >> 
> >> This way adds some more pollution to the pxa_ohci glue with code
> >> relevant only to pxa3xx, achieving the same as the 1st way, but also
> >> can be useful for u2dc otg/peripheral driver (if it will come some
> >> day...).
> >> 
> >> I'm fine with both (Marek's patch or my proposal), so tell me what
> >> looks better to you.
> > 
> > That sounds to be a cleaner way, but may require more changes. What
> > if we get this patch into -rc phase as is first, and get a cleaner patch
> > for -next?
> 
> Fine with me.

Morning (even if it's 9pm here).

I'd be for solution #2 as well. I might eventually look into it, but now it's 
really impossible for me. Just two more weeks until I'll be able to activelly 
participate on kernel development again.

Cheers
