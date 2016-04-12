From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 12 Apr 2016 10:37:22 +0200
Subject: [PATCH v5 30/46] regulator: pwm: retrieve correct voltage
In-Reply-To: <20160412044203.GW3351@sirena.org.uk>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-31-git-send-email-boris.brezillon@free-electrons.com>
 <20160330212410.GX2350@sirena.org.uk>
 <20160407235431.788dc24a@bbrezillon>
 <20160412044203.GW3351@sirena.org.uk>
Message-ID: <20160412103722.0bfe1d4d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 12 Apr 2016 05:42:03 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Apr 07, 2016 at 11:54:31PM +0200, Boris Brezillon wrote:
> 
> > Is there any reason for calling set_machine_constraints() after
> > device_register() in regulator_register()?
> 
> I'm not sure there's a strong one, we don't really use the class device
> for anything, but without doing a full audit I couldn't guarantee that.

At first glance I don't see any problem (even the rdev_err/info/...()
functions do not use dev_err/info/...()). The patch will be part of v6
(unless you want me to send it independently).

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
