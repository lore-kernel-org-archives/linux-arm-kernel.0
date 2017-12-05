From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 5 Dec 2017 19:01:41 +0200
Subject: [PATCH] ARM: dts: introduce the sama5d2 ptc ek board
In-Reply-To: <20171205142312.21506-1-ludovic.desroches@microchip.com>
References: <20171205142312.21506-1-ludovic.desroches@microchip.com>
Message-ID: <20171205170141.qleqh6rou2ow54je@tarshish.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

On Tue, Dec 05, 2017 at 03:23:12PM +0100, Ludovic Desroches wrote:
> Add the official SAMA5D2 Peripheral Touch Controller Evaluation
> Kit board.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---

[...]

> +	memory {
> +		reg = <0x20000000 0x80000>;
> +	};

The size value is clearly wrong; you surely don't run on 512KB RAM. You most 
likely rely on the bootloader to fix the size value. Since sama5d2.dtsi has a 
memory node already with the same address, you can just drop it from here.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
