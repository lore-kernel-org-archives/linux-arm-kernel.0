From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Tue, 10 Jan 2012 06:43:35 +0000
Subject: How to configure SGTL5000 ASoC as master?
In-Reply-To: <4F0BD878.40508@bluegiga.com>
References: <4F0BD878.40508@bluegiga.com>
Message-ID: <7FE21149F4667147B645348EC605788508AA69@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Lauri Hintsala [mailto:lauri.hintsala at bluegiga.com]
> Sent: Tuesday, January 10, 2012 2:20 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; linux-arm-kernel at lists.infradead.org
> Subject: MXS: How to configure SGTL5000 ASoC as master?
> Importance: High
> 
> Hi,
> 
> SGTL5000 ASoC is hard coded to be slave in sound/soc/mxs/mxs-sgtl5000.c.
Yes, Saif TX can only work on master mode so we simply only support master mode
for both saif rx/tx.

> In our HW design mclk of ASoC is sourced from external oscillator.
> Because of our design ASoC should be configured as master. In that case master
IIRC using external mclk does not mean sgtl5000 has to be master.
And as I said above, saif tx can only be master, that's a hw limitation.

> clock of SAIF should be disabled.
> 
You can leave it there without using it.

> Is there any plan to have configuration for mxs-sgtl5000 driver? What is
> preferred way to solve this issue?
> 
We can extend the mxs-sgtl5000 driver to support external mclk.
(but sgtl5000 as master mode is not supported).
I did not have time to do it recently, also I did not have such board.
If somebody wants to do it I will be happy to review.

> BR,
> Lauri Hintsala
> 
> p.s. I resent this mail because I wasn't subscriber of alsa-devel mailing list.

Regards
Dong Aisheng
