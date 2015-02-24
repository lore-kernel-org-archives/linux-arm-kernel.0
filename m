From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Feb 2015 12:59:06 +0100
Subject: [PATCH v4 2/8] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <54EC5AB1.5090802@samsung.com>
References: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
 <7412525.l6YnQcTxtg@wuerfel> <54EC5AB1.5090802@samsung.com>
Message-ID: <6850624.bdB2Ab6zJx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 20:04:17 Chanwoo Choi wrote:
> On 02/24/2015 06:48 PM, Arnd Bergmann wrote:
> > On Tuesday 24 February 2015 17:52:01 Chanwoo Choi wrote:
> >>
> >> But, I have a question.
> >> If we put the aliases into the board dts file instaed of SoC dtsi,
> >> each board dts file may use the different alias name about same phandle.
> > 
> > Yes, that is the idea. In particular with the uarts, the intention is
> > that the numbering of the device nodes in /dev is the same that is
> > printed on the board (if any), which may be different from the numbering
> > internal to the SoC.
> 
> I check the uart device with Exynos5433 SoC based on Linux 4.0-rc1
> If some board use the serial_0 and serial_3 as following in board dtsi,
> 
>         &serial_0 {             --> UART 0 device
>                 status = "okay";
>         };
> 
>         &serial_3 {             --> UART 3 device
>                 status = "okay";
>         };
> 
> The serial core driver create the follwoing /dev/ttySACx device node
> by using the number of alias. It maintain the same device number of internel to the SoC.
> 
>         root at localhost:~# ls /dev/ttySAC
>         ttySAC1  ttySAC3  
> 

I'm not completely following. So you have set the serial1 alias to
the &serial_0 device node and serial3 to &serial_3?

Why not use serial0=&serial_0 and serial1=&serial_3? Does the serial0
alias have a special meaning?

	Arnd
