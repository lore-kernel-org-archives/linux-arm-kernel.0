From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 2 Mar 2018 14:02:12 +0300
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <20180302110002.wmkvktobi7ssmin5@mwanda>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302102926.fuqmfyaxiujjwill@ninjato>
 <20180302110002.wmkvktobi7ssmin5@mwanda>
Message-ID: <20180302110212.7wfk6hn4tf5l7ax4@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 02:00:03PM +0300, Dan Carpenter wrote:
> On Fri, Mar 02, 2018 at 11:29:26AM +0100, Wolfram Sang wrote:
> > On Thu, Mar 01, 2018 at 09:34:44PM +0100, Krzysztof Kozlowski wrote:
> > > Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
> > > so do not treat it as an error.  If interrupt 0 was configured, the driver
> > > would exit the probe early, before finishing initialization, but with
> > > 0-exit status.
> > > 
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Cc: stable at vger.kernel.org
> > > Fixes: e0d1ec97853f ("i2c-s3c2410: Change IRQ to be plain integer.")
> > 
> > Please configure git to use 14 digits here.
> 
> Wait, when did we decide that 12 wasn't enough?
> 
> I just did a `git log | grep Fixes | tee baz | head -n 200` and only on
> my git tree tehre were only 2 which used exactly 14 digits.  The
> standard is 12.

Wow...  I clearly did not read that email before sending it...  :(

regards,
dan carpenter
