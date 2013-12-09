From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 9 Dec 2013 23:45:13 +0800
Subject: [linux-sunxi] Re: [PATCH 04/10] net: stmmac: sunxi platfrom
 extensions for GMAC in Allwinner A20 SoC's
In-Reply-To: <52A5C950.7070903@cogentembedded.com>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-5-git-send-email-wens@csie.org> <52A5A7B2.4000509@st.com>
 <52A5C950.7070903@cogentembedded.com>
Message-ID: <CAGb2v65T4jqvrW=ZX3fcEm22rU0DEgsRJ2NtXDQ2406Ou5G9MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 9, 2013 at 9:44 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 09-12-2013 15:21, srinivas kandagatla wrote:
>
>>> +static int sun7i_gmac_init(struct platform_device *pdev)
>>> +{
>>> +       struct resource *res;
>>> +       struct device *dev = &pdev->dev;
>>> +       void __iomem *addr = NULL;
>>> +       struct plat_stmmacenet_data *plat_dat = NULL;
>
>
>    No need to initialize it since you're assigning to it right below.
>
>
>>> +       u32 priv_clk_reg;
>>> +
>>> +       plat_dat = dev_get_platdata(&pdev->dev);
>>> +       if (!plat_dat)
>>> +               return -EINVAL;
>
>
>> dev_get_platdata will return NULL for DT, So this function will fail all
>> the time.
>
>
>    Indeed, unless the probe() method assigns it from the 'data' field of
> 'struct of_device_id'.
>
>
>> How is it supposed to work?
>> Am I missing some thing?
>
>
>    Look at stmmac_pltfr_probe().

Actually, Srinivas is right.
The platform data assigned from the 'data field' is not the same one as
dev_get_platdata().

This is something I missed when I was reworking the patches.


ChenYu
