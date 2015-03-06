From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Mar 2015 09:13:52 -0800
Subject: [PATCH 0/2] pinctrl: dt-bindings: Fix amx3 SLEWCTRL_FAST binding
In-Reply-To: <1425085827-4514-1-git-send-email-d-gerlach@ti.com>
References: <1425085827-4514-1-git-send-email-d-gerlach@ti.com>
Message-ID: <20150306171351.GU13520@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [150227 17:14]:
> Currently both am33xx and am43xx have the macro for SLEWCTRL_FAST
> in pinctrl dt-bindings reversed so that selecting the macro actually
> sets SLEWCTRL_SLOW in the pad control registers. These patches
> correct the bindings but leave the pinctrl states that use the binding
> *UNMODIFIED*. Previously i2c and mdio on am33xx and i2c, mdio, and
> uart on am43xx had been using this macro and selecting SLEWCTRL_FAST
> while actually programming SLEWCTRL_SLOW in the pad config registers.
> 
> Because the intended selection was SLEWCTRL_FAST the macros are
> unchanged. I tested on am335x-gp-evm and am437x-gp-evm with no
> difference in functionality seen.

Applying both into omap-for-v4.0/fixes thanks.

Tony
