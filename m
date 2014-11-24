From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Nov 2014 18:16:15 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <546FCE3A.1000005@codeaurora.org>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk>
 <546FCE3A.1000005@codeaurora.org>
Message-ID: <20141124181614.GT7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 03:43:54PM -0800, Stephen Boyd wrote:
> On 11/21/2014 03:27 PM, Mark Brown wrote:

> > I'm afraid the above is making very little sense to me.  What is
> > "voting" and how is it different to "enabling", "notification" or
> > "flushing"?

> The regulators are shared between multiple "masters" in the SoC. So the
> CPUs that are running linux only "vote" on attributes of regulators and
> then another processor that isn't running linux (called RPM) aggregates
> the request from Linux along with other "masters" like wifi, modem, etc.
> and then changes something for that regulator like voltage,
> enable/disable, etc. We also have some hardware next to our CPUs that
> notifies the RPM when we transition into or out of idle/suspend (it's
> called an SPM). This is the notification part. Flushing has to do with
> batching up multiple RPM sleep set requests and sending them before we
> enter idle/suspend.

...

> Hopefully it's clear now. If not I can clarify further.

A bit, but I'm afraid I'm still at a loss as to what the problems and
debate are here.  Why is this more complex than the Linux part of the
system just saying what it wants at any given time?  It sounds like that
has some sort of performance issue?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/0f9234ad/attachment.sig>
