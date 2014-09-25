From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 25 Sep 2014 10:15:49 +0800
Subject: [PATCH v2 1/5] pinctrl: imx: detect uninitialized pins
In-Reply-To: <6d676a88eb82a47f8fa9e16abbc768e3e9ac236a.1411492954.git.stefan@agner.ch>
References: <cover.1411492954.git.stefan@agner.ch>
 <6d676a88eb82a47f8fa9e16abbc768e3e9ac236a.1411492954.git.stefan@agner.ch>
Message-ID: <20140925021547.GA6405@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 07:37:53PM +0200, Stefan Agner wrote:
> The pinctrl driver initialized the register offsets for the pins
> with 0. On Vybrid an offset of 0 is a valid offset for the pinctrl
> mux register. So far, this was solved using the ZERO_OFFSET_VALID
> flag which allowed offsets of 0. However, this does not allow to
> verify whether a pins struct imx_pmx_func was initialized or not.
> 
> Use signed offset values for register offsets and initialize those
> with -1 in order to detect uninitialized offset values reliable.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Shawn Guo <shawn.guo@freescale.com>
