From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jul 2010 08:44:49 +0100
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
	<20100710071913.GM22845@n2100.arm.linux.org.uk>
	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
Message-ID: <20100713074449.GA20118@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 10, 2010 at 05:36:54PM +0200, Linus Walleij wrote:
> 2010/7/10 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > Correct, which is what drivers currently expect. ?This is also why
> > two additional amba_* callbacks are supplied - if it is appropriate
> > for a driver to disable their bus clock after being probed, they can
> > do that but they have to participate in that.
> 
> Aha I get it, then it looks good...

Is that an Ack for the patch?

I think there's one change I'd like, which is to change "busck" to
"apb_pclk" to make it clear what it's referring to.

Also, is there any chance you can convert your platform(s) over to use
it before I merge this patch?
