From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Jun 2016 15:10:08 +0200
Subject: [PATCH v3 20/20] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
In-Reply-To: <20160608205152.GA5511@rob-hp-laptop>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-21-lee.jones@linaro.org>
 <20160608205152.GA5511@rob-hp-laptop>
Message-ID: <20160610131008.GF27142@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 03:51:52PM -0500, Rob Herring wrote:
> On Wed, Jun 08, 2016 at 10:21:35AM +0100, Lee Jones wrote:
> > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
> > be more inline with the naming conventions of the subsystem.  Where
> > we used to treat each line as a channel, the PWM convention is to
> > describe them as devices.
> 
> That's all linux implementation details and you are breaking 
> compatibility.

While it's true that the API calls channels struct pwm_device, that's
primarily for historical reasons. It's completely fine, and in fact most
drivers already do exactly that, to internally refer to channels as
channels.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/494ab9c9/attachment.sig>
