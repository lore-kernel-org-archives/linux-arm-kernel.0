From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 4 Jan 2013 09:29:46 -0200
Subject: [PATCH v2] ARM: mx25pdk: Add device tree support
In-Reply-To: <20130104051304.GA1887@S2101-09.ap.freescale.net>
References: <1357230455-12690-1-git-send-email-fabio.estevam@freescale.com>
 <20130104051304.GA1887@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5BhkM34Pzz28kEzBmpFiDQemOnH9gja89Vh1v=FWs=JkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 4, 2013 at 3:13 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

>> +     model = "Freescale i.MX25 Product Development Kit";
>> +     compatible = "fsl,imx25-pdk", "fsl,imx25";
>> +
>> +     memory {
>> +             reg = <0x80000000 0x4000000>;
>
> Isn't imx25-pdk equipped with a 128 MB DDR?

Production version of the board has 64MB. Check this comment from FSL U-boot:

/* iMX25 V-1.0 has 128MB but V-1.1 has only 64MB */
#ifdef CONFIG_MX25_3DS_V10
#define PHYS_SDRAM_1_SIZE	(128 * 1024 * 1024)
#else
#define PHYS_SDRAM_1_SIZE       (64 * 1024 * 1024)
#endif

Should I use reg = <0x0 0x0>; instead and let the bootloader detect
the RAM size?

Regards,

Fabio Estevam
