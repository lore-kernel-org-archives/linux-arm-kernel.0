From: peter@korsgaard.com (Peter Korsgaard)
Date: Wed, 20 Jan 2016 08:41:55 +0100
Subject: [PATCH v2 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D63F6228@penmbx01> (Wenyou
 Yang's message of "Wed, 20 Jan 2016 07:37:36 +0000")
References: <1452586629-1117-1-git-send-email-wenyou.yang@atmel.com>
 <1452586629-1117-2-git-send-email-wenyou.yang@atmel.com>
 <87oacp5zl7.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63EBC6E@penmbx01>
 <87egdk39ji.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63EBEC7@penmbx01>
 <87a8o82xq3.fsf@dell.be.48ers.dk>
 <B256D81BAE5131468A838E5D7A243641D63F6228@penmbx01>
Message-ID: <878u3kvgsc.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Yang," == Yang, Wenyou <Wenyou.Yang@atmel.com> writes:

Hi,

>> > The MFD sub device is registered as a platform device, the existing  > act8865
 >> driver is registered as an i2c_driver. How do they match? :)
 >> 
 >> > Could you point out which exiting driver for me to reference.  Thank you!
 >> 
 >> What I'm saying is that it isn't nice that we end up with both act8865-regulator.c
 >> and act8954-regulator.c doing 95% the same. This can either be fixed by:
 >> 
 >> - Adding act8865 support to your mfd driver (but only registering the
 >> regulator subdev for act8865) and changing the existing
 >> act8865-regulator driver to work as a mfd subdev (platform device)
 >> 
 >> - Extending the act8865-regulator driver to register as a platform
 >> driver in ADDITION to a i2c driver so it can be used with mfd. The
 >> driver already uses regmap so it should only be a matter of adding the
 >> pdev probe/remove functions.

 > After think twice, I think this will complicates the act8865-regulator driver.

I don't think it will add a lot of complication (E.G. basically just the
platform probe/remove functions), but Ok - I'll wait and see your
simplified driver.

-- 
Venlig hilsen,
Peter Korsgaard 
