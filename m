From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Sat, 22 Sep 2012 10:52:12 -0700
Subject: [PATCH 4/6] staging: drm/imx: Add i.MX IPUv3 crtc support
In-Reply-To: <20120922101727.GG1322@pengutronix.de>
References: <1348214872-28594-1-git-send-email-s.hauer@pengutronix.de>
 <1348214872-28594-5-git-send-email-s.hauer@pengutronix.de>
 <505C94B3.3020308@boundarydevices.com> <20120922101727.GG1322@pengutronix.de>
Message-ID: <505DFACC.7010604@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2012 03:17 AM, Sascha Hauer wrote:
> Hi Eric,
>
> On Fri, Sep 21, 2012 at 09:24:19AM -0700, Eric Nelson wrote:
>> Hi Sascha,
>>
>>
>> But ipu_crtc->imx_crtc gets initialized in this call, and
>> ipu_irq_handler() makes use of it.
>>
>> The U-Boot code doesn't enable interrupts, so it's not acking
>> along the way, and leaves bits set in IPU1_INT_STAT_15.
>>
>> I found that I can get around this in U-Boot by disabling the
>> LCD controller and acking all of the interrupts after disabling
>> the controller, but I haven't yet figured out where to tap into
>> cleanup_before_linux().
>
> Passing over an enabled IPU from the bootloader to the kernel is
> (currently) not a supported usecase, so U-Boot should indeed disable it.
> That said, the kernel driver should make sure the IPU is sufficiently
> configured before the interrupts are enabled, so this seems to be a bug
> that deserves fixing.
>

Thanks Sascha,

Patches for U-Boot are in process.
	http://lists.denx.de/pipermail/u-boot/2012-September/134807.html

Regards,


Eric
