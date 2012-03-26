From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Mar 2012 09:17:56 +0100
Subject: [PATCH] serial: pl011: implement workaround for CTS clear
 event issue
In-Reply-To: <1332748868-10172-1-git-send-email-linus.walleij@stericsson.com>
References: <1332748868-10172-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120326081756.GI5611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 10:01:08AM +0200, Linus Walleij wrote:
> -	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
> +	unsigned int status;

Why are you removing the pass counter and associated code, which was
there before your work-around patch was applied?
