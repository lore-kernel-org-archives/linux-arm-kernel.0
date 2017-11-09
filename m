From: bp@alien8.de (Borislav Petkov)
Date: Thu, 9 Nov 2017 13:12:26 +0100
Subject: [PATCH 2/3] EDAC: ti: add support for TI keystone and DRA7xx EDAC
In-Reply-To: <5e88e7bb-911d-a157-ac1f-2b5cc9b0a554@ti.com>
References: <1510087139-21885-1-git-send-email-t-kristo@ti.com>
 <1510087139-21885-3-git-send-email-t-kristo@ti.com>
 <20171109101417.rtz6ojhfcml3f6l7@pd.tnic>
 <5e88e7bb-911d-a157-ac1f-2b5cc9b0a554@ti.com>
Message-ID: <20171109121226.d63muafsaip74mvh@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 12:38:02PM +0200, Tero Kristo wrote:
> Yeah, the DRA7 SoCs have 2x emif instances, and ECC is only available on one
> (and it can be either enabled or disabled.) I thought it might be useful to
> have the dimm info populated for both in this case to avoid confusion and to
> be able to see the status from userspace.
> 
> It is also possible to ditch that and only have dimm info for instances
> which have ECC enabled. Which way would you prefer?

Actually, having all DIMMs present, even if ECC is not enabled for a
subset of them, would make the picture more user-friendly. Yap, that's better.

> Thanks for review, and sorry again for missing the checkpatch.

No worries, that's what review is for. :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
