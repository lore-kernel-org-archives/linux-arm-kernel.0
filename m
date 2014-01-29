From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Jan 2014 09:07:09 +0100
Subject: [PATCH] clk: nomadik: fix multiplatform problem
In-Reply-To: <1390291581-5858-1-git-send-email-linus.walleij@linaro.org>
References: <1390291581-5858-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZjVoG4aHBegM=k7m7x1txTRdw1rMz0TjgiNT2WOyWNVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 9:06 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The Nomadik debugfs screws up multiplatform boots if debugfs
> is enabled on the multiplatform image, since it's a simple
> initcall that is unconditionally executed and reads from certain
> memory locations.
>
> Fix this by checking that the driver has been properly
> initialized, so a base offset to the Nomadik SRC controller
> exists, before proceeding to register debugfs files.
>
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Ping Mike, pls pick this for fixes!

Yours,
Linus Walleij
