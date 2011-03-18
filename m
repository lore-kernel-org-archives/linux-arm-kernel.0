From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Fri, 18 Mar 2011 15:34:51 +0000
Subject: [PATCHv4 2/3] ARM: mx51: Implement code to allow mx51 to enter WFI
In-Reply-To: <AANLkTimg6uc9cq53e54BqLsRzPXH1DNBF9cThHavdJs=@mail.gmail.com>
References: <1300461684-21775-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1300461684-21775-2-git-send-email-Dinh.Nguyen@freescale.com>
	<AANLkTimg6uc9cq53e54BqLsRzPXH1DNBF9cThHavdJs=@mail.gmail.com>
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA1B9CD9@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

>-----Original Message-----
>From: Fabio Estevam [mailto:festevam at gmail.com]
>Sent: Friday, March 18, 2011 10:31 AM
>To: Nguyen Dinh-R00091
>Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>linux at arm.linux.org.uk; s.hauer at pengutronix.de; u.kleine-
>koenig at pengutronix.de; arnaud.patard at rtp-net.org; Vaidyanathan Ranjani-
>RA5478; Zhang Lily-R58066
>Subject: Re: [PATCHv4 2/3] ARM: mx51: Implement code to allow mx51 to
>enter WFI
>
>Hi Dinh,
>
>On Fri, Mar 18, 2011 at 12:21 PM,  <Dinh.Nguyen@freescale.com> wrote:
>...
>> + ? ? ? /* Enable NEON SRPG for all but MX50TO1.0. */
>> + ? ? ? if (cpu_is_mx51() || cpu_is_mx53())
>> + ? ? ? ? ? ? ? __raw_writel(arm_srpgcr, MXC_SRPG_NEON_SRPGCR);
>
>The comment says that NEON SRPG should not be enabled for MX50 TO1.0,
>but your code does not check the MX50 silicon revision.

There is no mechanism for checking MX50 Revisions yet. I'll work on adding the MX50 revision check.

Dinh
>
>Regards,
>
>Fabio Estevam
