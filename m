From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Jul 2010 10:40:39 -0700
Subject: [PATCH 2/2] ARM: S5PV210: Add the GPIO lib
In-Reply-To: <4C4F9E4D.4090608@samsung.com>
References: <4C4F9E4D.4090608@samsung.com>
Message-ID: <20100729174038.GF24781@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 12:04:45PM +0900, Chanwoo Choi wrote:
> This patch add the definition of GPIO to support WM8994 audio codec on
> I2C bus.
> 
> Signed-off-by : Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by : Kyungmin Park <kyungmin.park@samsung.com>

This should come before the patch using it in your patch series, that
way things won't break when people do git bisect and try to build the
first patch without the second.  The changelog could also do with a bit
of a cleanup - this isn't something that's specific to a particular
board, it's adding support for the GPIOs for whatever function they are
needed on any board using this processor.
