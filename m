From: denis@eukrea.com (Denis Carikli)
Date: Wed, 25 Jun 2014 16:21:51 +0200
Subject: [PATCH v3 3/3] ARM: i.MX25 clk: Use of_clk_init() for DT case
In-Reply-To: <CAOMZO5CSARSPA2K94pQc6osC+8-4jPZsYvV2bQybCXCASmohSg@mail.gmail.com>
References: <1403700096-13014-1-git-send-email-denis@eukrea.com>	<1403700096-13014-3-git-send-email-denis@eukrea.com>
 <CAOMZO5CSARSPA2K94pQc6osC+8-4jPZsYvV2bQybCXCASmohSg@mail.gmail.com>
Message-ID: <53AADAFF.2000800@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 04:13 PM, Fabio Estevam wrote:
>
> On Wed, Jun 25, 2014 at 9:41 AM, Denis Carikli <denis@eukrea.com> wrote:
>
>>   int __init mx25_clocks_init(void)
>>   {
>> -       __mx25_clocks_init(24000000);
>> +       void __iomem *ccm;
>> +
>> +       ccm = ioremap(MX25_CRM_BASE_ADDR, SZ_16K);
>
> Shouldn't the ccm base address be retrieved from dt?
Yes, it is.

As I understand it mx25_clocks_init is called only by the boards files 
(mach-eukrea_cpuimx25.c and mach-mx25_3ds.c) while mx25_clocks_init_dt 
is what is used in the case of a DT boot (in imx25-dt.c).

Denis.
