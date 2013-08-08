From: broonie@kernel.org (Mark Brown)
Date: Thu, 8 Aug 2013 20:27:47 +0100
Subject: [PATCH v2 1/3] hwmon: (lm90) Add power control
In-Reply-To: <5203D5B6.3060806@wwwdotorg.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1375944991-29182-2-git-send-email-wni@nvidia.com>
 <520359E9.1000600@roeck-us.net> <5203D5B6.3060806@wwwdotorg.org>
Message-ID: <20130808192747.GM6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 11:30:30AM -0600, Stephen Warren wrote:
> On 08/08/2013 02:42 AM, Guenter Roeck wrote:

> > If the regulator subsystem is not configured, you especially don't need
> > or want
> > to pollute the log with an error message.

> DT parsing errors should be reported. However, if there's nothing to
> parse, it's not an error.

> So, I think this should report an error message *if* there is a DT
> property that defines the regulator to use. If there's no property, just
> use no regulator. If there is a property, it had better be possible to
> parse it.

On a DT system you should get this behaviour simply by paying attention
to the error code from the regualtor API - the core should complain
loudly if the DT is incomprehensible.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130808/5d4dd604/attachment.sig>
