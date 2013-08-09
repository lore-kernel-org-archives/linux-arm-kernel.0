From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 Aug 2013 11:56:44 +0100
Subject: [PATCH v2 1/3] hwmon: (lm90) Add power control
In-Reply-To: <520498F3.8030101@nvidia.com>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
 <20130808110136.GA6427@sirena.org.uk> <520498F3.8030101@nvidia.com>
Message-ID: <20130809105644.GW6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 03:23:31PM +0800, Wei Ni wrote:
> On 08/08/2013 07:01 PM, Mark Brown wrote:

> > You shouldn't just be ignoring errors here, though there are deployment
> > difficulties with making sure a stub regulator is provided.  These
> > should be getting easier after the next merge window, the stubs will be
> > being tweaked slightly to have an "assume it's there" option even when

> Oh, really, could you show me the patch, I wish to take a look :)

No patch quite yet - the basic idea is that for plain regulator_get()
you'll only ever get -EPROBE_DEFER as an error, not -ENODEV.  If the
regulator is missing in the DT we assume it's there and provide a dummy
if the DT doesn't hook it up.  If the consumer genuinely wants to see if
a supply might not be wired up it should use regulator_get_optional()
which is in -next at the minute.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/4b97e752/attachment.sig>
