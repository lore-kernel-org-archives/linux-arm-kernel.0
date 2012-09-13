From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 13 Sep 2012 07:31:03 -0700
Subject: [PATCHv8 00/23]I2C big cleanup
In-Reply-To: <20120913053325.GC6504@arwen.pp.htv.fi> (Felipe Balbi's message
 of "Thu, 13 Sep 2012 08:33:28 +0300")
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
 <874nn2vpv9.fsf@deeprootsystems.com>
 <20120913053325.GC6504@arwen.pp.htv.fi>
Message-ID: <871ui6f108.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

[...]

> I just ran same tests on pandaboard and i2c is suspended actually,
> though no power domain transitions to RET. Do we not have retention
> while idle on pandaboard ?

Not for CORE.  Only CPUx and MPU domains will be transitioning on OMAP4,
and then, only with CPUidle enabled.

Until we have CORE retention support in mainline (we're almost there)
OMAP4 is not a useful test platform for device PM.

Kevin
