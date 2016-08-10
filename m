From: peter.chen@nxp.com (Peter Chen)
Date: Wed, 10 Aug 2016 01:24:30 +0000
Subject: [PATCH 1/1] ARM: mach-imx: pm-imx6: add missing
 BM_CLPCR_BYP_MMDC_CH0_LPM_HS setting for imx6ul
In-Reply-To: <CAOMZO5AEHQjzP7=pTK3b2J+BSzcdXm=7aPNuv_sf0_8j8EAyJg@mail.gmail.com>
References: <1470731083-26213-1-git-send-email-peter.chen@nxp.com>
 <CAOMZO5AEHQjzP7=pTK3b2J+BSzcdXm=7aPNuv_sf0_8j8EAyJg@mail.gmail.com>
Message-ID: <HE1PR04MB1450F448E7C5FC7F3575694A8B1D0@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>
>On Tue, Aug 9, 2016 at 5:24 AM, Peter Chen <peter.chen@nxp.com> wrote:
>> There is a missing BM_CLPCR_BYP_MMDC_CH0_LPM_HS setting for imx6ul,
>> without it, the "standby" mode can't work well, the system can't be
>> resumed.
>>
>> With this commit, the "standby" mode works well.
>
>Have you tested 'echo mem > /sys/power/state' as well?
>
>On my tests it does a reboot rather than going to suspend.
>

It is another issue, current both 6sx and 6ul can't work for mem mode.
But I just can't wake up system, reboot is not observed.

Peter
