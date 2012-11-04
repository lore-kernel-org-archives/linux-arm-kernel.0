From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 4 Nov 2012 16:16:20 +0100
Subject: [PATCH net-next 2/2] cpsw: fix leaking IO mappings
In-Reply-To: <50966C6E.1000507@ti.com>
References: <cover.1351930782.git.richardcochran@gmail.com>
 <1c915a7d0301355342358db8f84560417609a61c.1351930782.git.richardcochran@gmail.com>
 <50966C6E.1000507@ti.com>
Message-ID: <20121104151620.GA2175@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 04, 2012 at 02:23:58PM +0100, Cyril Chemparathy wrote:
> On 11/03/2012 09:25 AM, Richard Cochran wrote:
> >The CPSW driver remaps two different IO regions, but fails to unmap them
> >both. This patch fixes the issue by calling iounmap in the appropriate
> >places.
> 
> Any thoughts on using devres helpers to keep the bail out path simpler?

I wasn't aware of devres before, but I just read through the doc. It
looks interesting, and if I were writting a new driver, then I might
use it.

But for this driver, it really isn't very complex. It only looks that
way, but I think this just accidental. I guess that the code was
adapted from the davinci emac driver.

Thanks,
Richard
