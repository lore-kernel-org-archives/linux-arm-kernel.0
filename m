From: eric@anholt.net (Eric Anholt)
Date: Thu, 13 Aug 2015 16:05:39 -0700
Subject: Rasperry Pi clock support
Message-ID: <1439507142-2965-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm also avoiding requests to set rate/state when they're a no-op, as
apparently no-op changes to pixel clock break the firmware-configured
display setup.  It *shouldn't* change anything, but I've confirmed
that setting the CPU clock works fine, and after a couple of weeks of
prodding pixel clock now, I'm at a loss for what's going on with it.
