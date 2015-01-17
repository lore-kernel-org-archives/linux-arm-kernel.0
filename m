From: broonie@kernel.org (Mark Brown)
Date: Sat, 17 Jan 2015 13:14:05 +0000
Subject: [PATCH v4 4/4] ARM: mvebu: Armada 385 GP: Add regulators to the
 SATA port
In-Reply-To: <54BA21F9.5050408@redhat.com>
References: <1421330978-9694-1-git-send-email-gregory.clement@free-electrons.com>
 <1421330978-9694-5-git-send-email-gregory.clement@free-electrons.com>
 <54B8C933.7020502@redhat.com> <54B8D97B.3090908@free-electrons.com>
 <54B8E38A.6020709@redhat.com> <20150116123705.GM3043@sirena.org.uk>
 <54B9629C.9090800@redhat.com> <20150116202516.GL3856@sirena.org.uk>
 <54BA21F9.5050408@redhat.com>
Message-ID: <20150117131404.GA6414@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 09:48:57AM +0100, Hans de Goede wrote:

> and leave these regulators on, rather then turn them of $random time,
> because as I've advocated before (see the simplefb thread) there is
> no simple magic moment when it is right to turn things off, so doing
> it when userspace starts is more or less as good as any moment, and if
> it turns out that that is not a good moment, then maybe we need to
> re-think the turning off in general.

Following your argument to the logical conclusion means we can never
turn any regualtor off - we always have the risk that there's another
shared user which is going to get a power bounce if we power down.  More
directly we'll also get people complaining that we're burning power
pointlessly on their systems for devices they've not even got drivers
enabled for.  This powering down is something there's been user demand
for.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150117/eb85c4fd/attachment.sig>
