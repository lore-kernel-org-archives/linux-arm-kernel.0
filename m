From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Nov 2013 11:46:10 -0700
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized using
 pinfunc.
In-Reply-To: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>
Message-ID: <528BB1F2.4080107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 10:15 AM, Tomasz Figa wrote:
> This patch extends the range of settings configurable via pinfunc API
> to cover pin value as well. This allows configuration of default values
> of pins.

Shouldn't there be a driver that acquires the GPIO that's output to the
pin, and configures the output value? IIRC there have been previous
discussions re: having a list of e.g. initial GPIO output values in DT,
and that was rejected, and this patch seems to be doing almost the exact
same thing, just at the pinctrl level rather than GPIO level.

That all said, I admit this could be a useful feature...
