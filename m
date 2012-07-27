From: robherring2@gmail.com (Rob Herring)
Date: Fri, 27 Jul 2012 07:33:36 -0500
Subject: [DT] API to determine if interrupt is PPI or SPI ?
In-Reply-To: <53a41d02c4c4c24bdab47667183891bf.squirrel@www.codeaurora.org>
References: <53a41d02c4c4c24bdab47667183891bf.squirrel@www.codeaurora.org>
Message-ID: <50128AA0.8040409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2012 02:18 PM, rvaswani at codeaurora.org wrote:
> Hello,
> 
> We can specify the interrupt information in the device tree using the arm
> gic convention.
> Is there an API to read directly the 1st cell and determine if an
> interrupt is a PPI or a SPI ? This information is directly relevant to the
> driver because it needs to call request_irq or request_percpu_irq based on
> this data.
> 
> How should this be done ideally ?

Seems a bit strange to me that you would have a h/w block that can be
connected either way...

Perhaps the irq resource should have a flag for percpu irq.

Rob
