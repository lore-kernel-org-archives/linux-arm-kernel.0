From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 30 Oct 2014 17:07:49 -0700
Subject: [PATCH v3 4/9] drivercore / platform: Keep PM domain powered
 during ->probe()
In-Reply-To: <7hoast8eu8.fsf@deeprootsystems.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <1413208930-26019-5-git-send-email-ulf.hansson@linaro.org>
 <7hoast8eu8.fsf@deeprootsystems.com>
Message-ID: <20141031000749.GK36444@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 01:47:27PM -0700, Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > To sucessfully probe some devices their corresponding PM domains may
> > need to be powered.
> 
> Isn't that what pm_runtime_get*() is supposed to be doing?  Why isn't
> that working?

Also, I do not understand why we placing device into a power domain only
when we probe it. Why if I unbind device from its driver (or do not have
a driver for it) it disappears from its power domain? To me power domain
and having driver bound to a device are 2 orthogonal concepts.

Thanks.

-- 
Dmitry
