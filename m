From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 02 Mar 2013 23:15:35 +0000
Subject: [PATCH v5 01/16] spi/spi-atmel: fix master->num_chipselect
 wrongly set.
In-Reply-To: <1361861289-30332-2-git-send-email-wenyou.yang@atmel.com>
References: <1361861289-30332-1-git-send-email-wenyou.yang@atmel.com>
 <1361861289-30332-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130302231535.8E6043E35BE@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Feb 2013 14:47:54 +0800, Wenyou Yang <wenyou.yang@atmel.com> wrote:
> if the spi property "cs-gpios" is set as below:
> 
> 	cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
> 
> the master->num_chipselect will wrongly be set to 0,
> and the spi fail to probe.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: spi-devel-general at lists.sourceforge.net
> Cc: linux-kernel at vger.kernel.org

I think I've got this bug fixed in the core spi code. Give it a couple
of days and retest with linux-next.

g.
