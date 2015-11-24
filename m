From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Nov 2015 07:25:13 -0200
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: Select HDMI audio support
In-Reply-To: <20151124062004.GJ11999@tiger>
References: <1447687238-11559-1-git-send-email-fabio.estevam@freescale.com>
 <20151124062004.GJ11999@tiger>
Message-ID: <CAOMZO5AwYny8OZCohCP0Zcc+pxyLawwJ=tUJrqsu8ORHSG6u-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 4:20 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Mon, Nov 16, 2015 at 01:20:38PM -0200, Fabio Estevam wrote:
>> Select CONFIG_DRM_DW_HDMI_AHB_AUDIO so that we have HDMI audio
>> supported by default.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> Changes since v1:
>> - Select the driver as module instead of built-in
>
> I've applied a previous version.  Should I replace it with this one?

Yes, please.

The latest version uses module instead of built-in.

Selecting the driver as module is better as it will not impact current
users. For example: currently on a mx6qsabresd when we do 'aplay
file.wav' it will play through the wm8962 card.

If the HDMI audio driver is selected as built-in, then 'aplay
file.wav' will play through the HDMI audio port, which may confuse the
end user.

If we select the HDMI audio driver as module then we keep the original
behaviour.

Thanks
