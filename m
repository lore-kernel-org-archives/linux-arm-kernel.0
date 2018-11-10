From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 10 Nov 2018 18:54:42 +0100
Subject: linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576: possible cut'n'paste
 error
In-Reply-To: <20181106163724.GK30658@n2100.armlinux.org.uk> (Russell King's
 message of "Tue, 6 Nov 2018 16:37:24 +0000")
References: <VI1PR08MB3342D4ADBFBC43F2BE2FD34D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <VI1PR08MB33420789A2AA1096D3F5FC9D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <20181106162014.GH30658@n2100.armlinux.org.uk>
 <VI1PR08MB33427CD1C653245DBB979B9B9CCB0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <20181106163724.GK30658@n2100.armlinux.org.uk>
Message-ID: <87r2fslswt.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

>> Interestingly, more of the same in file linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c
>> 
>> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:84]: (warning) Redundant assignment of 'ASCR' to itself.
>> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:85]: (warning) Redundant assignment of 'ARSR' to itself.
>> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:120]: (warning) Redundant assignment of 'ASCR' to itself.
>> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:121]: (warning) Redundant assignment of 'ARSR' to itself.
>> 
>> I don't know if these four are also worth fixing.
>
> There are cases where this can be false positives.  In the case of a
> status register with write-1-to-clear bits for example.  These ones
> look very much like that.
And indeed they are, for bits 2,1,0 for ASCR and 3,2,1,0 for ARSR, and you
guessed correctly they are partly status registers.

If only your checker could filter out __iomem tagged pointers, you could have
far less of these false positives ...

Cheers.

-- 
Robert
