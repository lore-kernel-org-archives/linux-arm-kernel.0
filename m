From: bp@alien8.de (Borislav Petkov)
Date: Mon, 5 Jan 2015 11:15:46 +0100
Subject: [PATCH v7] edac: synps: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <CAGnW=BbrpMoMGSVmFXUAYsnyOPGpkz=HbL6mRzB7PqRhbq5HTA@mail.gmail.com>
References: <d71411fd1be84d99af5936138cbcc9c7@BL2FFO11FD014.protection.gbl>
 <20150102105008.GA31364@pd.tnic>
 <CAGnW=BbrpMoMGSVmFXUAYsnyOPGpkz=HbL6mRzB7PqRhbq5HTA@mail.gmail.com>
Message-ID: <20150105101546.GA19655@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 03, 2015 at 08:01:29AM +0530, punnaiah choudary kalluri wrote:
> p is pointing to the stack memory.

So you could go and allocate all that memory at driver init time and
reuse it each time you handle an error instead of on the stack. This way
your error handling paths are lean and fast.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
