From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Jan 2014 21:19:41 -0800
Subject: AArch64 kernel image decompression
In-Reply-To: <e79fa209ffc4485d8cae87bae3daa656@BN1PR03MB220.namprd03.prod.outlook.com>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <20140113111733.GD1189@mudshark.cambridge.arm.com>
 <69dfcb9d142443638e4ccfedd92c4f05@BN1PR03MB220.namprd03.prod.outlook.com>
 <4250104.UfkPP3heXI@wuerfel>
 <e79fa209ffc4485d8cae87bae3daa656@BN1PR03MB220.namprd03.prod.outlook.com>
Message-ID: <CAOesGMi_QY6z_3QSdAs-3JaEUufgymJg=kiqpb9D6RNNjZF5sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 7:52 PM, bhupesh.sharma at freescale.com
<bhupesh.sharma@freescale.com> wrote:

> AFAIK, u-boot requires a u-boot specific header (see [1]) on top of any image it wants to
> boot - whether it's a uncompressed vmlinux or a compressed vmlinux.gz
>
> In the ARM32 code base we had the Makefile rule to generate a uImage automatically (see [2]), with ARM64
> now, I am forced to compress the vmlinux and put a u-boot header on top of it using 'mkimage' and then
> feed the 'uImage' thus generated to the u-boot.
>
> So, it would be good if the ARM64 Makefile can mimic the ARM32 one in this aspect - now that we have
> a working u-boot capable of booting vanilla linux on an ARMv8 foundation model.

No, there should be no uImage target on arm64. Newer u-boots can
already boot an ARM zImage (through the bootz command), and should be
enhanced as needed to boot a vmlinux if needed.

Bringing in uImage as a target on ARM might have been a mistake, since
now people want to bring in new targets for whatever boot format they
happen to want. So it's a good idea to keep arm64 from going down the
same path and stick to the native, raw, formats.


-Olof
