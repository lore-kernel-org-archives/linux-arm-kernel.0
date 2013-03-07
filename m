From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 7 Mar 2013 17:31:23 +0800
Subject: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
In-Reply-To: <20130307091804.GA17833@n2100.arm.linux.org.uk>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
 <20130306171333.GR17833@n2100.arm.linux.org.uk>
 <20130307023316.GA22554@opensource.wolfsonmicro.com>
 <20130307091804.GA17833@n2100.arm.linux.org.uk>
Message-ID: <20130307093117.GB14315@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 09:18:04AM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 07, 2013 at 10:33:19AM +0800, Mark Brown wrote:

> > Could you go into more detail here please?  Looking at the code I'm not
> > seeing any allocations done by the library code at all, the allocations
> > are all done by the individual platform DMA drivers so I don't see
> > anything stopping them doing what they need.

> I don't know what else you require apart from the description above.  Isn't
> it rather obvious that you can't preallocate the ALSA buffer against the
> DMA engine device if you can only obtain the DMA engine device in the open
> function?

The bit I'm missing is why this is particularly hard to change, it
doesn't seem like a massive refactoring and there's not many users.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130307/4c3d78f0/attachment.sig>
