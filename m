From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 21 Dec 2011 09:48:24 +0800
Subject: [PATCH v4 2/4] ARM: pxa168: Add SDHCI support
In-Reply-To: <20111220210324.GD2577@n2100.arm.linux.org.uk>
References: <CAN1soZxZjdzivfttUhDDvjUDiyiAC5SSKtB0rXR1D=3=q6O0wQ@mail.gmail.com>
 <1324386781-25271-1-git-send-email-tanmay.upadhyay@einfochips.com>
 <20111220210324.GD2577@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZwwPe1Xdh=EO-wdynihaBQ8DvWV=imjokJvDZVC+qqdSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 5:03 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Just two minor style issues in this patch.
>
> On Tue, Dec 20, 2011 at 06:43:01PM +0530, Tanmay Upadhyay wrote:
>> +static inline int pxa168_add_sdh(int id, struct sdhci_pxa_platdata *data)
>> +{
>> + ? ? struct pxa_device_desc *d = NULL;
>> +
>> + ? ? switch (id) {
>> + ? ? case 1: d = &pxa168_device_sdh1; break;
>> + ? ? case 2: d = &pxa168_device_sdh2; break;
>> + ? ? case 3: d = &pxa168_device_sdh3; break;
>> + ? ? case 4: d = &pxa168_device_sdh4; break;
>
> Style.
> ? ? ? ?case X:
> ? ? ? ? ? ? ? ?d = &y;
> ? ? ? ? ? ? ? ?break;
>
>> +static void sdh_clk_disable(struct clk *clk)
>> +{
>> + ? ? __raw_writel(__raw_readl(clk->clk_rst) & ~(clk->enable_val),
>
> Parens around clk->enable_val not required.
>
>> + ? ? INIT_CLKREG(&clk_sdh1, NULL, "PXA-SDHCLK"),
>> + ? ? INIT_CLKREG(&clk_sdh2, NULL, "PXA-SDHCLK"),
>> + ? ? INIT_CLKREG(&clk_sdh3, NULL, "PXA-SDHCLK"),
>> + ? ? INIT_CLKREG(&clk_sdh4, NULL, "PXA-SDHCLK"),
>
> So these clocks are registered with the same name? ?How are they
> distinguished by clk_get()?
>

Yes, it's better to use devname.
