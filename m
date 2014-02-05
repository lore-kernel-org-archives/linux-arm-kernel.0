From: mporter@linaro.org (Matt Porter)
Date: Wed, 5 Feb 2014 10:18:26 -0500
Subject: [PATCH 1/6] i2c: bcm-kona: register with subsys_initcall
In-Reply-To: <20140205090818.GA2614@katana>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-2-git-send-email-mporter@linaro.org>
 <20140205090818.GA2614@katana>
Message-ID: <20140205151826.GC22153@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 10:08:18AM +0100, Wolfram Sang wrote:
> On Tue, Feb 04, 2014 at 07:19:07AM -0500, Matt Porter wrote:
> 
> > Voltage regulators are needed very early due to deferred probe
> > being incompatible with built-in USB gadget drivers.
> 
> What does it need to fix those instead?

[added Alan/Felipe for more insight]

Discussion on that topic came about from this submission:
http://www.spinics.net/lists/linux-usb/msg94217.html

End of it is:
http://www.spinics.net/lists/linux-usb/msg94731.html

We can either add to the many drivers that already do subsys_initcall()
for similar reasons...or I can drop this from the series and add gadget
probe ordering to my TODO list.

In short, it can't be a late_initcall() hack like the original post and
really could be solved by converting to a real bus (and letting
deferred probe do its job)..but Alan voiced concerns about that.

-Matt
