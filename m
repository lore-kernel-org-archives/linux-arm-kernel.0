From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Nov 2012 10:11:18 -0700
Subject: [PATCH v3 1/3] power: Add simple poweroff-gpio driver
In-Reply-To: <20121120083749.GM10259@lunn.ch>
References: <1353142266-1289-1-git-send-email-andrew@lunn.ch>
 <1353142266-1289-2-git-send-email-andrew@lunn.ch>
 <50AA6E7E.5060501@wwwdotorg.org> <20121120083749.GM10259@lunn.ch>
Message-ID: <50ABB9B6.1010506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 01:37 AM, Andrew Lunn wrote:
> Hi Jason
> 
> These are good comments from Stephan that i want to address. However,
> i also don't want to delay the pull-requests direction arm-soc, the
> merge window is getting close. Both Linus and Anton have Acked the
> current version, so please go with what you have and i will produce a
> patch over the top. If its available before Arnd pulls, you can squash
> it, otherwise send it upstream as a standalone patch.

I'm not sure I agree here; the comments I made re: the delays and
pulse-vs-level may affect the definition of the DT binding, and that's
something that should be correct from the start.

The implementation of gpio_poweroff_do_poweroff() really doesn't seem to
make sense; related to the above.

Also, probe deferral doesn't work, which will likely make this code
completely ineffective.
