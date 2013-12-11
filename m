From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 11 Dec 2013 10:01:03 -0800
Subject: [PATCH v3 01/36] mtd: st_spi_fsm: Allocate resources and
 register with MTD framework
In-Reply-To: <52A83258.5070506@st.com>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-2-git-send-email-lee.jones@linaro.org>
 <20131210204635.GD27149@ld-irv-0074.broadcom.com>
 <20131211084856.GF2390@lee--X1> <52A83258.5070506@st.com>
Message-ID: <20131211180103.GQ27149@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Angus,

On Wed, Dec 11, 2013 at 09:37:28AM +0000, Angus Clark wrote:
> At some stage, I would expect some of the device probing code in
> st_spi_fsm, particularly the configuration of read/write/erase operations based
> on capabilities, to be pulled into the 'spi-nor' framework.

Yes, I think this driver's device probing is starting to improve the ID
table approach that we currently have, which is why I directed a few
comments at it. I don't think it goes far enough to being useful to
others yet, though. It employs a few hacks that tie it very closely to
its own implementation, and I think this can be improved now, before its
methods are entrenched too much.

> I do not see this
> an an obstacle to st_spi_fsm being integrated earlier though; it's presence in
> the kernel would provide another example of a H/W Controller that 'spi-nor'
> needs to accommodate.

No, I don't think a generally-useful framework will pop up overnight,
but I think this driver can be one piece of the puzzle.

I await your further responses.

Thanks,
Brian
