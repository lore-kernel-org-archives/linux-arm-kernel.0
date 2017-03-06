From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Mon, 6 Mar 2017 17:58:14 +0000
Subject: [PATCH v6 4/4] drm/rockchip: Implement CRC debugfs API
In-Reply-To: <20170303133936.14964-5-tomeu.vizoso@collabora.com>
References: <20170303133936.14964-1-tomeu.vizoso@collabora.com>
 <20170303133936.14964-5-tomeu.vizoso@collabora.com>
Message-ID: <CACvgo50hmYjTe=jvet5miv3UTk8eM5XF8qatG3Uq_LTdsO5GYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu,

Pardon for dropping in late.

On 3 March 2017 at 13:39, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> Implement the .set_crc_source() callback and call the DP helpers
> accordingly to start and stop CRC capture.
>
> This is only done if this CRTC is currently using the eDP connector.
>
> v3: Remove superfluous check on rockchip_crtc_state->output_type
>
> v6: Remove superfluous variable
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 41 +++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
I think this won't fly (build).

Afaict analogix_dp-rockchip.c (as guarded by ROCKCHIP_ANALOGIX_DP) is
the only piece that can/should have DRM_ANALOGIX_DP code. Perhaps
adding a simple wrapper/stubs will be the easier option here ?

-Emil
