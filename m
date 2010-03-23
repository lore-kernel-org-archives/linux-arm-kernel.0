From: ibr@radix50.net (Baurzhan Ismagulov)
Date: Tue, 23 Mar 2010 16:45:16 +0100
Subject: [PATCH] Voipac PXA270
In-Reply-To: <20100323140727.GZ30801@buzzloop.caiaq.de>
References: <201003100247.27059.marek.vasut@gmail.com>
	<201003101237.26819.marek.vasut@gmail.com>
	<20100310133529.GK28972@buzzloop.caiaq.de>
	<201003101620.17501.marek.vasut@gmail.com>
	<f17812d71003211910u1ae21bc4ofea3bb8b61b41e45@mail.gmail.com>
	<20100323132109.GD9581@radix50.net>
	<20100323140727.GZ30801@buzzloop.caiaq.de>
Message-ID: <20100323154515.GE9581@radix50.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 23, 2010 at 03:07:27PM +0100, Daniel Mack wrote:
> > What is the recommended method to abstract that? For example, I have two
> > boards with different GPIO pins assigned to mean certain external
> > signals. I also ended up with GPIO definitions in a header, which is
> > used by the driver, and I'd like to clean this up.
> 
> Make up a struct to pass as platform_data. Fill it in your board code
> and pass down a reference to the actual driver. The driver code should
> then only use resources referenced by the platform data.

Thanks! This is what I was looking for.


> This is common practice, just have a look how most other driver do it.

Yes, easy when one knows what to grep for ;) . My driver didn't have
platform_device yet, so I'll have to do that first.


With kind regards,
-- 
Baurzhan Ismagulov
http://www.kz-easy.com/
