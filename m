From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Apr 2011 02:27:36 +0200
Subject: [PATCH] tty/serial/pl011: don't print error msg if
	dmaengine_pause is not supported
In-Reply-To: <98422bc7c3ebb4bf6a4ab26179b3f3b7d1a5b5ca.1303125086.git.viresh.kumar@st.com>
References: <98422bc7c3ebb4bf6a4ab26179b3f3b7d1a5b5ca.1303125086.git.viresh.kumar@st.com>
Message-ID: <BANLkTi=rhN1v0t00wUU3KrC5yATbWK9D5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/18 Viresh Kumar <viresh.kumar@st.com>:

> Few dma controller doesn't support dmaengine_pause() and return -ENXIO if
> dmaengine_pause() is called for them. Error messages such as "unable to pause
> DMA transfer" shouldn't be printed for them.

Hm for dw_dma this seems like a piece of cake to simply implement
instead.

I'll send a patch for that instead, can you test it and ACK it if it
works for you?

Yours,
Linus Walleij
