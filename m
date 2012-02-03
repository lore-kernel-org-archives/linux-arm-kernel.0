From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 2 Feb 2012 22:59:29 -0200
Subject: [PATCH v2 2/2] ARM: mx3: Let mx31 and mx35 enter in LPM mode in
 WFI
In-Reply-To: <20120203005253.GD32403@b20223-02.ap.freescale.net>
References: <1328220152-3037-1-git-send-email-festevam@gmail.com>
 <1328220152-3037-2-git-send-email-festevam@gmail.com>
 <20120203005253.GD32403@b20223-02.ap.freescale.net>
Message-ID: <CAOMZO5AzzaY6GL=TROUfxo=rPpowhBKtvO23cF7QCi7kEPHhGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2012 at 10:52 PM, Richard Zhao
<richard.zhao@freescale.com> wrote:
>> diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
>> index 8404ee7..5f66791 100644
>> --- a/arch/arm/mach-imx/mm-imx3.c
>> +++ b/arch/arm/mach-imx/mm-imx3.c
>> @@ -34,6 +34,7 @@ static void imx3_idle(void)
>> ?{
>> ? ? ? unsigned long reg = 0;
>>
>> + ? ? mx3_cpu_lp_set(MX3_WAIT);
> Isn't it supposed to use cpuidle to level the idle state?

I am doing the same as in mx5. Isn't this ok?

Regards,

Fabio Estevam
