From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 15:33:30 +0100
Subject: [PATCH 06/10] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
In-Reply-To: <CAJuYYwSMant-44jvvyeefojmur7vCvKLeEPWEK52pqUTB4RZkg@mail.gmail.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
 <20120509085617.GB28702@sirena.org.uk>
 <201205091110.15224.heiko@sntech.de>
 <20120509105500.GG3955@opensource.wolfsonmicro.com>
 <CAJuYYwSMant-44jvvyeefojmur7vCvKLeEPWEK52pqUTB4RZkg@mail.gmail.com>
Message-ID: <20120509143330.GV3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 10:22:26PM +0800, Thomas Abraham wrote:
> On 9 May 2012 18:55, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Yes, that's the normal way of handling this and is actually what the
> > code was originally doing - there's a bunch of ifdefed devices in
> > plat-samsung/devs.c. ?You usually have to do this anyway as the IPs move
> > about so the resources need changing.

> In addition to the setting the name, the platform data is also
> assigned at runtime. Adding multiple platform devices means that we
> add lot more code in setting up the platform data. And since we are
> moving towards adopting dt, these would anyway go away when we have
> all the platforms migrated to dt.

With your refactoring the only platform data that's left is the /CS?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/f1c8c605/attachment.sig>
