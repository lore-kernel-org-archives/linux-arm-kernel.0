From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Sun, 17 Feb 2013 16:12:31 +0100
Subject: [PATCH] i2c: Remove unneeded xxx_set_drvdata(..., NULL) calls
In-Reply-To: <1360970315-32116-1-git-send-email-dianders@chromium.org> (Doug
 Anderson's message of "Fri, 15 Feb 2013 15:18:35 -0800")
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
 <1360970315-32116-1-git-send-email-dianders@chromium.org>
Message-ID: <87txpboty7.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Doug" == Doug Anderson <dianders@chromium.org> writes:

 Doug> There is simply no reason to be manually setting the private driver
 Doug> data to NULL in the remove/fail to probe cases.  This is just extra
 Doug> cruft code that can be removed.

 Doug> A few notes:
 Doug> * Nothing relies on drvdata being set to NULL.
 Doug> * The __device_release_driver() function eventually calls
 Doug>   dev_set_drvdata(dev, NULL) anyway, so there's no need to do it
 Doug>   twice.
 Doug> * I verified that there were no cases where xxx_get_drvdata() was
 Doug>   being called in these drivers and checking for / relying on the NULL
 Doug>   return value.

 Doug> This could be cleaned up kernel-wide but for now just take the baby
 Doug> step and remove from the i2c subsystem.

 Doug> Reported-by: Wolfram Sang <wsa@the-dreams.de>
 Doug> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
 Doug> Signed-off-by: Doug Anderson <dianders@chromium.org>

For i2c-ocores.c + i2c-mux-gpio.c:

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
