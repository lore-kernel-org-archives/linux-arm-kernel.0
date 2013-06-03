From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 4 Jun 2013 00:31:02 +0200
Subject: [PATCH RFC 0/3] clk: dt: bindings for mux & divider clocks
In-Reply-To: <1370281990-15090-1-git-send-email-mturquette@linaro.org>
References: <1370281990-15090-1-git-send-email-mturquette@linaro.org>
Message-ID: <201306040031.02935.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 3. Juni 2013, 19:53:07 schrieb Mike Turquette:
> This series introduces binding definitions for common register-mapped
> clock multiplexor and divider IP blocks, and the corresponding setup
> functions once they are matched.  The bindings are close the struct
> definitions but please don't hold that against the binding: the struct
> definitions closely model the hardware.
> 
> The only missing basic clock type is the gate clock.  A binding for that
> was posted some time back and is similar in spirit to these[1].  I guess
> we'll need to decide whether register-level programming details belong
> in DT.  I believe they do since those details describe the hardware.
> 
> Note that there is still no generic clock driver that matches these
> basic types, but it would be trivial to write one.  Thoughts on that?
> Is it better for each of the basic clock types to be a driver that
> matches, or should there be one drivers/clk/clk-basic.c which matches
> all of the basic clock building blocks?  I like the latter for aesthetic
> purposes.
> 
> I am using this code while converting the OMAP4 clock data over to DT
> and some common boilerplate code can be factored out of several clock
> drivers if this is merged.

apart from the stuff pointed out in the replies to the patches this works 
really well on my upcoming Rockchip platform and saves quite a lot silly clock 
definitions whose only purpose is to hold the shift and width values.


So, for this series:

Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Heiko Stuebner <heiko@sntech.de>
