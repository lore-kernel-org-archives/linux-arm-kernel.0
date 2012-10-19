From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Oct 2012 11:10:19 -0700
Subject: [PATCH v2] pinctrl: reserve pins when states are activated
In-Reply-To: <1350651909-5337-1-git-send-email-linus.walleij@stericsson.com>
References: <1350651909-5337-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20121019181019.GP4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@stericsson.com> [121019 06:09]:
> 
> Instead: let use reserve the pins when the state is activated
> and drop them when the state is disabled, i.e. when we move to
> another state. This way different devices/functions can use the
> same pins at different times.

Hmm doesn't this mean that we are now doing lots of extra
reserving and dropping of pins? Performance is important from
latency point of view for cases where we need to remux pins
constantly runtime PM.

Regards,

Tony
