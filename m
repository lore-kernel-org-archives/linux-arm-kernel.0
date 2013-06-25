From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Jun 2013 00:41:03 -0700
Subject: [PATCH] pinctrl: rip out the direct pinconf API
In-Reply-To: <51C86524.8020708@wwwdotorg.org>
References: <1372079700-16580-1-git-send-email-linus.walleij@stericsson.com>
 <51C86524.8020708@wwwdotorg.org>
Message-ID: <20130625074102.GG5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130624 08:32]:
> On 06/24/2013 07:15 AM, Linus Walleij wrote:
> > From: Linus Walleij <linus.walleij@linaro.org>
> > 
> > From the inception ot the pin config API there has been the
> > possibility to get a handle at a pin directly and configure
> > its electrical characteristics. For this reason we had:
> > 
> > int pin_config_get(const char *dev_name, const char *name,
> >                unsigned long *config);
> > int pin_config_set(const char *dev_name, const char *name,
> >                unsigned long config);
> > int pin_config_group_get(const char *dev_name,
> >                const char *pin_group,
> >                unsigned long *config);
> > int pin_config_group_set(const char *dev_name,
> >                const char *pin_group,
> >                unsigned long config);
> > 
> > After the intruction of the pin control states that will
> > control pins associated with devices, and its subsequent
> > introduction to the device core, as well as the
> > introduction of pin control hogs that can set up states on
> > boot and optionally also at sleep, this direct pin control
> > API is a thing of the past.
> > 
> > As could be expected, it has zero in-kernel users.
> > Let's delete this API and make our world simpler.
> 
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Tony Lindgren <tony@atomide.com>
