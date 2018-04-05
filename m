From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 05 Apr 2018 13:24:31 -0700
Subject: [PATCH] clk: samsung: s3c: Mark expected switch fall-through
In-Reply-To: <20180404010931.GA30291@embeddedor.com>
References: <20180404010931.GA30291@embeddedor.com>
Message-ID: <152295987121.91052.16578276622043986934@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gustavo A. R. Silva (2018-04-03 18:09:31)
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced the comma wiht a dash,

s/wiht/with/

> which is what GCC is expecting to find when there are other comments
> in the same line in which "fall through" appears.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> This code was compiled with GCC 7.3.0

What's the GCC warning? Please include in the commit text.

Also what's the implicit-fallthrough level you're using? 3? Can you file
a bug so GCC can update their regex to accept a comma in addition to
whitespace characters?

And maybe we can change the level to 2 or 1 in the kernel's makefile so
we don't need to patch comments for this.
