From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 18 Mar 2011 12:30:55 -0300
Subject: [PATCHv4 2/3] ARM: mx51: Implement code to allow mx51 to enter WFI
In-Reply-To: <1300461684-21775-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1300461684-21775-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1300461684-21775-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <AANLkTimg6uc9cq53e54BqLsRzPXH1DNBF9cThHavdJs=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Fri, Mar 18, 2011 at 12:21 PM,  <Dinh.Nguyen@freescale.com> wrote:
...
> + ? ? ? /* Enable NEON SRPG for all but MX50TO1.0. */
> + ? ? ? if (cpu_is_mx51() || cpu_is_mx53())
> + ? ? ? ? ? ? ? __raw_writel(arm_srpgcr, MXC_SRPG_NEON_SRPGCR);

The comment says that NEON SRPG should not be enabled for MX50 TO1.0,
but your code does not check the MX50 silicon revision.

Regards,

Fabio Estevam
