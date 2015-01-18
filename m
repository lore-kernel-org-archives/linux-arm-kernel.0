From: broonie@kernel.org (Mark Brown)
Date: Sun, 18 Jan 2015 12:35:31 +0000
Subject: [PATCH v4 4/4] ARM: mvebu: Armada 385 GP: Add regulators to the
 SATA port
In-Reply-To: <54BA7197.40301@redhat.com>
References: <1421330978-9694-5-git-send-email-gregory.clement@free-electrons.com>
 <54B8C933.7020502@redhat.com> <54B8D97B.3090908@free-electrons.com>
 <54B8E38A.6020709@redhat.com> <20150116123705.GM3043@sirena.org.uk>
 <54B9629C.9090800@redhat.com> <20150116202516.GL3856@sirena.org.uk>
 <54BA21F9.5050408@redhat.com> <20150117131404.GA6414@sirena.org.uk>
 <54BA7197.40301@redhat.com>
Message-ID: <20150118123531.GA2809@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 03:28:39PM +0100, Hans de Goede wrote:
> On 17-01-15 14:14, Mark Brown wrote:

> >Following your argument to the logical conclusion means we can never
> >turn any regualtor off - we always have the risk that there's another
> >shared user which is going to get a power bounce if we power down.  More
> >directly we'll also get people complaining that we're burning power
> >pointlessly on their systems for devices they've not even got drivers
> >enabled for.  This powering down is something there's been user demand
> >for.

> Right, note I'm only advocating to not turn off regulators marked as
> regulator-boot-on. I would expect any regulator to have such a
> marking to have at least one user with an actual driver. If people decide
> to not build that driver, and then complain we can simply tell them to
> build the driver ...

Right, but that's not what regulator-boot-on actually means (and I'm not
sure why you would think it would TBH) so this will disrupt existing
users who are expecting the current behaviour.  We could try adding a
new property but it doesn't feel very idiomatic for DT which isn't very
nice.

Telling people not to build the driver doesn't in general work any
better than telling them to build it in I fear, it seems like it's
essentially just shuffling things around so people have to change their
kernel config in a different way to avoid issues.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150118/d6cfb150/attachment.sig>
