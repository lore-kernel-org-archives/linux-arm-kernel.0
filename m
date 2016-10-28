From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 28 Oct 2016 11:13:16 -0700
Subject: [PATCH v3 1/2] clk: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <CAOMZO5Co32XUpNFz4Hd2DEmNnMBvD5fKmsyjcmsgawea4dJR9g@mail.gmail.com>
References: <cover.1476267249.git.emil@limesaudio.com>
 <4d2e3a91dfb74209735c940b51d7efc9ba2ed69b.1476267249.git.emil@limesaudio.com>
 <20161028014127.GD16026@codeaurora.org>
 <CAOMZO5Co32XUpNFz4Hd2DEmNnMBvD5fKmsyjcmsgawea4dJR9g@mail.gmail.com>
Message-ID: <20161028181316.GI16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28, Fabio Estevam wrote:
> On Thu, Oct 27, 2016 at 11:41 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 10/12, Emil Lundmark wrote:
> >> Since 'parent_rate * mfn' may overflow 32 bits, the result should be
> >> stored using 64 bits.
> >>
> >> The problem was discovered when trying to set the rate of the audio PLL
> >> (pll4_post_div) on an i.MX6Q. The desired rate was 196.608 MHz, but
> >> the actual rate returned was 192.000570 MHz. The round rate function should
> >> have been able to return 196.608 MHz, i.e., the desired rate.
> >>
> >> Fixes: ba7f4f557eb6 ("clk: imx: correct AV PLL rate formula")
> >> Cc: Anson Huang <b20788@freescale.com>
> >> Signed-off-by: Emil Lundmark <emil@limesaudio.com>
> >> ---
> >
> > Applied to clk-next
> 
> This one fixes a regression caused by ba7f4f557eb6 ("clk: imx: correct
> AV PLL rate formula").
> 
> So it should go to clk-fixes instead with the stable tag:
> 
> Cc: <stable@vger.kernel.org> # 4.8.x
> 

The clk-fixes branch is for patches that fix problems in code
merged during the merge window as well as small one-liners and
things that are causing great pain for people on the latest
release. Given that this fixes a regression in v4.8 and we're
trying to stabilize v4.9 it looked like it could wait until
v4.10.

So is there something going on here where the pain is too much to
wait for the next merge window? If so the commit text should
mention something about what's causing that pain. Perhaps by
referencing the commit that merged outside of clk tree that
caused problems.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
