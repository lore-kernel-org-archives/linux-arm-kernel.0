From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 26 Jun 2018 06:37:24 +0300
Subject: [PATCH v2 06/23] thermal: armada: convert driver to syscon
 register accesses
In-Reply-To: <20180625151239.20976-7-miquel.raynal@bootlin.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-7-miquel.raynal@bootlin.com>
Message-ID: <20180626033724.q7radxgjeqtsl7ae@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

On Mon, Jun 25, 2018 at 05:12:22PM +0200, Miquel Raynal wrote:
> Until recently, only one register was referenced in MVEBU thermal IP
> node. Recent changes added a second entry pointing to another
> register right next to it. We cannot know for sure that we will not
> have to access other registers. That will be actually the case when
> overheat interrupt feature will come, where it will be needed to access
> DFX registers in the same area.
> 
> This approach is not scalable so intead of adding consinuously memory
> areas in the DT (and change de DT bindings, while keeping backward

s/de/the/

> compatibility), move the thermal node into a wider syscon from which it
> will be possible to also configure the thermal interrupt.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
