From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 31 Aug 2011 19:04:21 +0800
Subject: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
	platforms
In-Reply-To: <87k49t99u4.fsf@lebrac.rtp-net.org>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
	<1314762635-3923-2-git-send-email-richard.zhu@linaro.org>
	<87k49t99u4.fsf@lebrac.rtp-net.org>
Message-ID: <27DACB75-EF61-4A32-B11C-E1044B0FB0B2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

You can just use Linus tree v3.1-rc4 as the base for this.

Sent from my iPhone

On Aug 31, 2011, at 6:03 PM, Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> wrote:

> Richard Zhu <richard.zhu@linaro.org> writes:
> Hi,
> 
> 
>> @@ -1503,6 +1519,9 @@ static struct clk_lookup mx53_lookups[] = {
>>    _REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
>>    _REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
>>    _REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
>> +    _REGISTER_CLOCK("imx53-ahci.0", "ahci", sata_clk)
>> +    _REGISTER_CLOCK("imx53-ahci.0", "ahci_phy", ahci_phy_clk)
>> +    _REGISTER_CLOCK("imx53-ahci.0", "ahci_dma", ahci_dma_clk)
>> };
>> 
>> static void clk_tree_init(void)
> 
> Which tree has been used for this patch ? For instance, on current
> imx-features branch of Sascha's tree, there's a pata_imx clock defined
> here (see [1]). Should I try to apply it on top of some other branch ?
> 
> Arnaud
> 
> [1] http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=03b20b07be130e44faf29f787c66ce5cce5afb2a
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
