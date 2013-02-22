From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 22 Feb 2013 10:38:45 +0000
Subject: [PATCH 01/35] mfd: ab8500-gpadc: Implemented suspend/resume
In-Reply-To: <CAPDyKFo0MpP-d7v8v1zwB42sboR3MWT6nUmG=-L0_nayYRY7FQ@mail.gmail.com>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
 <1360933026-30325-2-git-send-email-lee.jones@linaro.org>
 <20130220131912.GB13049@sirena.org.uk>
 <CAPDyKFo0MpP-d7v8v1zwB42sboR3MWT6nUmG=-L0_nayYRY7FQ@mail.gmail.com>
Message-ID: <20130222103306.GA19796@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 11:45:08PM +0100, Ulf Hansson wrote:
> On 20 February 2013 14:19, Mark Brown

> > This doesn't look especially sane...  You're doing a runtime get, taking
> > the lock without releasing it and disabling the regulator.  This is
> > *very* odd, both the changelog and the code need to explain what's going
> > on and why it's safe in a lot more detail here.

> You need to do pm_runtime_get_sync to be able to make sure resources
> (which seems to be only the regulator) are safe to switch off. To my
> understanding this is a generic way to use for being able to switch
> off resources at a device suspend when runtime pm is used in
> conjunction.

Are you sure this actually does what you think it does, especially when
run on modern kernels?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130222/12b22173/attachment-0001.sig>
