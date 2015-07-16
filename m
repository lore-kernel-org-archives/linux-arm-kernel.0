From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 10:21:02 +0200
Subject: [patch v2 1/2] pinctrl: samsung: don't truncate the last char
In-Reply-To: <20150622151223.GA14156@mwanda>
References: <20150619085203.GO28762@mwanda>
	<20150622151223.GA14156@mwanda>
Message-ID: <CACRpkdbG8Qm6tyrNqJJBb=cg9jR=CZsdhTksn_7XQXHGf5fNng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 5:12 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:

> We were allocating enough space because sizeof("-grp") and
> sizeof("-mux") are both equal to 5 but in the snprintf() we only allowed
> for 4 characters so the last 'p' and 'x' characters were truncated.
>
> The allocate and sprintf can be done in one step with the kasprintf().
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied with Krzysztof's review tag.

Yours,
Linus Walleij
