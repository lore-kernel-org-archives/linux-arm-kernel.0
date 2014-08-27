From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 27 Aug 2014 09:33:59 -0700
Subject: [PATCH v2 1/9] of: Add NVIDIA Tegra XUSB mailbox binding
In-Reply-To: <53FB84F7.8030509@wwwdotorg.org>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <1408381705-3623-2-git-send-email-abrestic@chromium.org>
 <53FB84F7.8030509@wwwdotorg.org>
Message-ID: <CAL1qeaEkTPcn2C+KTO539NgAW_9DS0W+D8q5L9GwSwVop9Du0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 11:48 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
>
>> diff --git a/include/dt-bindings/mailbox/tegra-xusb-mailbox.h
>> b/include/dt-bindings/mailbox/tegra-xusb-mailbox.h
>
>
>> +#define TEGRA_XUSB_MBOX_CHAN_HOST      0
>> +#define TEGRA_XUSB_MBOX_CHAN_PHY       1
>
>
> I can't work out how these values relate to hardware at all. Are they in
> fact properties of the particular firmware that's loaded into the XUSB
> module? If so, I don't think the DT should contain these values at all.

Yes this is rather ugly... they're used by software for the demuxing
of messages and don't correspond to actual hardware.

> I wonder if the individual MBOX_CMD_* values from patch 2 are any
> better, although I think those are also defined by the firmware, not the
> hardware?

They are indeed defined by the firmware, so this would become an issue
if the firmware API ever changed.
