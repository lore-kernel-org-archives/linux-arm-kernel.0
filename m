From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 4 Aug 2015 17:56:26 +0800
Subject: [RFC PATCH 2/3] mailbox: Hisilicon: add mailbox driver
In-Reply-To: <1438679859.8734.35.camel@tiscali.nl>
References: <1438564390-28111-1-git-send-email-leo.yan@linaro.org>
 <1438564390-28111-3-git-send-email-leo.yan@linaro.org>
 <1438677024.8734.24.camel@tiscali.nl>
 <20150804084930.GA27609@leoy-linaro>
 <1438679859.8734.35.camel@tiscali.nl>
Message-ID: <20150804095626.GC27609@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 11:17:39AM +0200, Paul Bolle wrote:
> On di, 2015-08-04 at 16:49 +0800, Leo Yan wrote:
> > On Tue, Aug 04, 2015 at 10:30:24AM +0200, Paul Bolle wrote:
> > > On ma, 2015-08-03 at 09:13 +0800, Leo Yan wrote:
> > > > --- /dev/null
> > > > +++ b/drivers/mailbox/hisilicon/Kconfig
> > > 
> > > > +config HISI_MBOX
> > > > +	bool "Hisilicon's Mailbox"
> > > > +	depends on ARCH_HISI || OF
> > > 
> > > ARCH_HISI is available on either ARM64 or ARM. ARM64 selects OF. On ARM
> > > ARCH_HISI depends on ARCH_MULTIV7 which depends on ARCH_MULTIPLATFORM.
> > > That selects USE_OF which on its turn selects OF.
> > > 
> > > So, HISI_MBOX implies OF, correct?
> > 
> > Exactly, will simply use "depends on ARCH_HISI".
> 
> That change would alter the dependencies. My remark was made just to
> make clear why I think CONFIG_OF will always be defined. But now I guess
> you actually meant
> 	depends on ARCH_HISI && OF

Correct, shame for my wrong logic :)

> And that would, I think, indeed be equivalent to
> 	depends on ARCH_HISI

Thanks,
Leo Yan
