From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 29 Apr 2012 21:04:58 +0200
Subject: [PATCH 1/3] pwm-core: fix compilation when OF is not selected
In-Reply-To: <20120429205915.63eace41@eb-e6520>
References: <1335713330-6488-1-git-send-email-eric@eukrea.com>
 <20120429170431.GA29827@avionic-0098.adnet.avionic-design.de>
 <20120429205915.63eace41@eb-e6520>
Message-ID: <20120429190458.GA31245@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eric B?nard wrote:
> Le Sun, 29 Apr 2012 19:04:31 +0200,
> Thierry Reding <thierry.reding@avionic-design.de> a ?crit :
> 
> > * Eric B?nard wrote:
> > > else we get the following error :
> > > drivers/pwm/core.c: In function 'pwm_get':
> > > drivers/pwm/core.c:538:3: error: implicit declaration of function 'of_pwm_request' [-Werror=implicit-function-declaration]
> > > 
> > > Signed-off-by: Eric B?nard <eric@eukrea.com>
> > 
> > This is solved a little differently in the latest patches. That no longer has
> > the of_pwm_request() function protected by #ifdef CONFIG_OF, but rather calls
> > it in a IS_ENABLED(CONFIG_OF)-protected block so that it will still receive
> > compile coverage in !OF configurations but at the same time will be removed
> > by the compiler's dead code elimination.
> > 
> OK this still doesn't work (using linux-2.6 at :
> f7b006931751f029620ad2f8310ac7a1484fbdb4 ) leads to :
>  CC      drivers/pwm/core.o drivers/pwm/core.c: In function
>  'of_pwm_request': drivers/pwm/core.c:447:3: error: implicit
>  declaration of function
>  'of_property_match_string' [-Werror=implicit-function-declaration]
>  drivers/pwm/core.c:452:2: error: implicit declaration of function
>  'of_parse_phandle_with_args' [-Werror=implicit-function-declaration]
> 
> in include/linux/of.h the declaration of these function is inside
> a #ifdef CONFIG_OF / #endif so I don't see how this can compile.

I've already posted patches to the devicetree-discuss mailing list. I hope
they'll be queued soon.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120429/d0104846/attachment.sig>
