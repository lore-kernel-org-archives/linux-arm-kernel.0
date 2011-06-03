From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 3 Jun 2011 17:02:11 +0530
Subject: [PATCH 2/3] davinci: dm6467/T EVM: pass reference clock rate to
	dm646x_init()
In-Reply-To: <BANLkTi=oj2Okguie+fje7oDRcPNcWMdAsw@mail.gmail.com>
References: <1307034677-27236-1-git-send-email-nsekhar@ti.com>
	<1307034677-27236-2-git-send-email-nsekhar@ti.com>
	<BANLkTi=oj2Okguie+fje7oDRcPNcWMdAsw@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D2D2D55@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Thu, Jun 02, 2011 at 23:31:05, Olof Johansson wrote:

> Do you foresee needing more members of the davinci_board_info struct
> in the near future? If so, this approach is OK. If this is the only
> anticipated use today, just passing in the refclk rate as an integer
> argument would be just as clean, with less infrastructure.

There was some discussion on passing PLL configuration information too.
So yes, the structure is likely extended in future.

Also, most boards end up using the reference clock used by the EVM.
In that case, with this approach, most boards just pass NULL instead of
replicating the reference clock frequency in all board files.

Thanks,
Sekhar
