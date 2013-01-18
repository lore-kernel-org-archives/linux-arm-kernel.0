From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Jan 2013 20:32:18 +0100
Subject: [PATCH] pinctrl: mvebu: Fix compiler warnings
In-Reply-To: <1357756089-6028-1-git-send-email-andrew@lunn.ch>
References: <1357756089-6028-1-git-send-email-andrew@lunn.ch>
Message-ID: <CACRpkdb2VV0zcL6EzTZyHb5L4R9+3adpGYfqdwdkNPdy=Gih8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 9, 2013 at 7:28 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> match->data is const void * where as dev.platform_data is just void *.
> Add a cast to remove the const, which is causing the compiler warning:
>
> drivers/pinctrl/mvebu/pinctrl-kirkwood.c:461:26: warning: assignment
> discards 'const' qualifier from pointer target type
>
> Dove has the exact same warning, so gets the same cast.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied with Jason's ACK.

Thanks!
Linus Walleij
