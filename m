From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 3 Mar 2016 08:29:44 -0800
Subject: [PATCH v2 1/5] thermal: change "hysteresis" as optional property
In-Reply-To: <1456458227-12950-2-git-send-email-leo.yan@linaro.org>
References: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
 <1456458227-12950-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20160303162942.GA2445@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On Fri, Feb 26, 2016 at 11:43:43AM +0800, Leo Yan wrote:
> The property "hysteresis" is mandatory for trip points, so if without
> it the thermal zone cannot register successfully. But "hysteresis" is
> ignored in the thermal subsystem and only inquired by several thermal
> sensor drivers.

I am not sure this a good direction to go. Remember that Linux
implementation not necessarily has to be the implication of the DT
binding. Hysteresis is a property that plays a significant role on
thermal control systems, which in many cases avoid overshooting cooling
actions. Having the DT writer to explicitly set it to 0 means that zone
does not suffer of overshooting and does not need hysteresis.

If the Linux thermal subsystem has a problem with handling hysteresis, I
would rather fix Linux code than relaxing the DT binding. Or if you
still believe hysteresis is really optional, I would prefer to see a
better justification than "Linux ignores it".

BR,

Eduardo
