From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 20 May 2017 00:25:49 +0200
Subject: [PATCH v5 0/5] Add ARM Mali Midgard device tree bindings and gpu
 node for rk3288
In-Reply-To: <cover.1493804968.git.guillaume.tucker@collabora.com>
References: <cover.1493804968.git.guillaume.tucker@collabora.com>
Message-ID: <2394922.9rgTI5oGq7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guillaume,

Am Mittwoch, 3. Mai 2017, 10:56:24 CEST schrieb Guillaume Tucker:
> The ARM Mali Midgard GPU kernel driver is only available
> out-of-tree and is not going to be merged in its current form.
> However, it would be useful to have its device tree bindings
> merged.  In particular, this would enable distributions to create
> working driver packages (dkms...) without having to patch the
> kernel.
> 
> The bindings for the earlier Mali Utgard GPU family have already
> been merged, so this is essentially the same scenario but for
> newer GPUs (Mali-T604 ~ Mali-T880).
> 
> This series of patches first imports the bindings from the latest
> driver release with some clean-up then adds a gpu node for the
> rk3288 SoC.  This was successfully tested on Radxa Rock2 Square,
> Firefly, Veyron Minnie and Jerry boards using Mali kernel driver
> r16p0 and r12p0 user-space binary.

as nobody complained anymore, I've applied all patches for 4.13
with the following small changes:
- patch2: node name to
	gpu_opp_table: gpu-opp-table
  from the original
	gpu_opp_table: opp_table0
- patches3-5: moved &gpu{} to its alphabetical correct position
  (below &gmac and above &hdmi)


Heiko
