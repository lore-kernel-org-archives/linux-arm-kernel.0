From: info@lategoodbye.de (Stefan Wahren)
Date: Tue, 9 Feb 2016 21:21:15 +0100
Subject: [PATCH 4/4] spi: bcm2835aux: fix CPOL/CPHA setting
In-Reply-To: <1455041435-8015-5-git-send-email-stephanolbrich@gmx.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-5-git-send-email-stephanolbrich@gmx.de>
Message-ID: <56BA4A3B.3090605@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephan,

Am 09.02.2016 um 19:10 schrieb stephanolbrich at gmx.de:
> From: Stephan Olbrich <stephanolbrich@gmx.de>
>
> The auxiliary spi supports only CPHA=0 modes as the first bit is
> always output to the pin before the first clock cycle. In CPHA=1
> modes the first clock edge outputs the second bit hence the slave
> can never read the first bit.

in case auxiliary spi isn't able to handle all modes shouldn't we report 
this to the upper layers?

Regards
