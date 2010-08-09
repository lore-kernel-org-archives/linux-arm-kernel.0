From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Mon, 09 Aug 2010 20:38:14 +0200
Subject: [RFC] SDMA support for i.MX
In-Reply-To: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4C604B16.7000309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 2010-08-09 11:05, Sascha Hauer wrote:
> Hi all,
> 
> Ever wondered what's hidden behind the tons of SDMA/iapi stuff in the
> Freescale kernel? It's a nice and convenient to use DMA engine. The
> following patches add support for it.


Nice!

> git://git.pengutronix.de/git/imx/sdma-firmware.git
> 
> As the layout of the firmware is not given by fsl but by me it should
> be part of the review.

I don't have any comments on the layout but some general comments on files in sdma-firmware.git:

Some files are missing copyright and license information.

Shouldn't the gen_one() function do a free(name) also when everything is successfull? I.e. before return 0.
Also, in case of errors after line 67, fclose(f) should be called.


Regards, Magnus
