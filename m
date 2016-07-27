From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 27 Jul 2016 04:17:49 +0200
Subject: debug tip after earlycon is closed?
In-Reply-To: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
References: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
Message-ID: <20160727021748.GA9857@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 27, 2016 at 10:23:09AM +0900, Masahiro Yamada wrote:
> When the kernel fails to boot and its log console is silent,
> I use earlycon and I often find the cause of error with it.
> 
> But, I have been wondering if there is an easy-to-use
> debug tip which is available after earlycon is disabled.
> 
> I noticed the current mainline would not boot on my ARMv8 board.
> According to the following log, I am guessing something wrong
> is happening after the "bootconsole [uniphier0] disabled" log.
> 
> Is there a good practice to see more log?

Documentation/kernel-parameters.txt 
	keep_bootcon	[KNL]
			Do not unregister boot console at start. This is only
			useful for debugging when something happens in the window
			between unregistering the boot console and initializing
			the real console.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160727/9697ab95/attachment.sig>
