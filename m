From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Oct 2014 23:56:29 +0000
Subject: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
In-Reply-To: <7hsii58evg.fsf@deeprootsystems.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <7hd29h8n0o.fsf@deeprootsystems.com>
 <20141024161804.GH3729@sirena.org.uk>
 <7hsii58evg.fsf@deeprootsystems.com>
Message-ID: <20141030235629.GH18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 01:46:43PM -0700, Kevin Hilman wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Fri, Oct 24, 2014 at 09:12:39AM -0700, Kevin Hilman wrote:

> >> I'm confused. Why arent' pm_runtime_get*() and pm_runtime_put*() working?

> >> What's not explained here (or what I'm not understanding) is why a PM
> >> domain is powering off if it has active devices.

> > The issue AIUI is what happens during system boot - if one device in a
> > domain probes and marks itself runtime idle then that will trigger
> > domain powerdown even if there is another device in the domain that
> > hasn't yet been probed.  This can cause undesirable glitches (or worse)
> > during boot depending on what's getting powered down.

> I'm not quite seeing how this series fixes that problem.

> Looking at platform devices in PATCH 4/9, the new _get() and _put() are
> still happening around ->probe(), so if a platform device runtime suspends
> after probe, don't we still have a PM domain that can turn off?

Yeah, I haven't actually reviewed the series so I don't know if it does
the above but that was my understanding of the intention.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/54f67faa/attachment-0001.sig>
