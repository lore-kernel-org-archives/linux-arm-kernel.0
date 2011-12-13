From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 Dec 2011 21:33:50 +0800
Subject: [PATCH V2 2/7] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <20111213125353.GB1757@richard-laptop>
References: <1323757530-19402-1-git-send-email-richard.zhao@linaro.org>
 <1323757530-19402-3-git-send-email-richard.zhao@linaro.org>
 <20111213115648.GA10022@S2101-09.ap.freescale.net>
 <20111213125353.GB1757@richard-laptop>
Message-ID: <20111213133348.GA14688@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 08:54:01PM +0800, Richard Zhao wrote:
> > > +	cpus {
> > > +		cpu at 0 {
> > > +			clock-frequency = <996000000>;
> > > +		};
> > 
> > I do not follow why we need to have cpu frequency encoded in board
> > level dts.  To me, what frequency the cpu is capable of running at
> > is really soc specific thing.  So putting this data in
> > imx6q-sabrelite.dts is kinda suggesting that imx6q soc on this
> > sabrelite board can run at 996000000, while on other boards like
> > sabreauto/arm2 can only run at other frequency.  This is seems different
> > from what I heard from Freescale internal development team.
> 1G operation needs a certain external voltage condition, though we have
> internal regulater. Boards that don't meet the condition have to fall back
> to lower frequency.
> From software side view, I refer to Freescale software release. please see
> http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=blob;f=arch/arm/mach-mx6/cpu_op-mx6.c;h=30a4346282ea5c332b4c48bf6a2d644abd9f31db;hb=imx_2.6.38_11.11.01
> 
> and for imx53, there' also different max freq board:
> http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=blob;f=arch/arm/mach-mx5/mx53_wp.c;h=a63bae42fb661c161cab99d61f4a3108305b0f55;hb=refs/heads/imx_2.6.35_11.09.01
> 
> IMHO, even the board has limitations, we'd better give an option to support
> it if it's possible.
> 
I understand all these things.  What I was suggesting is this option
should not be provided by the dts at all.  For example, you have one
sabrelite that can provide voltage for imx6q to run at 1GHz, while
I have another sabrelite board which can only provide voltage for imx6q
to run at 800MHz.  With your patches accepted, the same mainline
kernel/dtb will work on your sabrelite board while will not on mine.
Since both of us are running sabrelite board, how do I should know I
need to change the clock-frequency in imx6q-sabreauto.dts for my
sabrelite board?

-- 
Regards,
Shawn
