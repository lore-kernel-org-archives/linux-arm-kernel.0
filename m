From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Jul 2014 11:42:53 +0100
Subject: [RFC 3/5] regulator: core: Only apply constraints if available
 on list voltage
In-Reply-To: <53D8B195.4050003@collabora.co.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
 <1406651339-28901-4-git-send-email-javier.martinez@collabora.co.uk>
 <20140729171857.GV17528@sirena.org.uk>
 <53D8B195.4050003@collabora.co.uk>
Message-ID: <20140730104253.GP17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 10:49:25AM +0200, Javier Martinez Canillas wrote:
> On 07/29/2014 07:18 PM, Mark Brown wrote:

> > I would also expect any regulator where the supplied devices are able to
> > vary the voltage to explicitly provide a constraint even if the
> > implementation is done in a parent regulator.  There may be constraints
> > on the child supply which aren't directly present on the parent supply
> > and can be ignored if the child supply is turned off.

> Agreed, if I explicitly set the voltage constraints on the child supply then
> this patch is indeed not needed.

We will, however, need some code to pass the child supply constraints on
to the parent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/3d8206bc/attachment.sig>
