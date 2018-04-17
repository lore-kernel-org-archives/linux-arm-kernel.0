From: olivier.moysan@st.com (Olivier MOYSAN)
Date: Tue, 17 Apr 2018 08:29:17 +0000
Subject: [PATCH 0/3] ASoC: stm32: sai: add support of iec958 controls
In-Reply-To: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
Message-ID: <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I guess the blocking patch in this patchset is the patch "add IEC958 
channel status control helper". This patch has been reviewed several 
times, but did not get a ack so far.
If you think these helpers will not be merged, I will reintegrate the 
corresponding code in stm driver.
Please let me know, if I need to prepare a v2 without helpers, or if we 
can go further in the review of iec helpers patch ?

Best regards
olivier


On 03/13/2018 05:27 PM, Olivier Moysan wrote:
> This patchset adds support of iec958 controls to STM32 SAI driver.
> 
> The patch makes use of iec958 control status helpers previously proposed
> and discussed through the following threads:
> https://patchwork.kernel.org/patch/8062601/
> https://patchwork.kernel.org/patch/8091551/ (v2)
> https://patchwork.kernel.org/patch/8462961/ (v3)
> https://patchwork.kernel.org/patch/8533731/ (v4)
> 
> Olivier Moysan (3):
>    ALSA: pcm: add IEC958 channel status control helper
>    ASoC: stm32: sai: add iec958 controls support
>    ASoC: dmaengine_pcm: document process callback
> 
>   include/sound/dmaengine_pcm.h |   2 +
>   include/sound/pcm_iec958.h    |  19 +++++++
>   sound/core/pcm_iec958.c       | 114 ++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/stm/Kconfig         |   1 +
>   sound/soc/stm/stm32_sai_sub.c | 101 ++++++++++++++++++++++++++++++++-----
>   5 files changed, 225 insertions(+), 12 deletions(-)
> 
