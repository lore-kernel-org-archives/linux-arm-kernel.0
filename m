From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Oct 2016 09:47:15 -0200
Subject: [PATCH v3 1/2] clk: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <20161028014127.GD16026@codeaurora.org>
References: <cover.1476267249.git.emil@limesaudio.com>
 <4d2e3a91dfb74209735c940b51d7efc9ba2ed69b.1476267249.git.emil@limesaudio.com>
 <20161028014127.GD16026@codeaurora.org>
Message-ID: <CAOMZO5Co32XUpNFz4Hd2DEmNnMBvD5fKmsyjcmsgawea4dJR9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Oct 27, 2016 at 11:41 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/12, Emil Lundmark wrote:
>> Since 'parent_rate * mfn' may overflow 32 bits, the result should be
>> stored using 64 bits.
>>
>> The problem was discovered when trying to set the rate of the audio PLL
>> (pll4_post_div) on an i.MX6Q. The desired rate was 196.608 MHz, but
>> the actual rate returned was 192.000570 MHz. The round rate function should
>> have been able to return 196.608 MHz, i.e., the desired rate.
>>
>> Fixes: ba7f4f557eb6 ("clk: imx: correct AV PLL rate formula")
>> Cc: Anson Huang <b20788@freescale.com>
>> Signed-off-by: Emil Lundmark <emil@limesaudio.com>
>> ---
>
> Applied to clk-next

This one fixes a regression caused by ba7f4f557eb6 ("clk: imx: correct
AV PLL rate formula").

So it should go to clk-fixes instead with the stable tag:

Cc: <stable@vger.kernel.org> # 4.8.x

Thanks
