From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Jun 2013 10:06:08 -0600
Subject: [PATCH] reset: provide dummy API entries to avoid link errors
In-Reply-To: <1370755846-27011-1-git-send-email-Baohua.Song@csr.com>
References: <1370755846-27011-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <51B5F970.1080505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2013 11:30 PM, Barry Song wrote:
> this patch provides dummy reset API entries like other subsystem e.g.
> gpiolib to avoid link errors when RESET_CONTROLLER is not enabled.

I would tend to think that any driver that needs to use this API to
reset its HW should depend on the reset API (or select it) to ensure
that the API was present.

That way, problems would be detected at compile-time, not run-time.
