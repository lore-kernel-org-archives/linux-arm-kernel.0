From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Jul 2014 21:41:18 +0200
Subject: [PATCH RFC] arm/mach-imximx/iomux-v3: Do not export symbol
 without public declaration
In-Reply-To: <1406120520-14390-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1406120520-14390-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <201407232141.18946.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 July 2014, Alexander Stein wrote:
> Both mxc_iomux_v3_setup_pad and mxc_iomux_v3_setup_multiple_pads are
> declared in iomux-v3.h which can't be used in any module. None of the
> objects in this directory is tristate. Neither can the header be included
> in out-of-tree modules.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Makese sense, but I think if you do this, it would be reasonable
to do the same for all three iomux implementations (v1, imx31, v3).

	Arnd
