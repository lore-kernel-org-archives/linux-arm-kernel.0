From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 6 Jul 2012 14:54:49 +0530
Subject: [PATCH 1/2] ARM: OMAP: board-4430sdp: MUX configuration for
 sys_nirq2
In-Reply-To: <4FF6AE6F.4000808@ti.com>
References: <1341564590-14024-1-git-send-email-peter.ujfalusi@ti.com>
 <CAMQu2gyZQGGVQQtidGwOCux-0hX=FmPVP+9Sej_VRrQMurd=mw@mail.gmail.com>
 <4FF6AE6F.4000808@ti.com>
Message-ID: <CAMQu2gw9ccxk3KL8KUVxnLX8nTsDMSWyokHVMqR8Feo6DyrNWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Russell

On Fri, Jul 6, 2012 at 2:52 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 07/06/2012 11:02 AM, Shilimkar, Santosh wrote:
>> On Fri, Jul 6, 2012 at 2:19 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>> The sys_nirq2 is used for twl6040, make sure the pin is configured
>>> correctly.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>> Should remove the boot-loader pin-muxing dependency.
>> Was this the reason, Audio had some issues on OMAP4430
>> SDP as reported by Russell ?
>
> The boot loader never configured the sys_nirq2, I have sent a patch for u-boot
> to do this, but it is said that the kernel should take care of this.
>
> We did not had jack detection working with upstream u-boot, kernel (I have
> patched u-boot so I have not seen this issue).
> Now if the board is booted without HS connected, upon connecting the HS we
> will recognize it and it should be all fine.
> So yes this was the reason why Russell had issues with audio.
>
Thanks Peter for tracking it down.

Regards
santosh
