From: lee.jones@linaro.org (Lee Jones)
Date: Sat, 19 May 2012 09:13:47 +0100
Subject: db8500.dtsi: ab8500@5 reg property invalid length
In-Reply-To: <4FB6B522.4050301@wwwdotorg.org>
References: <4FB6B522.4050301@wwwdotorg.org>
Message-ID: <4FB7563B.4020708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for reporting this.

> In commit 3de3d74 "ARM: ux500: Configure the PRCMU Timer for db8500
> based devices in DT", you changed DT node prcmu at 80157000's #size-cells
> from 0 to 1, but didn't adjust the reg property for existing sub-node
> ab8500 at 5.
 >
 > Warning (reg_format): "reg" property in
 > /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes)
 > (#address-cells == 1, #size-cells == 1)
>
> This makes dtc fail to compile snowball.dts:

Not quite. I didn't notice this warning before, but that's all it is. It 
doesn't prevent snowball.dts from being compiled or seem to affect the 
parsing of the DT as far as I can tell.

I will fix the warning though.

 > Also, the indentation of the new subnode
 > prcmu-timer-4 at 80157450 looks wrong.

Yes it is. There is a patch on the MLs at the moment which does some 
format correction and pandas to a new way of representing IRQs for this 
node.

Thanks again Stephen.

Kind regards.
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
