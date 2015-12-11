From: liam.r.girdwood@linux.intel.com (Liam Girdwood)
Date: Fri, 11 Dec 2015 19:09:26 +0000
Subject: [RFC PATCH] ASoC: dpcm: Apply symmetry for DPCM
In-Reply-To: <1449804831-58929-1-git-send-email-koro.chen@mediatek.com>
References: <1449804831-58929-1-git-send-email-koro.chen@mediatek.com>
Message-ID: <1449860966.2499.17.camel@loki>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-12-11 at 11:33 +0800, Koro Chen wrote:
> From: PC Liao <pc.liao@mediatek.com>
> 
> DPCM does not fully support symmetry attributes. soc_pcm_apply_symmetry()
> is skipped in soc_pcm_open() for DPCM, without being applied elsewhere.
> So HW parameters cannot be correctly limited, and user space can do
> playback/capture at different rates while HW actually does not support it.
> soc_pcm_params_symmetry() will return error and the second stream stops.
> 
> This patch adds soc_pcm_apply_symmetry() for FE, BE, and codec DAIs
> in DPCM path that was skipped in soc_pcm_open().
> 
> Signed-off-by: PC Liao <pc.liao@mediatek.com>
> Signed-off-by: Koro Chen <koro.chen@mediatek.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
