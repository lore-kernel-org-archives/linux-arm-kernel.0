From: fan.chen@mediatek.com (Fan Chen)
Date: Fri, 3 Jun 2016 13:42:08 +0800
Subject: [PATCH v2 1/3] regulator: DT: Add DT property for operation
 mode configuration
In-Reply-To: <20160603001600.GX2282@sirena.org.uk>
References: <1463987611-32139-1-git-send-email-henryc.chen@mediatek.com>
 <1463987611-32139-2-git-send-email-henryc.chen@mediatek.com>
 <20160523104703.GB26992@leverpostej> <20160523112856.GR8206@sirena.org.uk>
 <1464682835.25847.3.camel@mtksdaap41> <20160603001600.GX2282@sirena.org.uk>
Message-ID: <1464932528.18889.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, 2016-06-03 at 01:16 +0100, Mark Brown wrote:
> On Tue, May 31, 2016 at 04:20:35PM +0800, Fan Chen wrote:
> > On Mon, 2016-05-23 at 12:28 +0100, Mark Brown wrote:

> > In the case of svs[1], which Henry mentioned in cover letter, it can be
> > regarded as a special consumer who requires very accurate voltage for
> > calibration the hardware in its initialization stage. So, this kinds of
> > consumers know their regulator very well and only need to switch to the
> > modes they want in the particular conditions.
> 
> So what you're trying to do here is not so much set a specific mode as
> set maximum regulation accuracy for a period of time.

exactly.

> > However, IIUC, you want a proposal to provide a sort of QoS framework
> > which can cover most of use cases who care about the regular quality in
> > runtime, is that correct?
> 
> Well, we want a coherent general use case that doesn't require a user to
> know the specific details of the regulator they're working with since we
> need to hide that knowledge from the user.

Agreed, it is hard to control once expose too many details. But I think
maybe there still be some parameter user has to aware to decide the
performance/quality in the common use cases you said below.

> 
> > IMHO, some quality index can be considered, for example:
> > Minimum Current Requirement (mA): If a user specified this constraint in
> > runtime, it means that he cares more about the supplying quality like
> > transient voltage drop, ripple above certain load.
> > Maximum Current Requirement (mA): If a user specified this constraint in
> > runtime, it means that he cares more about the power consumption under
> > certain load.
> > It could be a flexible way instead to tie the operation modes directly.
> 
> I'm not sure I really understand these distinctions to be honest,
> and specifying minimum loads seems very tricky from a robustness point
> of view.
> 
> If all you need right now is a way to maximize regulation quality that's
> probably a lot easier than anything based on absolute loads or on
> multiple "normal operation" modes - it takes a lot of the complexity out
> of things as there's no need to consider things like the distinctions
> between modes.  We just need a standard operating mode and to know the
> highest available mode.  I'm not sure exactly how to do that as an API
> though, let me think about it...  your use case isn't one I'd come
> across before.
Thanks. Please kindly give us suggestion for this case.
> 
> > BTW, we should encourage people here to share more use cases related to
> > regulator quality issues, especially in runtime, so we can evaluate the
> > most suitable index to fit the requirements.
> 
> More common use cases are around manually doing adaptive mode switching
> for regulators that are poor at automatically adjusting performance and
> handling of very low standby current situations where the adaption can
> consume enough power to register.

Best regards,
Fan
