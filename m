From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Feb 2013 13:51:24 +0000
Subject: [PATCH 01/35] mfd: ab8500-gpadc: Implemented suspend/resume
In-Reply-To: <CAPDyKFpJzuzB_7=eH7iNV69TLOTbdBCTx3CgqPTkianZCctKag@mail.gmail.com>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
 <1360933026-30325-2-git-send-email-lee.jones@linaro.org>
 <20130220131912.GB13049@sirena.org.uk>
 <CAPDyKFo0MpP-d7v8v1zwB42sboR3MWT6nUmG=-L0_nayYRY7FQ@mail.gmail.com>
 <20130222103306.GA19796@opensource.wolfsonmicro.com>
 <CAPDyKFpJzuzB_7=eH7iNV69TLOTbdBCTx3CgqPTkianZCctKag@mail.gmail.com>
Message-ID: <20130225135123.GA28907@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 10:27:36AM +0100, Ulf Hansson wrote:
> On 22 February 2013 11:38, Mark Brown

> > Are you sure this actually does what you think it does, especially when
> > run on modern kernels?

> Not sure, what you are thinking of more precisely here. Runtime pm has
> been in the kernel for quite some time now.

Yes, thanks - I was aware of that.  The integration between runtime and
system PM has been an area that's had some development though.

> Anyway, to make it a bit clearer, we switch the regulator on/off at
> the runtime suspend/resume callbacks. We want to take similar actions
> in device suspend/resume.
> To accomplish this a pm_runtime_get_sync is done in suspend and vice
> verse in resume, otherwise you can not safely handle the regulator.

Are you absolutely positive that with modern kernels your get actually
resumes the device?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130225/9527c3a7/attachment.sig>
