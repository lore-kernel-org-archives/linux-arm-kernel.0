From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 31 Oct 2018 10:46:52 +0000
Subject: [PATCH v4 2/4] crypto: mxs-dcp - Add support for dcp clk
References: <cover.1539779579.git.leonard.crestez@nxp.com>
 <95dce7010676581691b1ac9906e9298470e0aa1a.1539779579.git.leonard.crestez@nxp.com>
 <CAOMZO5BMeHjsyZWhUb5RmEBRCYViUN-Vx8KyLBWtDJGKBHHpCg@mail.gmail.com>
 <a97517bf72f649915bccf555ab7d3c8c4551298d.camel@nxp.com>
 <CAOMZO5DCzM_NnqD4tHTAn4pAaUdQGo38Ami1h3pu9SzgyQ7GnQ@mail.gmail.com>
Message-ID: <AM0PR04MB4290A361A92B782DC5A9F8BDEECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2018 4:02 PM, Fabio Estevam wrote:
> On Wed, Oct 17, 2018 at 9:59 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> 
>> There is a changelog in the cover letter.
> 
> It did not show up:
> https://lkml.org/lkml/2018/10/17/673

Sorry, I forgot to copy the changelog for v4. The only change is the one 
we discussed earlier in this thread.

>> This only looks slightly odd in git diff but it's not unrelated.
>>
>> I placed clk get/prepare/enable just before stmp_reset_block and made
>> stmp_reset_block print a message and goto err_disable_unprepare_clk on
>> failure instead of just "if (ret) return ret;"
> 
> Got it! Then it looks fine, thanks:
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks for looking at this series.

Shawn already applied patches 3/4, I guess parts 1/2 should go through 
the crypto tree? I don't know how crypto treats patches in the merge 
window, I can resend with all the ack/review tags after rc1 is out.
