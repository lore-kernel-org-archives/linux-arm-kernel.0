From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 23 Aug 2012 19:19:36 +0200
Subject: [PATCH] pwm: Call pwm_enable() before pwm_config()
In-Reply-To: <50366464.4070801@metafoo.de>
References: <36966374.2768747.1345741025741.JavaMail.root@advansee.com>
 <50366464.4070801@metafoo.de>
Message-ID: <50366628.5020007@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2012 07:12 PM, Lars-Peter Clausen wrote:
>[...]
> Or maybe just use the runtime pm API for this. This probably makes even more
> sense and grab a reference to the pm context when the enable() is called,
> release it when disable() is called and also grab it before calling the
> device's config callback and release it afterward.

Btw. this seems to be exactly what the pwm-tiecap and pwm-tiehrpwm drivers
already do today. I'd just make that a core PWM framework feature.
