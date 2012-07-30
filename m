From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Jul 2012 21:10:58 +0200
Subject: [PATCH 4/6] kirkwood: setup clock only in eth helpers.
In-Reply-To: <5016BBE9.40604@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-5-git-send-email-ian.molton@codethink.co.uk>
 <20120730161230.GM18016@lunn.ch> <5016BBE9.40604@codethink.co.uk>
Message-ID: <20120730191058.GC12756@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I find that even if built in, it fails, not because it forgets its MAC, but
> later, it hangs because as yet it does not know how to handle the clk
> when it is set up from DT bindings. (Kirkwood doesnt really have this
> support yet AFAICT).

Ah, of course. You are missing auxdata in board-dt.c!

    Andrew
