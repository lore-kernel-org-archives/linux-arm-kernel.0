From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Mar 2012 15:54:37 +0100
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
In-Reply-To: <4F7471A0.6070208@compulab.co.il>
References: <CAP=VYLp-weNj35OHtmZ6pf5-t7OUxWREeu8r5sSOLhFYu0CppQ@mail.gmail.com>
 <1331244366-6147-1-git-send-email-paul.gortmaker@windriver.com>
 <4F732C97.2030804@compulab.co.il>
 <20120328152743.GW3232@opensource.wolfsonmicro.com>
 <4F73356D.5080401@windriver.com>
 <20120328161305.GZ3232@opensource.wolfsonmicro.com>
 <4F73437B.6070806@windriver.com> <4F7471A0.6070208@compulab.co.il>
Message-ID: <20120329145436.GS3668@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 04:28:48PM +0200, Igor Grinberg wrote:
> On 03/28/12 18:59, Paul Gortmaker wrote:

> >>> static struct platform_device em_x270_gps_userspace_consumer = {
> >>>         .name           = "reg-userspace-consumer",
> >>>         .id             = 0,

> >>> static struct platform_device em_x270_gprs_userspace_consumer = {
> >>>         .name           = "reg-userspace-consumer",
> >>>         .id             = 1,

> > -REGULATOR_CONSUMER(ldo19, "reg-userspace-consumer", "vcc gprs");
> > +REGULATOR_CONSUMER(ldo19, "reg-userspace-consumer.1", "vcc gprs");

> Well, I thought of this solution, but I don't like it, as it makes
> the whole thing very fragile and sensitive to the reg-userspace-consumer
> platform device registration order and count, isn't it?
> (That's why I proposed to use NULL...).

No the platform device numbering should be totally stable for a given
board unless someone deliberately sets out to renumber them - the .ids
are explicitly assigned by the board when it registers the device.

> So, Mark, how do you think the above issues can be handled without
> putting NULL into the dev_name?

It shouldn't be a problem I think.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120329/c6b5b0e9/attachment.sig>
