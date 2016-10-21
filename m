From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 21 Oct 2016 17:18:01 -0200
Subject: [PATCH v2] ARM: imx: gpc: Initialize all power domains
In-Reply-To: <20161021031116.GG30578@tiger>
References: <1477013309-2808-1-git-send-email-festevam@gmail.com>
 <20161021031116.GG30578@tiger>
Message-ID: <CAOMZO5Cjs5sPTQ4=w-hGS3dQ3LNPRfmbkGk6PTKhJDdXK5UYCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Oct 21, 2016 at 1:11 AM, Shawn Guo <shawnguo@kernel.org> wrote:

> Thanks for the update.  Now we understand that this is a regression
> caused by power domain core change.  But my question on why kernel
> crashes with multi_v7_defconfig but not with imx_v6_v7_defconfig stays
> unanswered.

imx_v6_v7_defconfig selects GPU and VPU drivers, which are consumers
of the GPC driver and change the refcount of the pu_reg regulator.

I think we should not continue to boot in case imx_gpc_probe() fails.

So I will send a patch series with this patch and another one that
prevents the boot when  imx_gpc_probe() fails.
