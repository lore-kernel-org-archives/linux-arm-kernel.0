From: dcb314@hotmail.com (David Binderman)
Date: Tue, 6 Nov 2018 16:33:26 +0000
Subject: linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576: possible cut'n'paste
 error
In-Reply-To: <20181106162014.GH30658@n2100.armlinux.org.uk>
References: <VI1PR08MB3342D4ADBFBC43F2BE2FD34D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <VI1PR08MB33420789A2AA1096D3F5FC9D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>,
 <20181106162014.GH30658@n2100.armlinux.org.uk>
Message-ID: <VI1PR08MB33427CD1C653245DBB979B9B9CCB0@VI1PR08MB3342.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hello there Russell,

> linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576]: (warning) Redundant assignment of >'ufp_exc->fpinst2' to itself.

>Thanks for the report - it most certainly is a bug introduced by
>Julien's patches, but I don't get your warning here.? Which compiler
>produces that warning?

Not a compiler, cppcheck, a static analyser for C and C++ code.

Interestingly, more of the same in file linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c

[linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:84]: (warning) Redundant assignment of 'ASCR' to itself.
[linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:85]: (warning) Redundant assignment of 'ARSR' to itself.
[linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:120]: (warning) Redundant assignment of 'ASCR' to itself.
[linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:121]: (warning) Redundant assignment of 'ARSR' to itself.

I don't know if these four are also worth fixing.

Regards

David Binderman
