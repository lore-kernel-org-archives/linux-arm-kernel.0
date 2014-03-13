From: max.schwarz@online.de (Max Schwarz)
Date: Thu, 13 Mar 2014 20:25:43 +0100
Subject: [PATCH] ARM: rockchip: rk3188: enable pull-ups on UART inputs
In-Reply-To: <3174671.zfR1X00SEg@phil>
References: <6599423.XddAUl3dCe@typ> <3174671.zfR1X00SEg@phil>
Message-ID: <2567235.KcPFJfGIvp@typ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko,

> So I agree with you but would like to determine if we should also set the
> txd to pull down in one go, to restore the default pull setting of these
> pins or should leave them as is.
> Thoughts?
As soon as the UART is enabled, that TX pull-down does not do anything because 
the UART will actively drive the pin. I don't know what happens if the UART is 
suspended through runtime PM, though. I skimmed over the 8250_dw and saw 
support for that.

On the radxa board, there is even an external pull-up on the TX pin. The UART 
idle level is high, so that makes sense. If we wanted to pull the pin 
somewhere, I guess it should be up, not down. 

My vote would be to keep the patch as it is. In any case, it's an improvement 
of the status quo and does not change TX behavior.

Cheers,
  Max
