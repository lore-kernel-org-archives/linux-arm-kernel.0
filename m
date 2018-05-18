From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 May 2018 07:32:59 -0700
Subject: [PATCH 4/4] omap4-droid4: Use software debounce for gpio-keys
In-Reply-To: <20180518072109.GA31304@amd>
References: <20180517233542.30629-1-tony@atomide.com>
 <20180517233542.30629-5-tony@atomide.com>
 <20180518072109.GA31304@amd>
Message-ID: <20180518143259.GW98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [180518 07:23]:
> BTW, did you notice that debouncing is wrong on most of the keyboard?
> If you double click a key (most will do, for example "J") it will fail
> to recognize second release and instead of expected "jj", you get
> autorepeat ("jjjjjjjjjjjjjjjjjjjjjj...").

Hmm OK I have not seen that one.

> Ok, I guess main keyboard is not on GPIO...

No it's using omap4-keypad.c.

> > @@ -128,6 +128,7 @@
> >  			gpios = <&gpio5 26 GPIO_ACTIVE_LOW>; /* gpio154 */
> >  			linux,code = <KEY_VOLUMEDOWN>;
> >  			linux,can-disable;
> > +			debounce-interval = <10>;
> 
> I'd say this subtlety is worth a comment.

Good idea, I'll add a comment "Value above 7.95ms for no GPIO hardware
debounce". I'll do it also for duovero.

Regards,

Tony
