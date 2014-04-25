From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 25 Apr 2014 10:28:06 +0530
Subject: [PATCH] i2c: exynos5: Initialise Samsung High Speed I2C controller
 early
In-Reply-To: <20140424162558.GB12304@sirena.org.uk>
References: <1398350916-885-1-git-send-email-ch.naveen@samsung.com>
 <20140424162558.GB12304@sirena.org.uk>
Message-ID: <5359EB5E.7010800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2014 09:55 PM, Mark Brown wrote:
> On Thu, Apr 24, 2014 at 08:18:36PM +0530, Naveen Krishna Chatradhi wrote:
>> This patch moves initialization code to subsys_initcall() to ensure
>> that the i2c bus is available early so the regulators can be quickly
>> probed and available for other devices on their probe() call.
> 
>> Such solution has been proposed by Mark Brown to fix the problem of
>> the regulators not beeing available on the peripheral device probe():
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011971.html
> 
> What specifically is this needed for?  We *should* be able to use
> deferred probe for most things, but I know that not all subsystems are
> able to yet.
> 

DRM-Exynos is one such sub-system right now that doesn't handle deferred
probe well. That is one of the reasons for this patch.

-- 
Tushar Behera
