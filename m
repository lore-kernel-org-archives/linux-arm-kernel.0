From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Mon, 30 Jan 2017 08:44:04 +0100
Subject: [PATCH v2 1/2] nvmem: sunxi-sid: add support for H3 and A64's
 SID controller
In-Reply-To: <20170129015641.54281-1-icenowy@aosc.xyz>
References: <20170129015641.54281-1-icenowy@aosc.xyz>
Message-ID: <20170130074404.d7mi6h4kviornr5s@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 09:56:40AM +0800, Icenowy Zheng wrote:
> H3 and A64 SoCs have a bigger SID controller, which has its direct read
> address at 0x200 position in the SID block, not 0x0.
> 
> Also, H3 SID controller has some silicon bug that makes the direct read
> value wrong at first, add code to workaround the bug. (This bug has
> already been fixed on A64 and later SoCs)
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Please split that into several patches. One to allow to set the size
through the structure, one to support the A64, and one to support the
H3.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/9082dc3f/attachment.sig>
