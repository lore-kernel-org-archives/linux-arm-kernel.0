From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Apr 2017 11:19:52 +0200
Subject: [PATCH v5 1/4] gpio: mvebu: Add limited PWM support
In-Reply-To: <20170412151932.GE7023@lunn.ch>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
 <20170409180931.4884-2-ralph.sennhauser@gmail.com>
 <20170412163128.5c985a26@free-electrons.com>
 <20170412151932.GE7023@lunn.ch>
Message-ID: <20170421111952.54978e80@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 12 Apr 2017 17:19:32 +0200, Andrew Lunn wrote:

> Yep. It was a compromise. By adding a new binding for the GPIO driver,
> this might be possible. But it did not seem worth such a major change.
> 
> The prime use of this feature is for controlling a fan. So far, i've
> not seen any hardware with more than one fan, i.e. needs more than one
> PWM. Nor have i seen any hardware with the GPIO for the fan being on
> the third bank. A hardware manufacture could add multiple fans, but i
> doubt it, they make noise and fail. And if a manufacture does place a
> fan on the third bank, it can still be controlled as a plain GPIO fan,
> as we have been doing for the last few years.

Right.

> So i personally think it is an O.K. compromise.

I clearly don't want to block this, but I believe this is a very good
illustration of why stable DT bindings simply don't work. We are
realizing here that having each GPIO bank represented as a separate DT
node doesn't work, because this blinking functionality is not per GPIO
bank, but global to all GPIO banks.

I am totally fine with compromise, and having things simple first, and
extend them later if needed. But this stable DT binding rule makes this
quite impossible: what is a compromise today might put you in big
troubles tomorrow.

Anyway, it's fine for me, I don't think it's worth the effort making a
much more complicated solution/change.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
