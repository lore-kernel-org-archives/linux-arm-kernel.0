From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 04 Jun 2014 22:32:46 +0200
Subject: ARM: debug: config DEBUG_UART_8250_WORD
Message-ID: <1401913966.23148.11.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The Kconfig entry for config DEBUG_UART_8250_WORD in
arch/arm/Kconfig.debug contains this dependency:
    depends on DEBUG_UART_8250_SHIFT >= 2

But, as far as I can see, the Kconfig syntax doesn't allow tests like
">=", ">", "<=", etc. And as a result this dependency is (silently!)
parsed as
    depends on DEBUG_UART_8250_SHIFT = 2

Something like this
    depends on DEBUG_UART_8250_SHIFT != "0" && DEBUG_UART_8250_SHIFT != "1"

does what was apparently intended. Should I submit a (basically untested
and) trivial patch to do that? Or would you prefer to find a more
elegant solution yourself?


Paul Bolle
