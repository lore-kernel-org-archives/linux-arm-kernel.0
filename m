From: bp@alien8.de (Borislav Petkov)
Date: Thu, 10 Apr 2014 11:21:44 +0200
Subject: [RFC PATCH v2] edac: synopsys: Added EDAC support for zynq ddr
 ecc controller
In-Reply-To: <534633C0.9090905@monstr.eu>
References: <1220b715-6fc2-42ed-8393-b9859fc0deb9@TX2EHSMHS021.ehs.local>
 <20140408204047.GQ30077@pd.tnic> <534633C0.9090905@monstr.eu>
Message-ID: <20140410092144.GD29093@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 08:01:36AM +0200, Michal Simek wrote:
> Just add it to Zynq maintainer fragment as we are doing for non
> zynq/xilinx drivers.

Yep, as a file pattern F:

> At least the is the first time when someone saying that only some
> functions should be documented.

I don't see the need to document simple functions which are *obvious*.
But if you want to do that, I'm not going to stop you so be my guest.


> I don't think this is good to do. When we remove this prefix entirely
> it is bigger chance that the same function name will be used by
> another driver. It is not a problem with linking but the same
> functions names will be listed in System.map which will complicate
> debugging.

Ok, fair enough. You probably still want to make them shorter, though,
so that your code doesn't have to be line-broken too much. For example,
since we only load a single edac driver per system, you can shorten the
prefix to "edac_" only.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
