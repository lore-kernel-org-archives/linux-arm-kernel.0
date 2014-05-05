From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 May 2014 13:40:22 -0700
Subject: [PATCH] net: macb: set interface name based on DT aliases
In-Reply-To: <1394620196-6295-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1394620196-6295-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140505204022.GA27961@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 11:29:56AM +0100, Boris BREZILLON wrote:
> Use aliases to set the interface name (ethX) instead of automatic
> assignement.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
> ---
> 
> Hello Nicolas, Jean-Christophe,
> 
> This is an example on how we could set the ethernet interface id based on DT
> aliases.
> As you can see this patch is not properly separated.
> 
> I'm still not happy with this approach for several reasons:
> 1) If another ethernet iface has already been registered with the same id the
>    net dev registration will fail.
> 2) We bypass the ethernet macros/functions and directly use the net device
>    functions which IMHO is not future proof.

[Sorry for the late reply, going through old backlog of unread email]

Looks like this should live in networking core instead of in the driver, it's
how we handle it in other subsystems.

I don't know what DaveM's opinions on that is though.


-Olof
