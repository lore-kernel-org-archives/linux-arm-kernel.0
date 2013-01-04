From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Jan 2013 16:25:56 -0800
Subject: [PATCH v6 5/8] document: devicetree: bind pinconf with pin single
In-Reply-To: <20121222170725.GB12601@atomide.com>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
 <1356083118-18857-6-git-send-email-haojian.zhuang@linaro.org>
 <20121222012201.GS21056@atomide.com>
 <CAD6h2NQNc0gke1FrEDn7h9ZwoEwBSxiqPAZFQw-By3GBW2xbZw@mail.gmail.com>
 <20121222170725.GB12601@atomide.com>
Message-ID: <20130104002556.GP25633@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [121222 09:14]:
> * Haojian Zhuang <haojian.zhuang@linaro.org> [121221 22:35]:
> > > pinctrl-single,input-schmitt     = <defval regmask enableval disableval>;
> > In Marvell silicons, input-schmitt trigger could be configured as
> > high-edge, low-edge or both
> > detect. So enableval can't cover this usage.

Hmm assuming that's two bits for configuring it, can you make both
detect same as:

pinctrl-single,input-schmitt-high-edge   = <enableval disableval regmask>;
pinctrl-single,input-schmitt-low-edge    = <enableval disableval regmask>;

Or does that not work for you?
 
To me it looks like we should just standarize on the following:

pinctrl-single,bias-enable       = <enableval disableval regmask>;
pinctrl-single,bias-pullup       = <enableval disableval regmask>;
pinctrl-single,bias-pulldown     = <enableval disableval regmask>;
pinctrl-single,input-schmitt	 = <enableval disableval regmask>;
pinctrl-single,input-schmitt-high-edge	 = <enableval disableval regmask>;
pinctrl-single,input-schmitt-low-edge	 = <enableval disableval regmask>;
...
pinctrl-single,comparator-enable = <enableval disableval regmask>;
pinctrl-single,comparator-status = <regmask>;	/* read only status bits */

So no need to stuff the defval there AFAIK.

Regards,

Tony
