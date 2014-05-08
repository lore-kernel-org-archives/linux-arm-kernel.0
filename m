From: ipaton0@gmail.com (Iain Paton)
Date: Thu, 08 May 2014 10:10:39 +0100
Subject: [RFC PATCH] ARM: dts: imx6: add new board RIoTboard
In-Reply-To: <CAOMZO5C=Yph-Rtor1v_PpPw68J=GwozWW6=mPux2d3f97mi3+g@mail.gmail.com>
References: <53695C34.5000604@gmail.com>
 <CAOMZO5C=Yph-Rtor1v_PpPw68J=GwozWW6=mPux2d3f97mi3+g@mail.gmail.com>
Message-ID: <536B4A0F.709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/14 03:27, Fabio Estevam wrote:
> On Tue, May 6, 2014 at 7:03 PM, Iain Paton <ipaton0@gmail.com> wrote:
> 

Fabio, I'll address all your comments and resend. Thanks for reviewing!

>> +
>> +               pinctrl_usdhc4: usdhc4grp {
>> +                       fsl,pins = <
>> +                               MX6QDL_PAD_SD4_CMD__SD4_CMD             0x17059
>> +                               MX6QDL_PAD_SD4_CLK__SD4_CLK             0x10059
>> +                               MX6QDL_PAD_SD4_DAT0__SD4_DATA0          0x17059
>> +                               MX6QDL_PAD_SD4_DAT1__SD4_DATA1          0x17059
>> +                               MX6QDL_PAD_SD4_DAT2__SD4_DATA2          0x17059
>> +                               MX6QDL_PAD_SD4_DAT3__SD4_DATA3          0x17059
>> +                               MX6QDL_PAD_NANDF_ALE__GPIO6_IO08        0x80000000      /* SD4 RST (eMMC) */
> 
> Just curious: do you get eMMC working? I tried it on mx6qsabresd and
> it is not working for me.

Yes, it works on the RIoTboard.

The other element14/embest design, MarSboard uses an i.MX6 Dual, has it's
eMMC on usdhc3 instead of 4 and I've been completely unsuccessful getting it
to work, have tried most combination of pad settings.

Different vendor of eMMC on the MarS from the RIoTboard. 

What's interesting is that on MarS the eMMC works in u-boot with the same pad 
settings and the MarS eMMC does appear to work in the 3.0.35 BSP, so perhaps it's
something in the mmc layer.

I have a note to have a look at http://article.gmane.org/gmane.linux.kernel.mmc/26407
since what Markus reports seeing on RIoT looks very similar to what I see on MarS.

Unfortunately I haven't had time to investigate further.

Iain
