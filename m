From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Feb 2011 13:13:09 +0000
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <4D5A100F.9000809@codeaurora.org>
References: <1297233693.242364.862698430999.1.gpush@pororo>
	<4D53749B.6010102@codeaurora.org>
	<201102151041.40655.jeremy.kerr@canonical.com>
	<4D5A100F.9000809@codeaurora.org>
Message-ID: <20110220131309.GF14495@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 09:33:03PM -0800, Saravana Kannan wrote:
> Assuming Russell and/or the community agrees on the semantics of  
> "parent", without the generic implementation grabbing the prepare_lock  
> while setting the parent, there is no way for the specific clock driver  
> implementations to cleanly ensure correctness. The only option for them  
> would be to peek into the generic clock struct and grab the prepare lock  
> -- to me that would be an ugly hack and/or layering violation that would  
> cause problems later on.
>
> Russell/All,
>
> What's the meaning of a parent clock? Do you agree with my definition --  
> "the parent clock is the clock that generates the clock signal from  
> which the child clock derives (divide, etc) it's clock signal from."? Or  
> is it open to interpretation by each implementation?

Your definition seems sane - I'm not sure what use a parent clock which
had nothing to do with a child would be.

As for the locking issue, I've no idea on that at the moment.  I don't
think implementations should grab the prepare lock, I think that's
something the generic code should take care of for clk_set_rate(),
clk_set_parent() etc.
